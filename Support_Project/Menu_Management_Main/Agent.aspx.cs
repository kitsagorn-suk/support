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
    public partial class Agent : System.Web.UI.Page
    {
        SqlManager _sql = new SqlManager();
        String allagentmaster = "";
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
                    allagentmaster = _sql.allAgentMaster();
                    BindCompany();
                    CompanySearch.Value = Request.Cookies["Keys"]["Company_ID"];
                    ShareIDLogin.Value = Request.Cookies["Keys"]["Company_ID"];
                    AgentIDSearch.Value = Request.Cookies["Keys"]["Agent_ID"];
                    if (Request.Cookies["Keys"]["Agent_Name"] == "-")
                    {
                        AgentName.Value = "All";
                    }
                    else
                    {
                        AgentName.Value = Request.Cookies["Keys"]["Agent_Name"];
                    }

                    SearchData();
                    PageNow = "1";
                }
                else
                {
                    Response.Redirect("../Login.aspx");
                }
            }
        }

        private void BindCompany()
        {
            try
            {
                ddlCompany.DataSource = _sql.getAllCompany();
                ddlCompany.DataBind();
                ddlCompany.Items.Insert(0, new ListItem("Select company", ""));

                ListItem item = ddlCompany.Items[0];
                item.Attributes["set-lan"] = "text:Select company";

                ddlCompanySearch.DataSource = _sql.getAllCompany();
                ddlCompanySearch.DataBind();
                ddlCompanySearch.Items.Insert(0, new ListItem("All", "0"));

                ListItem item2 = ddlCompanySearch.Items[0];
                item2.Attributes["set-lan"] = "text:All";
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void Search_click(Object sender, EventArgs e)
        {
            SearchData();
        }

        private void SearchData()
        {
            try { 
            if (getParent.Value == "No")
            {
                AgentIDSearch.Value = allagentmaster;
            }

            if (searchName.Text == "" && getParent.Value == "No")
            {
                AgentIDSearch.Value = Request.Cookies["Keys"]["Agent_ID"];
            }

            DataTable table = new DataTable();

            int _idTotal = 0;
            _idTotal = _sql.SearcAgentPaging(searchName.Text, int.Parse(CompanySearch.Value), AgentIDSearch.Value);
            totalDocs.Value = _idTotal.ToString();

            if (thisPage.Value == "" || thisPage.Value == null)
            {
                PageNow = "1";
            }
            else
            {
                PageNow = thisPage.Value;
            }

            table = _sql.SearchAgent(searchName.Text, int.Parse(CompanySearch.Value), int.Parse(PageNow), 100, AgentIDSearch.Value);
            if (table != null && table.Rows.Count > 0)
            {
                var no = 1;
                StringBuilder sb = new StringBuilder();
                foreach (DataRow row in table.Rows)
                {
                    sb.Append("<tr>");
                    sb.Append("<td style='text-align: center;'>" + (((int.Parse(PageNow) - 1) * 100) + no) + "</td>");
                    if (int.Parse(row["count_parent"].ToString()) > 0)
                    {
                        sb.Append("<td><a class='link overflowTable ellipsis' title='" + row["name"].ToString() + "' onclick='getParentAgent(" + row["id"].ToString() + " , \"" + row["name"].ToString() + "\");'>" + row["name"].ToString() + "</a></td>");
                    }
                    else
                    {
                        sb.Append("<td><p class='overflowTable ellipsis' title='" + row["name"].ToString() + "'>" + row["name"].ToString() + "</p></td>");
                    }
                    sb.Append("<td><p class='overflowTable ellipsis' title='" + row["prefix"].ToString() + "'>" + row["prefix"].ToString() + "</p></td>");
                    sb.Append("<td><p class='overflowTable ellipsis' title='" + row["shareholder_name"].ToString() + "'>" + row["shareholder_name"].ToString() + "</p></td>");
                    if (row["description"].ToString() != "" && row["description"].ToString() != null)
                    {
                        sb.Append("<td><p class='overflowTable ellipsis' title='" + row["description"].ToString() + "'>" + row["description"].ToString() + "</p></td>");
                    }
                    else
                    {
                        sb.Append("<td>-</td>");
                    }
                    if (row["remark"].ToString() != "" && row["remark"].ToString() != null)
                    {
                        sb.Append("<td><p class='overflowTable ellipsis' title='" + row["remark"].ToString() + "'>" + row["remark"].ToString() + "</p></td>");
                    }
                    else
                    {
                        sb.Append("<td>-</td>");
                    }

                    var dateCreate = "";
                    if (row["create_date"].ToString() != "" && row["create_date"].ToString() != null)
                    {
                        DateTime oDateLog = Convert.ToDateTime(row["create_date"].ToString());
                        string xLog = oDateLog.ToString("dd-MM-yyyy HH:mm", CultureInfo.InvariantCulture);
                        dateCreate = xLog;
                    }
                    else
                    {
                        dateCreate = "-";
                    }

                    sb.Append("<td style='text-align: center;'>" + dateCreate.ToString() + "</td>");
                    sb.Append("<td><p class='overflowTable ellipsis' title='" + row["create_by_name"].ToString() + "'>" + row["create_by_name"].ToString() + "</p></td>");
                    var txtDesc = row["description"].ToString().Replace("\n", "<br/>");
                    var txtRemark = row["remark"].ToString().Replace("\n", "<br/>");
                    sb.Append("<td style='text-align: center;'><a class='link' attr-share='" + row["shareholder_name"].ToString() + "' attr-id='" + row["id"].ToString() + "' attr-name='" + row["name"].ToString() + "' attr-prefix='" + row["prefix"].ToString() + "' attr-desc='" + txtDesc.ToString() + "' attr-remark='" + txtRemark.ToString() + "' onclick='viewEdit(this);'><i class='fas fa-pencil-alt'></i></a>&emsp;<a class='link' onclick='getDelete(\"" + row["id"].ToString() + "\");'><i class='fas fa-trash'></i></a></td>");
                    sb.Append("</tr>");
                    no++;
                }

                LiteralData.Text = sb.ToString();
            }
            else
            {
                StringBuilder sb = new StringBuilder();
                sb.Append("<tr><td colspan='9' style='text-align: center;' set-lan='text:No Data.'></td></tr>");
                LiteralData.Text = sb.ToString();
            }

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

        public void DeleteAgent_click(Object sender, EventArgs e)
        {
            try
            {
                int _idDel = _sql.DeleteAgent(int.Parse(IDDelete.Value), int.Parse(Request.Cookies["Keys"]["ID"]));
                if (_idDel != 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModal('Delete agent success.');", true);
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

        public void EditAgent_click(Object sender, EventArgs e)
        {
            try { 
            int _idChk = _sql.CheckAgent(Name.Text, int.Parse(IDEdit.Value));
            if (_idChk == 0)
            {
                int _id = _sql.EditAgent(int.Parse(IDEdit.Value), Name.Text, Prefix.Text, Description.Text, Remark.Text, int.Parse(CompanyAdd.Value), int.Parse(Request.Cookies["Keys"]["ID"]));
                if (_id != 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModal('Edit agent success.');", true);
                    SearchData();
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModal('Data recording failed.');", true);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModalDuplicate('Name is duplicate.');", true);
            }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Error : " + ex.Message + "')", true);
            }
        }
    }
}