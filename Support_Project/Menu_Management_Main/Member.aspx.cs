using Support_Project.core;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Support_Project.Menu_Management_Main
{
    public partial class Member : System.Web.UI.Page
    {
        SqlManager _sql = new SqlManager();
        public static string PageNow;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string[] cookies = Request.Cookies.AllKeys;
                bool status = false;
                foreach (string cookie in cookies)
                {
                    if (cookie.ToString() == "Keys")
                    {
                        status = true;
                    }
                }

                if (status == true)
                {
                    LevelSearch.Value = "0";
                    MemberIDSearch.Value = Request.Cookies["Keys"]["ID"];
                    MemberName.Value = Request.Cookies["Keys"]["Username"];
                    AgentIDSearch.Value = Request.Cookies["Keys"]["Agent_ID"].ToString();

                    if (Request.Cookies["Keys"]["Agent_ID"] == "0" && Request.Cookies["Keys"]["Company_ID"] == "0")
                    {
                        CompanySearch.Value = "0";
                        BindLevel();
                    }
                    else
                    {
                        ddlCompanySearch.Items.Clear();
                        ddlCompanySearch.DataSource = _sql.getAllCompany();
                        ddlCompanySearch.DataBind();
                        ddlCompanySearch.SelectedValue = Request.Cookies["Keys"]["Company_ID"].ToString();
                        ddlCompanySearch.Attributes.Add("disabled", "disabled");

                        ddllevelSearch.DataSource = _sql.getAllRole();
                        ddllevelSearch.DataBind();
                        ddllevelSearch.Items.Insert(0, new ListItem("All", "0"));

                        ddlAgentSearch.Items.Clear();
                        ddlAgentSearch.DataSource = _sql.getAllAgent(int.Parse(Request.Cookies["Keys"]["Company_ID"].ToString()), _sql.allAgentMaster(), int.Parse(Request.Cookies["Keys"]["Agent_ID"]));
                        ddlAgentSearch.DataBind();
                        ddlAgentSearch.Items.Insert(0, new ListItem("All", "0"));
                        //ddlAgentSearch.SelectedValue = Request.Cookies["Keys"]["Agent_ID"].ToString();
                    }
                    IDRole.Value = Request.Cookies["Keys"]["Position"];
                    IDAgent.Value = Request.Cookies["Keys"]["Agent_ID"];
                    IDCompany.Value = Request.Cookies["Keys"]["Company_ID"];
                    ShareIDLogin.Value = Request.Cookies["Keys"]["Company_ID"];
                    AgentIDLogin.Value = Request.Cookies["Keys"]["Agent_ID"];
                    PageNow = "1";

                    SearchData();
                }
                else
                {
                    Response.Redirect("../Login.aspx");
                }
            }
        }

        private void BindLevel()
        {
            try
            {
                ddlLevel.DataSource = _sql.getAllRole();
                ddlLevel.DataBind();
                ddlLevel.Items.Insert(0, new ListItem("Select level", ""));

                ddllevelSearch.DataSource = _sql.getAllRole();
                ddllevelSearch.DataBind();
                ddllevelSearch.Items.Insert(0, new ListItem("All", "0"));

                ddlCompany.DataSource = _sql.getAllCompany();
                ddlCompany.DataBind();
                ddlCompany.Items.Insert(0, new ListItem("Select company", ""));

                ddlCompanySearch.DataSource = _sql.getAllCompany();
                ddlCompanySearch.DataBind();
                ddlCompanySearch.Items.Insert(0, new ListItem("All", "0"));

                ddlAgentSearch.Items.Insert(0, new ListItem("All", "0"));

                ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "SetLan(localStorage.getItem('Language'));", true);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void GetSharholder_click(object sender, EventArgs e)
        {
            ddlLevel.DataSource = _sql.getAllRole();
            ddlLevel.DataBind();
            ddlLevel.Items.Insert(0, new ListItem("Select level", ""));

            ddlCompany.DataSource = _sql.getAllCompany();
            ddlCompany.DataBind();
            ddlCompany.Items.Insert(0, new ListItem("Select company", ""));

            ddlAgent.DataSource = _sql.getAllAgent(int.Parse(CompanyView.Value), _sql.allAgentMaster(), int.Parse(Request.Cookies["Keys"]["Agent_ID"]));
            ddlAgent.DataBind();
            ddlAgent.Items.Insert(0, new ListItem("Select agent", ""));

            ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "getViewModal();", true);
        }

        protected void getDropdownAgentSearch(object sender, EventArgs e)
        {
            ddlAgentSearch.Items.Clear();

            ddlAgentSearch.DataSource = _sql.getAllAgent(int.Parse(ddlCompanySearch.SelectedValue), _sql.allAgentMaster(), int.Parse(Request.Cookies["Keys"]["Agent_ID"]));
            ddlAgentSearch.DataBind();
            ddlAgentSearch.Items.Insert(0, new ListItem("All", "0"));

            ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "SetLan(localStorage.getItem('Language'));", true);
        }

        protected void getDropdownAgent(object sender, EventArgs e)
        {
            ddlAgent.Items.Clear();

            ddlAgent.DataSource = _sql.getAllAgent(int.Parse(ddlCompany.SelectedValue), _sql.allAgentMaster(), int.Parse(Request.Cookies["Keys"]["Agent_ID"]));
            ddlAgent.DataBind();
            ddlAgent.Items.Insert(0, new ListItem("Select agent", ""));

            ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "disDropdown();", true);
        }

        public void DeleteMember_click(Object sender, EventArgs e)
        {
            try { 
            int _idDel = _sql.DeleteMember(int.Parse(IDDelete.Value), int.Parse(Request.Cookies["Keys"]["ID"]));
            if (_idDel != 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModal('Delete account success.');", true);
                SearchData();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModal('Data recording failed.');", true);
            }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Error : " + ex.Message + "')", true);
            }
        }

        public void ReQR_click(Object sender, EventArgs e)
        {
            try { 
            int _idDel = _sql.ReQR(int.Parse(IDReQR.Value));
            if (_idDel != 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModal('Reset QR success.');", true);
                SearchData();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModal('Data recording failed.');", true);
            }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Error : " + ex.Message + "')", true);
            }
        }

        public void EditMember_click(Object sender, EventArgs e)
        {
            try { 
            int _idChk = _sql.CheckUsername(username.Text, int.Parse(IDEdit.Value));
            if (_idChk == 0)
            {
                int _id = _sql.EditMember(int.Parse(IDEdit.Value), username.Text, Utility.Encryptdata2(password.Text), int.Parse(LevelEdit.Value), contact.Text, int.Parse(Request.Cookies["Keys"]["ID"]), int.Parse(StatusEdit.Value), name.Text, int.Parse(CompanyEdit.Value), int.Parse(AgentEdit.Value));
                if (_id != 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertModal('Edit account success.');", true);
                    SearchData();
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModal('Data recording failed.');", true);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModalDuplicate('Username is duplicate.');", true);
            }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Error : " + ex.Message + "')", true);
            }
        }

        public void Search_click(Object sender, EventArgs e)
        {
            SearchData();
        }

        private void SearchData()
        {
            try { 
            DataTable table = new DataTable();

            LevelSearch.Value = ddllevelSearch.SelectedValue;
            CompanySearch.Value = ddlCompanySearch.SelectedValue;

            if (getParent.Value == "No")
            {
                MemberSearch.Value = Request.Cookies["Keys"]["ID"];
            }
            else
            {
                MemberSearch.Value = MemberIDSearch.Value;
            }

            AgentSearch.Value = AgentIDSearch.Value;

            if (searchUsername.Text == "" && getParent.Value == "No" && AgentSearch.Value == "0")
            {
                AgentSearch.Value = Request.Cookies["Keys"]["Agent_ID"];
            }

            var masterAgent = "";
            if (searchUsername.Text != "")
            {
                //AgentSearch.Value = Request.Cookies["Keys"]["Agent_ID"];
                masterAgent = _sql.allAgentMaster();
            }
            else
            {
                var arrAgentMaster = new List<string>();
                DataTable tableAgent = new DataTable();
                tableAgent = _sql.GetMasterAgent(int.Parse(AgentSearch.Value));
                int c = 1;
                if (tableAgent.Rows.Count > 0)
                {
                    foreach (DataRow row in tableAgent.Rows)
                    {
                        if (c == 1)
                        {
                            arrAgentMaster.Add(row["id"].ToString());
                        }
                    }
                }
                masterAgent = string.Join(",", arrAgentMaster);
            }

            int _idTotal = 0;
            _idTotal = _sql.SearchMemberPaging(searchUsername.Text, int.Parse(LevelSearch.Value), masterAgent, int.Parse(CompanySearch.Value), int.Parse(MemberSearch.Value), int.Parse(AgentSearch.Value));

            totalDocs.Value = _idTotal.ToString();

            if (thisPage.Value == "" || thisPage.Value == null)
            {
                PageNow = "1";
            }
            else
            {
                PageNow = thisPage.Value;
            }           

            StringBuilder sb = new StringBuilder();
            var no = 1;
            table = _sql.SearchMember(searchUsername.Text, int.Parse(LevelSearch.Value), masterAgent, int.Parse(CompanySearch.Value), int.Parse(PageNow), 100, int.Parse(MemberSearch.Value), int.Parse(AgentSearch.Value));
            if (table != null && table.Rows.Count > 0)
            {
                foreach (DataRow row in table.Rows)
                {
                    sb.Append("<tr>");
                    sb.Append("<td style='text-align: center;'>" + (((int.Parse(PageNow) - 1) * 100) + no) + "</td>");
                    if (int.Parse(row["count_parent"].ToString()) > 0)
                    {
                        sb.Append("<td><a class='link overflowTable ellipsis' title='" + row["username"].ToString() + "' onclick='getParentAgent(" + row["id"].ToString() + " , \"" + row["username"].ToString() + "\", " + row["agent_id"].ToString() + ");'>" + row["username"].ToString() + "</a></td>");
                    }
                    else
                    {
                        sb.Append("<td><p class='overflowTable ellipsis' title='" + row["username"].ToString() + "'>" + row["username"].ToString() + "</p></td>");
                    }
                    sb.Append("<td><p class='overflowTable ellipsis' title='" + row["fullname"].ToString() + "'>" + row["fullname"].ToString() + "</p></td>");
                    if (row["contact"].ToString() != "" && row["contact"].ToString() != null)
                    {
                        sb.Append("<td><a style='text-decoration: underline;' class='overflowTable ellipsis' href='tel: +" + row["contact"].ToString() + "' title='" + row["contact"].ToString() + "'>" + row["contact"].ToString() + "</a></td>");
                    }
                    else
                    {
                        sb.Append("<td>-</td>");
                    }
                    sb.Append("<td style='text-align: center;'>" + row["role_name"].ToString() + "</td>");

                    sb.Append("<td><p class='overflowTable ellipsis' title='" + row["shareholder_name"].ToString() + "'>" + row["shareholder_name"].ToString() + "</p></td>");
                    sb.Append("<td><p class='overflowTable ellipsis' title='" + row["agent_name"].ToString() + "'>" + row["agent_name"].ToString() + "</p></td>");

                    var dateLogin = "";
                    if (row["login_date"].ToString() != "" && row["login_date"].ToString() != null)
                    {
                        DateTime oDateLog = Convert.ToDateTime(row["login_date"].ToString());
                        string xLog = oDateLog.ToString("dd-MM-yyyy HH:mm", CultureInfo.InvariantCulture);
                        dateLogin = xLog;
                    }
                    else
                    {
                        dateLogin = "-";
                    }
                    var dateCreated = "";
                    if (row["create_date"].ToString() != "" && row["create_date"].ToString() != null)
                    {
                        DateTime oDateCreate = Convert.ToDateTime(row["create_date"].ToString());
                        string xCreate = oDateCreate.ToString("dd-MM-yyyy HH:mm", CultureInfo.InvariantCulture);
                        dateCreated = xCreate;
                    }
                    else
                    {
                        dateCreated = "-";
                    }

                    sb.Append("<td style='text-align: center;'>" + dateLogin.ToString() + "</td>");
                    sb.Append("<td style='text-align: center;'>" + dateCreated.ToString() + "</td>");
                    sb.Append("<td style='text-align: center;'>" + row["status"].ToString() + "</td>");

                    if (Request.Cookies["Keys"]["Position"] == "Master" || Request.Cookies["Keys"]["Position"] == "Super User")
                    {
                        if (row["create_by"].ToString() == Request.Cookies["Keys"]["ID"] || Request.Cookies["Keys"]["ID"] == "2")
                        {
                            sb.Append("<td style='text-align: center;'><a class='link' onclick='viewReQR(\"" + row["id"].ToString() + "\");'><i class='fas fa-sync-alt'></i></a>&emsp;<a class='link' attr-fullname='" + row["fullname"].ToString() + "' attr-id='" + row["id"].ToString() + "' attr-username='" + row["username"].ToString() + "' attr-password='" + Utility.Decryptdata(row["password"].ToString()) + "' attr-contact='" + row["contact"].ToString() + "' attr-role='" + row["role_name"].ToString() + "' attr-agent='" + row["agent_id"].ToString() + "' attr-share='" + row["shareholder_id"].ToString() + "' attr-status='" + row["is_active"].ToString() + "' onclick='viewEdit(this);'><i class='fas fa-pencil-alt'></i></a>&emsp;<a class='link' onclick='viewDelete(\"" + row["id"].ToString() + "\");'><i class='fas fa-trash'></i></a></td>");
                        }
                        else
                        {
                            sb.Append("<td style='text-align: center;'><a class='link disabled-link'><i class='fas fa-sync-alt'></i></a>&emsp;<a class='link disabled-link'><i class='fas fa-pencil-alt'></i></a>&emsp;<a class='link disabled-link'><i class='fas fa-trash'></i></a></td>");
                        }
                    }
                    else
                    {
                        sb.Append("<td style='text-align: center;'><a class='link disabled-link'><i class='fas fa-sync-alt'></i></a>&emsp;<a class='link disabled-link'><i class='fas fa-pencil-alt'></i></a>&emsp;<a class='link disabled-link'><i class='fas fa-trash'></i></a></td>");
                    }
                    sb.Append("</tr>");
                    no++;
                }
            }

            if (sb.ToString() == "")
            {
                sb.Append("<tr><td colspan='11' style='text-align: center;' set-lan='text:No Data.'></td></tr>");
            }

            LiteralData.Text = sb.ToString();

            if (eventPaging.Value != "paging")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "GetData('" + _idTotal.ToString() + "');", true);
            }

            ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "setDataLanguage();", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Error : " + ex.Message + "')", true);
            }
        }
    }
}