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
    public partial class SubAccount : System.Web.UI.Page
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
                    BindLevel();
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

                ScriptManager.RegisterStartupScript(this, this.GetType(), "SetLan", "SetLan(localStorage.getItem('Language'));", true);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void DeleteMember_click(Object sender, EventArgs e)
        {
            try { 
            int _idDel = _sql.DeleteMember(int.Parse(IDDelete.Value), int.Parse(Request.Cookies["Keys"]["ID"]));
            if (_idDel != 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertModal", "alertModal('Delete sub account success.');", true);
                SearchData();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertModal", "alertModal('Data recording failed.');", true);
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
                int _id = _sql.EditMember(int.Parse(IDEdit.Value), username.Text, Utility.Encryptdata2(password.Text), int.Parse(LevelEdit.Value), contact.Text, int.Parse(Request.Cookies["Keys"]["ID"]), int.Parse(StatusEdit.Value), name.Text, int.Parse(Request.Cookies["Keys"]["Company_ID"]), int.Parse(Request.Cookies["Keys"]["Agent_ID"]));
                if (_id != 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alertModal", "alertModal('Edit sub account success.');", true);
                    SearchData();
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alertModal", "alertModal('Data recording failed.');", true);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertModalDuplicate", "alertModalDuplicate('Username is duplicate.');", true);
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
            AgentSearch.Value = Request.Cookies["Keys"]["Agent_ID"];
            MemberSearch.Value = Request.Cookies["Keys"]["ID"];
            CompanySearch.Value = Request.Cookies["Keys"]["Company_ID"];

            int _idTotal = 0;
            _idTotal = _sql.SearchSubAccountPaging(searchUsername.Text, int.Parse(LevelSearch.Value), int.Parse(Request.Cookies["Keys"]["ID"]));
            totalDocs.Value = _idTotal.ToString();

            if (thisPage.Value == "" || thisPage.Value == null)
            {
                PageNow = "1";
            }
            else
            {
                PageNow = thisPage.Value;
            }

            table = _sql.SearchSubAccount(searchUsername.Text, int.Parse(LevelSearch.Value), int.Parse(PageNow), 100, int.Parse(Request.Cookies["Keys"]["ID"]));
            if (table != null && table.Rows.Count > 0)
            {
                var no = 1;
                StringBuilder sb = new StringBuilder();
                foreach (DataRow row in table.Rows)
                {
                    sb.Append("<tr>");
                    sb.Append("<td style='text-align: center;'>" + (((int.Parse(PageNow) - 1) * 100) + no) + "</td>");
                    sb.Append("<td><p class='overflowTable ellipsis' title='" + row["username"].ToString() + "'>" + row["username"].ToString() + "</p></td>");
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
                        sb.Append("<td style='text-align: center;'><a class='link' attr-fullname='" + row["fullname"].ToString() + "' attr-id='" + row["id"].ToString() + "' attr-username='" + row["username"].ToString() + "' attr-password='" + Utility.Decryptdata(row["password"].ToString()) + "' attr-contact='" + row["contact"].ToString() + "' attr-role='" + row["role_name"].ToString() + "' attr-agent='" + row["agent_id"].ToString() + "' attr-share='" + row["shareholder_id"].ToString() + "' attr-status='" + row["is_active"].ToString() + "' onclick='viewEdit(this);'><i class='fas fa-pencil-alt'></i></a>&emsp;<a class='link' onclick='viewDelete(\"" + row["id"].ToString() + "\");'><i class='fas fa-trash'></i></a></td>");
                    }
                    else
                    {
                        sb.Append("<td style='text-align: center;'><a class='link disabled-link'><i class='fas fa-pencil-alt'></i></a>&emsp;<a class='link disabled-link'><i class='fas fa-trash'></i></a></td>");
                    }
                    sb.Append("</tr>");
                    no++;
                }

                LiteralData.Text = sb.ToString();
            }
            else
            {
                StringBuilder sb = new StringBuilder();
                sb.Append("<tr><td colspan='11' style='text-align: center;' set-lan='text:No Data.'></td></tr>");
                LiteralData.Text = sb.ToString();
            }

            if (eventPaging.Value != "paging")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "GetData", "GetData('" + _idTotal.ToString() + "');", true);
            }

            ScriptManager.RegisterStartupScript(this, this.GetType(), "setDataLanguage", "setDataLanguage();", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Error : " + ex.Message + "')", true);
            }
        }
    }
}