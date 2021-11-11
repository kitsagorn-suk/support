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

namespace Support_Project.Menu_TaskCalendar
{
    public partial class Timeline : System.Web.UI.Page
    {
        SqlManager _sql = new SqlManager();
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
                    DataTable dtddlRole = new DataTable();
                    dtddlRole.Columns.Add(new DataColumn("nameRole"));
                    dtddlRole.Columns.Add(new DataColumn("idRole"));

                    DataTable table = new DataTable();
                    table = _sql.getAllLeaveType();
                    if (table != null && table.Rows.Count > 0)
                    {
                        BindLeaveType();
                    }

                    LeaveTypeSearch.Value = "0";
                    LeaveStartDateSearch.Value = DateTime.Now.ToString("yyyy-MM-dd") + " 00:00:00";
                    LeaveToDateSearch.Value = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");

                    IDRole.Value = Request.Cookies["Keys"]["Position"];
                    SearchData();
                }
                else
                {
                    Response.Redirect("../Login.aspx");
                }
            }
        }

        private void BindLeaveType()
        {
            try
            {
                ddlLeaveTypeSearch.DataSource = _sql.getAllLeaveType();
                ddlLeaveTypeSearch.DataBind();
                ddlLeaveTypeSearch.Items.Insert(0, new ListItem("All", "0"));

                for (int i = 0; i < ddlLeaveTypeSearch.Items.Count; i++)
                {
                    ListItem item = ddlLeaveTypeSearch.Items[i];
                    item.Attributes["set-lan"] = "text:" + item.Text;
                }

                ddlLeaveTypeAdd.DataSource = _sql.getAllLeaveType();
                ddlLeaveTypeAdd.DataBind();
                ddlLeaveTypeAdd.Items.Insert(0, new ListItem("Select type", ""));

                for (int i = 0; i < ddlLeaveTypeAdd.Items.Count; i++)
                {
                    ListItem item = ddlLeaveTypeAdd.Items[i];
                    item.Attributes["set-lan"] = "text:" + item.Text;
                }
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
            DataTable table = new DataTable();
            table = _sql.SearchLeave(int.Parse(LeaveTypeSearch.Value), LeaveStartDateSearch.Value, LeaveToDateSearch.Value);
            if (table != null && table.Rows.Count > 0)
            {
                StringBuilder sb = new StringBuilder();
                foreach (DataRow row in table.Rows)
                {
                    sb.Append("<tr>");
                    sb.Append("<td><p class='overflowTable ellipsis' title='" + row["username"].ToString() + "'>" + row["username"].ToString() + "</p></td>");

                    var dateleave_start_date = "";
                    if (row["leave_start_date"].ToString() != "" && row["leave_start_date"].ToString() != null)
                    {
                        DateTime oDateLog = Convert.ToDateTime(row["leave_start_date"].ToString());
                        string xLog = oDateLog.ToString("dd-MM-yyyy HH:mm", CultureInfo.InvariantCulture);
                        dateleave_start_date = xLog;
                    }
                    else
                    {
                        dateleave_start_date = "-";
                    }

                    var dateleave_end_date = "";
                    if (row["leave_end_date"].ToString() != "" && row["leave_end_date"].ToString() != null)
                    {
                        DateTime oDateLog = Convert.ToDateTime(row["leave_end_date"].ToString());
                        string xLog = oDateLog.ToString("dd-MM-yyyy HH:mm", CultureInfo.InvariantCulture);
                        dateleave_end_date = xLog;
                    }
                    else
                    {
                        dateleave_end_date = "-";
                    }
                    sb.Append("<td style='text-align: center;'>" + dateleave_start_date + " - " + dateleave_end_date + "</td>");

                    sb.Append("<td style='text-align: center;'>" + row["leave_type_name"].ToString() + "</td>");

                    if (row["description"].ToString() != "" && row["description"].ToString() != null)
                    {
                        sb.Append("<td><p class='overflowTable ellipsis' title='" + row["description"].ToString() + "'>" + row["description"].ToString() + "</p></td>");
                    }
                    else
                    {
                        sb.Append("<td>-</td>");
                    }

                    var datecreate_date = "";
                    if (row["create_date"].ToString() != "" && row["create_date"].ToString() != null)
                    {
                        DateTime oDateLog = Convert.ToDateTime(row["create_date"].ToString());
                        string xLog = oDateLog.ToString("dd-MM-yyyy HH:mm", CultureInfo.InvariantCulture);
                        datecreate_date = xLog;
                    }
                    else
                    {
                        datecreate_date = "-";
                    }
                    sb.Append("<td style='text-align: center;'>" + datecreate_date + "</td>");


                    var dateapprove_date = "";
                    if (row["approve_date"].ToString() != "" && row["approve_date"].ToString() != null)
                    {
                        DateTime oDateLog = Convert.ToDateTime(row["approve_date"].ToString());
                        string xLog = oDateLog.ToString("dd-MM-yyyy HH:mm", CultureInfo.InvariantCulture);
                        dateapprove_date = xLog;
                    }
                    else
                    {
                        dateapprove_date = "-";
                    }
                    sb.Append("<td style='text-align: center;'>" + dateapprove_date + "</td>");

                    if (row["approve_date"].ToString() != "" && row["approve_date"].ToString() != null)
                    {
                        sb.Append("<td><p class='overflowTable ellipsis' title='" + row["approve_by"].ToString() + "'>" + row["approve_by"].ToString() + "</p></td>");
                    }
                    else
                    {
                        sb.Append("<td>-</td>");
                    }

                    sb.Append("<td style='text-align: center;'>" + row["status"].ToString() + "</td>");
                    sb.Append("<td style='text-align: center;'>" + row["total_day"].ToString() + "</td>");

                    if (Request.Cookies["Keys"]["Position"] == "Master" || Request.Cookies["Keys"]["Position"] == "Super User")
                    {
                        sb.Append("<td style='text-align: center;'>");

                        if (row["status"].ToString() != "approve" && row["status"].ToString() != "reject")
                        {
                            sb.Append("<a onclick='getApprove(\"" + row["id"].ToString() + "\");' style='font-size: 1rem;' class='link'><i class='fa fa-check-circle' style='color: green;'></i></a>&emsp;");
                            sb.Append("<a onclick='getReject(\"" + row["id"].ToString() + "\");' style='font-size: 1rem;' class='link'><i class='fa fa-times-circle' style='color: red;'></i></a></td>");
                        }
                        else
                        {
                            sb.Append("<a style='font-size: 1rem;' class='link disabled-link'><i class='fa fa-check-circle'></i></a>&emsp;");
                            sb.Append("<a style='font-size: 1rem;' class='link disabled-link'><i class='fa fa-times-circle'></i></a></td>");
                        }
                    }
                    else
                    {
                        sb.Append("<td></td>");
                    }

                    sb.Append("</tr>");
                }

                LiteralData.Text = sb.ToString();
            }
            else
            {
                StringBuilder sb = new StringBuilder();
                if (Request.Cookies["Keys"]["Position"] == "Master" || Request.Cookies["Keys"]["Position"] == "Super User")
                {
                    sb.Append("<tr><td colspan='10' style='text-align: center;' set-lan='text:No Data.'></td></tr>");
                }
                else
                {
                    sb.Append("<tr><td colspan='9' style='text-align: center;' set-lan='text:No Data.'></td></tr>");
                }
                LiteralData.Text = sb.ToString();
            }

            if (Request.Cookies["Keys"]["Position"] != "Master" && Request.Cookies["Keys"]["Position"] != "Super User")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "CallMyFunction", "$('#tbData > thead > tr > th:nth-child(10), #tbData > tbody > tr > td:nth-child(10), #tbData > tfoot > tr > td:nth-child(9)').remove();", true);
            }

            ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "setDataLanguage();", true);
        }

        public void AddLeave_click(Object sender, EventArgs e)
        {
            int _id = _sql.AddLeave(LeaveStartDateAdd.Value, LeaveToDateAdd.Value, int.Parse(LeaveTypeAdd.Value), Description.Text, int.Parse(Request.Cookies["Keys"]["ID"]));
            if (_id != 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModal('Add new leave success.');", true);
                SearchData();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModal('Data recording failed.');", true);
            }
        }

        public void ApproveLeave_click(Object sender, EventArgs e)
        {
            int _id = _sql.ApproveLeave(int.Parse(ApproveID.Value), int.Parse(Request.Cookies["Keys"]["ID"]));
            if (_id != 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModal('Approve this leave success.');", true);
                SearchData();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModal('Data recording failed.');", true);
            }
        }

        public void RejectLeave_click(Object sender, EventArgs e)
        {
            int _id = _sql.RejectLeave(int.Parse(RejectID.Value), int.Parse(Request.Cookies["Keys"]["ID"]));
            if (_id != 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModal('Reject this leave success.');", true);
                SearchData();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModal('Data recording failed.');", true);
            }
        }
    }
}