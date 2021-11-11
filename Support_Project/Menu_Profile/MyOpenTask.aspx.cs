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


namespace Support_Project.Menu_Profile
{
    public partial class MyOpenTask : System.Web.UI.Page
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
                    GetAllNoti();
                }
                else
                {
                    Response.Redirect("../Login.aspx");
                }
            }
        }

        public void Search_click(Object sender, EventArgs e)
        {
            GetAllNoti();
        }

        public void GetAllNoti()
        {
            DateTime datetimenow = DateTime.Now;
            DataTable table = new DataTable();
            StringBuilder sb = new StringBuilder();
            table = _sql.getAllNotification(int.Parse(Request.Cookies["Keys"]["ID"]));
            if (table != null && table.Rows.Count > 0)
            {
                var i = 1;
                foreach (DataRow row in table.Rows)
                {
                    sb.Append("<tr>");

                    sb.Append("<td style='text-align: center;'>" + i + "</td>");

                    if (row["level"].ToString() == "1")
                    {
                        sb.Append("<td style='text-align: center;'><i class='fa fa-circle' style='color: red;' title='Urgent'></i></td>");
                    }
                    else if (row["level"].ToString() == "2")
                    {
                        sb.Append("<td style='text-align: center;'><i class='fa fa-circle' style='color: #ff9325;' title='High'></i></td>");
                    }
                    else if (row["level"].ToString() == "3")
                    {
                        sb.Append("<td style='text-align: center;'><i class='fa fa-circle' style='color: #ffc107;' title='Medium'></i></td>");
                    }
                    else if (row["level"].ToString() == "4")
                    {
                        sb.Append("<td style='text-align: center;'><i class='fa fa-circle' style='color: #00c851;' title='Low'></i></td>");
                    }

                    sb.Append("<td style='text-align: center;'>" + row["ticket_id"].ToString() + "</td>");
                    sb.Append("<td style='text-align: center;'>" + row["status"].ToString() + "</td>");
                    sb.Append("<td><p class='overflowTable ellipsis' title='" + row["product"].ToString() + "'>" + row["product"].ToString() + "</p></td>");
                    sb.Append("<td><p class='overflowTable ellipsis' title='" + row["agent"].ToString() + "'>" + row["agent"].ToString() + "</p></td>");
                    sb.Append("<td style='text-align: center;'>" + row["categories_name"].ToString() + "</td>");
                    sb.Append("<td><p class='overflowTable ellipsis' title='" + row["create_by_name"].ToString() + "'>" + row["create_by_name"].ToString() + "</p></td>");

                    if (row["pickup_by_name"].ToString() != "" && row["pickup_by_name"].ToString() != null)
                    {
                        sb.Append("<td><p class='overflowTable ellipsis' title='" + row["pickup_by_name"].ToString() + "'>" + row["pickup_by_name"].ToString() + "</p></td>");
                    }
                    else
                    {
                        sb.Append("<td>-</td>");
                    }

                    var dateaverage = "";
                    if (row["average_end_date"].ToString() != "" && row["average_end_date"].ToString() != null)
                    {
                        DateTime oDateLog = Convert.ToDateTime(row["average_end_date"].ToString());
                        string xLog = oDateLog.ToString("dd-MM-yyyy HH:mm", CultureInfo.InvariantCulture);
                        dateaverage = xLog;
                    }
                    else
                    {
                        dateaverage = "-";
                    }
                    sb.Append("<td style='text-align: center;'>" + dateaverage + "</td>");
                    var txtDescWeb = row["desc_website_link"].ToString();
                    var txtDescUser = row["desc_username"].ToString();
                    var txtDescPass = row["desc_password"].ToString();
                    var txtDescProblem = row["desc_problem"].ToString().Replace("\r\n", "<br/>");
                    var txtDescTroubleshooting = row["desc_troubleshooting"].ToString().Replace("\r\n", "<br/>");
                    var txtDescAfter_fixed = row["desc_after_fixed"].ToString().Replace("\r\n", "<br/>");
                    var txtDescOther = row["desc_other"].ToString().Replace("\r\n", "<br/>");
                    var txtComment = row["edit_case_text"].ToString().Replace("\r\n", "<br/>");
                    sb.Append("<td style='text-align: center;'><a onclick='getDesc(\"" + txtDescWeb + "\",\"" + txtDescUser + "\",\"" + txtDescPass + "\",\"" + txtDescProblem + "\",\"" + txtDescTroubleshooting + "\",\"" + txtDescAfter_fixed + "\",\"" + txtDescOther + "\",\"" + txtComment + "\");' style='font-size: 1rem;' class='link'><i class='fas fa-eye'></i></a></td>");

                    if (row["attached_file"].ToString() != "")
                    {
                        sb.Append("<td style='text-align: center;'><a onclick='getImage(\"" + row["attached_file"].ToString() + "\");' style='font-size: 1rem;' class='link'><i class='fas fa-file-alt'></i></a></td>");
                    }
                    else
                    {
                        sb.Append("<td style='text-align: center;'><a onclick='getImage(\"" + row["attached_file"].ToString() + "\");' style='font-size: 1rem;' class='link disabled-link'><i class='fas fa-file-alt'></i></a></td>");
                    }

                    sb.Append("<td style='text-align: center;'>");

                    if (row["status"].ToString() == "done")
                    {
                        sb.Append("<a onclick='getClose(\"" + row["id"].ToString() + "\");' style='font-size: 1rem;' class='link'><i class='fa fa-check-circle' style='color: green;'></i></a></td>");
                    }
                    else
                    {
                        sb.Append("<a onclick='getComment(\"" + row["id"].ToString() + "\");' style='font-size: 1rem;' class='link'><i class='fa fa-check-circle' style='color: green;'></i></a></td>");
                    }

                    sb.Append("</tr>");
                    i++;
                }
            }
            else
            {
                sb.Append("<tr><td colspan='13' style='text-align: center;'>No Data.</td></tr>");
            }

            LiteralDataAllNotification.Text = sb.ToString();

            ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "$('#myModalLoad').modal('hide');", true);
        }

        public void CloseDashboard_click(Object sender, EventArgs e)
        {
            int _id = _sql.CloseMyTask(int.Parse(closeID.Value), int.Parse(Request.Cookies["Keys"]["ID"]));
            if (_id == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModal('Acknowledge your open task success.');", true);
                //GetAllNoti();
                Response.Redirect("../Menu_Profile/MyOpenTask.aspx");
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModal('Data recording failed.');", true);
            }
        }

        public void CommentDashboard_click(Object sender, EventArgs e)
        {
            int _id = _sql.CommentMyTask(int.Parse(commentID.Value), int.Parse(Request.Cookies["Keys"]["ID"]));
            if (_id == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModal('Acknowledge your open task success.');", true);
                //GetAllNoti();
                Response.Redirect("../Menu_Profile/MyOpenTask.aspx");
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModal('Data recording failed.');", true);
            }
        }
    }
}