using Support_Project.core;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Threading;
using System.Threading.Tasks;

namespace Support_Project.Menu_Feedback
{
    public partial class Feedback : System.Web.UI.Page
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
                    BindAgent();
                    AgentID.Value = Request.Cookies["Keys"]["Agent_ID"];

                    if (int.Parse(Request.Cookies["Keys"]["Agent_ID"]) > 1)
                    {
                        AgentSearch.Value = Request.Cookies["Keys"]["Agent_ID"];
                    }
                    else
                    {
                        AgentSearch.Value = "0";
                    }
                    
                    searchDateStart.Value = DateTime.Now.ToString("yyyy-MM-dd") + " 00:00:00";
                    searchDateTo.Value = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");

                    SearchData();
                }
                else
                {
                    Response.Redirect("../Login.aspx");
                }
            }
        }

        private void BindAgent()
        {
            try
            {
                ddlAgentSearch.DataSource = _sql.getAllAgent(int.Parse(Request.Cookies["Keys"]["Company_ID"]), _sql.allAgentMaster(), int.Parse(Request.Cookies["Keys"]["Agent_ID"]));
                ddlAgentSearch.DataBind();
                ddlAgentSearch.Items.Insert(0, new ListItem("All", "0"));

                ListItem item = ddlAgentSearch.Items[0];
                item.Attributes["set-lan"] = "text:All";

                ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "SetLan(localStorage.getItem('Language'));", true);
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
            DataTable table = new DataTable();
            table = _sql.SearchFeedback(int.Parse(AgentSearch.Value), searchDateStart.Value, searchDateTo.Value);
            if (table != null && table.Rows.Count > 0)
            {
                var no = 1;
                StringBuilder sb = new StringBuilder();
                foreach (DataRow row in table.Rows)
                {
                    sb.Append("<tr>");
                    sb.Append("<td style='text-align: center;'>" + no + "</td>");
                    sb.Append("<td>" + row["title"].ToString() + "</td>");
                    sb.Append("<td>" + row["message_text"].ToString() + "</td>");
                    sb.Append("<td style='text-align: center;'>" + row["agent_name"].ToString() + "</td>");

                    var create_date = "";
                    if (row["create_date"].ToString() != "" && row["create_date"].ToString() != null)
                    {
                        DateTime oDateLog = Convert.ToDateTime(row["create_date"].ToString());
                        string xLog = oDateLog.ToString("dd-MM-yyyy HH:mm", CultureInfo.InvariantCulture);
                        create_date = xLog;
                    }
                    else
                    {
                        create_date = "-";
                    }
                    sb.Append("<td style='text-align: center;'>" + create_date + "</td>");

                    sb.Append("<td style='text-align: center;'>" + row["create_by_name"].ToString() + "</td>");
                    no++;
                }

                LiteralData.Text = sb.ToString();
            }
            else
            {
                StringBuilder sb = new StringBuilder();
                sb.Append("<tr><td colspan='6' style='text-align: center;' set-lan='text:No Data.'></td></tr>");
                LiteralData.Text = sb.ToString();
            }

            ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "$('#myModalLoad').modal('hide');", true);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "hideDropdown()", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Error : " + ex.Message + "')", true);
            }
        }
    }
}