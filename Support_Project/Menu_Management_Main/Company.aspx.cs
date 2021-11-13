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
    public partial class Company : System.Web.UI.Page
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
                    SearchData();
                    PageNow = "1";
                }
                else
                {
                    Response.Redirect("../Login.aspx");
                }
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

            if (AgentSearch.Value == "")
            {
                AgentSearch.Value = "0";
            }

            int _idTotal = 0;
            _idTotal = _sql.SearcCompanyPaging(searchName.Text);
            totalDocs.Value = _idTotal.ToString();

            if (thisPage.Value == "" || thisPage.Value == null)
            {
                PageNow = "1";
            }
            else
            {
                PageNow = thisPage.Value;
            }

            table = _sql.SearchCompany(searchName.Text, int.Parse(PageNow), 100);
            if (table != null && table.Rows.Count > 0)
            {
                var no = 1;
                StringBuilder sb = new StringBuilder();
                foreach (DataRow row in table.Rows)
                {
                    sb.Append("<tr>");
                    sb.Append("<td style='text-align: center;'>" + (((int.Parse(PageNow) - 1) * 100) + no) + "</td>");
                    sb.Append("<td><p class='overflowTable ellipsis' title='" + row["name"].ToString() + "'>" + row["name"].ToString() + "</p></td>");
                    sb.Append("<td><p class='overflowTable ellipsis' title='" + row["prefix"].ToString() + "'>" + row["prefix"].ToString() + "</p></td>");
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
                    sb.Append("<td style='text-align: center;'>" + row["create_by_name"].ToString() + "</td>");
                    var txtDesc = row["description"].ToString().Replace("\n", "<br/>");
                    var txtRemark = row["remark"].ToString().Replace("\n", "<br/>");
                    sb.Append("<td style='text-align: center;'><a class='link' attr-id='" + row["id"].ToString() + "' attr-name='" + row["name"].ToString() + "' attr-prefix='" + row["prefix"].ToString() + "' attr-desc='" + txtDesc.ToString() + "' attr-remark='" + txtRemark.ToString() + "' onclick='viewEdit(this);'><i class='fas fa-pencil-alt'></i></a>&emsp;<a class='link' onclick='getDelete(\"" + row["id"].ToString() + "\");'><i class='fas fa-trash'></i></a></td>");
                    sb.Append("</tr>");
                    no++;
                }

                LiteralData.Text = sb.ToString();
            }
            else
            {
                StringBuilder sb = new StringBuilder();
                sb.Append("<tr><td colspan='8' style='text-align: center;' set-lan='text:No Data.'></td></tr>");
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

        public void DeleteCompany_click(Object sender, EventArgs e)
        {
            try { 
            int _idDel = _sql.DeleteCompany(int.Parse(IDDelete.Value), int.Parse(Request.Cookies["Keys"]["ID"]));
            if (_idDel != 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModal('Delete company success.');", true);
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

        public void EditCompany_click(Object sender, EventArgs e)
        {
            try { 
            int _idChk = _sql.CheckCompany(Name.Text, int.Parse(IDEdit.Value));
            if (_idChk == 0)
            {
                int _id = _sql.EditCompany(int.Parse(IDEdit.Value), Name.Text, Prefix.Text, Description.Text, Remark.Text, int.Parse(Request.Cookies["Keys"]["ID"]));
                if (_id != 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModal('Edit company success.');", true);
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