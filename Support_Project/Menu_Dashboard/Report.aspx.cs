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
using System.Web.Configuration;

namespace Support_Project.Menu_Dasboard
{
    public partial class Report : System.Web.UI.Page
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
                    DataTable dtddlRole = new DataTable();
                    dtddlRole.Columns.Add(new DataColumn("nameRole"));
                    dtddlRole.Columns.Add(new DataColumn("idRole"));

                    DataTable table = new DataTable();
                    table = _sql.getAllRole();
                    if (table != null && table.Rows.Count > 0)
                    {
                        BindCategory();
                    }

                    MyTask.Value = "0";
                    CategorySearch.Value = "0";
                    searchDateStart.Value = DateTime.Now.ToString("yyyy-MM-dd") + " 00:00:00";
                    searchDateTo.Value = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                    SearchData("");

                    //int second = 20 * 1000;
                    //var timer = new System.Threading.Timer(SearchData, null, 0, second);

                    AgentID.Value = Request.Cookies["Keys"]["Agent_ID"];
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
            SearchData("");
        }

        public void SearchData(Object sender)
        {
            DateTime datetimenow = DateTime.Now;
            DataTable table = new DataTable();
            if (MyTask.Value == "Yes")
            {
                MyTask.Value = Request.Cookies["Keys"]["ID"];
            }

            int _idTotal = 0;
            _idTotal = _sql.SearchDashboardPaging(searchProduct.Text, int.Parse(MyTask.Value), searchDateStart.Value, searchDateTo.Value, int.Parse(CategorySearch.Value), StatusSearch.Value, int.Parse(Request.Cookies["Keys"]["Agent_ID"]), Request.Cookies["Keys"]["Agent_Master"]);
            totalDocs.Value = _idTotal.ToString();

            if (thisPage.Value == "" || thisPage.Value == null)
            {
                PageNow = "1";
            }
            else
            {
                PageNow = thisPage.Value;
            }

            string perPage = WebConfigurationManager.AppSettings["perPage"];
            table = _sql.SearchDashboard(searchProduct.Text, int.Parse(MyTask.Value), searchDateStart.Value, searchDateTo.Value, int.Parse(CategorySearch.Value), StatusSearch.Value, int.Parse(Request.Cookies["Keys"]["Agent_ID"]), int.Parse(PageNow), int.Parse(perPage), Request.Cookies["Keys"]["Agent_Master"]);
            if (table != null && table.Rows.Count > 0)
            {
                var i = 1;
                StringBuilder sb = new StringBuilder();
                foreach (DataRow row in table.Rows)
                {
                    if (row["status"].ToString() != "done" && row["status"].ToString() != "cancel")
                    {
                        DateTime creatDate = DateTime.Parse(row["create_date"].ToString());
                        var countMinute = (int)datetimenow.Subtract(creatDate).TotalMinutes;

                        if (row["status"].ToString() == "waiting")
                        {
                            sb.Append("<tr class='trYellow'>");
                        }
                        else if (row["status"].ToString() == "new" || row["status"].ToString() == "open")
                        {
                            sb.Append("<tr class='trRed'>");
                        }
                        else
                        {
                            sb.Append("<tr>");
                        }

                        sb.Append("<td style='text-align: center;'>" + (((int.Parse(PageNow) - 1) * int.Parse(perPage)) + i) + "</td>");

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
                        sb.Append("<td><p class='overflowTableS ellipsis' title='" + row["product"].ToString() + "'>" + row["product"].ToString() + "</p></td>");
                        sb.Append("<td><p class='overflowTableS ellipsis' title='" + row["desc_username"].ToString() + "'>" + row["desc_username"].ToString() + "</p></td>");
                        sb.Append("<td><p class='overflowTableS ellipsis' title='" + row["agent"].ToString() + "'>" + row["agent"].ToString() + "</p></td>");
                        sb.Append("<td style='text-align: center;'>" + row["categories_name"].ToString() + "</td>");

                        var dateaverage_create = "";
                        if (row["create_date"].ToString() != "" && row["create_date"].ToString() != null)
                        {
                            DateTime oDateLog = Convert.ToDateTime(row["create_date"].ToString());
                            string xLog = oDateLog.ToString("dd-MM-yyyy HH:mm", CultureInfo.InvariantCulture);
                            dateaverage_create = xLog;
                        }
                        else
                        {
                            dateaverage_create = "-";
                        }
                        sb.Append("<td style='text-align: center;'>" + dateaverage_create + "</td>");
                        sb.Append("<td><p class='soverflowTable ellipsis' title='" + row["create_by_name"].ToString() + "'>" + row["create_by_name"].ToString() + "</p></td>");

                        if (row["pickup_by_name"].ToString() != "" && row["pickup_by_name"].ToString() != null)
                        {
                            sb.Append("<td><p class='soverflowTable ellipsis' title='" + row["pickup_by_name"].ToString() + "'>" + row["pickup_by_name"].ToString() + "</p></td>");
                        }
                        else
                        {
                            sb.Append("<td>-</td>");
                        }

                        //var dateaverage = "";
                        //if (row["average_end_date"].ToString() != "" && row["average_end_date"].ToString() != null)
                        //{
                        //    DateTime oDateLog = Convert.ToDateTime(row["average_end_date"].ToString());
                        //    string xLog = oDateLog.ToString("dd-MM-yyyy HH:mm", CultureInfo.InvariantCulture);
                        //    dateaverage = xLog;
                        //}
                        //else
                        //{
                        //    dateaverage = "-";
                        //}
                        //sb.Append("<td style='text-align: center;'>" + dateaverage + "</td>");
                        var txtDescWeb = row["desc_website_link"].ToString();
                        var txtDescUser = row["desc_username"].ToString();
                        var txtDescPass = row["desc_password"].ToString();
                        var txtDescProblem = row["desc_problem"].ToString().Replace("\r\n", "<br/>");
                        txtDescProblem = txtDescProblem.Replace("'", "").Replace("\"", "");
                        var txtDescTroubleshooting = row["desc_troubleshooting"].ToString().Replace("\r\n", "<br/>");
                        txtDescTroubleshooting = txtDescTroubleshooting.Replace("'", "").Replace("\"", "");
                        var txtDescAfter_fixed = row["desc_after_fixed"].ToString().Replace("\r\n", "<br/>");
                        txtDescAfter_fixed = txtDescAfter_fixed.Replace("'", "").Replace("\"", "");
                        var txtDescOther = row["desc_other"].ToString().Replace("\r\n", "<br/>");
                        txtDescOther = txtDescOther.Replace("'", "").Replace("\"", "");

                        if (row["pickup_by_name"].ToString() != "" && row["pickup_by_name"].ToString() != null)
                        {
                            sb.Append("<td style='text-align: center;'><a onclick='getDesc(\"" + row["ticket_id"].ToString() + "\",\"" + txtDescWeb + "\",\"" + txtDescUser + "\",\"" + txtDescPass + "\",\"" + txtDescProblem + "\",\"" + txtDescTroubleshooting + "\",\"" + txtDescAfter_fixed + "\",\"" + txtDescOther + "\");' style='font-size: 1rem;' class='link'><i class='fas fa-eye'></i></a></td>");
                        }
                        else if (row["create_by"].ToString() == Request.Cookies["Keys"]["ID"])
                        {
                            sb.Append("<td style='text-align: center;'><a onclick='getDesc(\"" + row["ticket_id"].ToString() + "\",\"" + txtDescWeb + "\",\"" + txtDescUser + "\",\"" + txtDescPass + "\",\"" + txtDescProblem + "\",\"" + txtDescTroubleshooting + "\",\"" + txtDescAfter_fixed + "\",\"" + txtDescOther + "\");' style='font-size: 1rem;' class='link'><i class='fas fa-eye'></i></a></td>");
                        }
                        else
                        {
                            sb.Append("<td style='text-align: center;'><a style='font-size: 1rem;' class='link disabled-link'><i class='fas fa-eye'></i></a></td>");
                        }

                        if (row["attached_file"].ToString() != "")
                        {
                            sb.Append("<td style='text-align: center;'><a onclick='getImage(\"" + row["attached_file"].ToString() + "\");' style='font-size: 1rem;' class='link'><i class='fas fa-file-alt'></i></a></td>");
                        }
                        else
                        {
                            sb.Append("<td style='text-align: center;'><a onclick='getImage(\"" + row["attached_file"].ToString() + "\");' style='font-size: 1rem;' class='link disabled-link'><i class='fas fa-file-alt'></i></a></td>");
                        }

                        sb.Append("<td style='text-align: center;'><a onclick='getPickup(\"" + row["id"].ToString() + "\");' style='font-size: 1rem;' class='link'><i class='fas fa-plus-square'></i></a></td>");
                        sb.Append("<td style='text-align: center;'>");

                        if (row["count_chat"].ToString() == "0" || row["count_chat"].ToString() == null)
                        {
                            sb.Append("<a onclick='getChat(\"" + row["id"].ToString() + "\");' style='font-size: 1rem;' class='link'><i class='fa fa-comment'></i></a>&emsp;");
                        }
                        else
                        {
                            sb.Append("<a onclick='getChat(\"" + row["id"].ToString() + "\");' style='font-size: 1rem;' class='link'><i class='fa fa-comment'></i><span class='dot'></span></a>&emsp;");
                        }

                        if (Request.Cookies["Keys"]["Agent_ID"] == "0" || Request.Cookies["Keys"]["Agent_ID"] == "1")
                        {
                            sb.Append("<a onclick='getCancel(\"" + row["id"].ToString() + "\");' style='font-size: 1rem;' class='link'><i class='fa fa-times-circle' style='color: red;'></i></a>&emsp;");
                            sb.Append("<a onclick='getClose(\"" + row["id"].ToString() + "\");' style='font-size: 1rem;' class='link'><i class='fa fa-check-circle' style='color: green;'></i></a>");
                        }

                        sb.Append("</td></tr>");
                    }
                    else
                    {
                        sb.Append("<tr>");

                        sb.Append("<td style='text-align: center;'>" + (((int.Parse(PageNow) - 1) * int.Parse(perPage)) + i) + "</td>");

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
                        sb.Append("<td><p class='overflowTableS ellipsis' title='" + row["product"].ToString() + "'>" + row["product"].ToString() + "</p></td>");
                        sb.Append("<td><p class='overflowTableS ellipsis' title='" + row["desc_username"].ToString() + "'>" + row["desc_username"].ToString() + "</p></td>");
                        sb.Append("<td><p class='overflowTableS ellipsis' title='" + row["agent"].ToString() + "'>" + row["agent"].ToString() + "</p></td>");
                        sb.Append("<td style='text-align: center;'>" + row["categories_name"].ToString() + "</td>");

                        var dateaverage_create = "";
                        if (row["create_date"].ToString() != "" && row["create_date"].ToString() != null)
                        {
                            DateTime oDateLog = Convert.ToDateTime(row["create_date"].ToString());
                            string xLog = oDateLog.ToString("dd-MM-yyyy HH:mm", CultureInfo.InvariantCulture);
                            dateaverage_create = xLog;
                        }
                        else
                        {
                            dateaverage_create = "-";
                        }
                        sb.Append("<td style='text-align: center;'>" + dateaverage_create + "</td>");
                        sb.Append("<td><p class='soverflowTable ellipsis' title='" + row["create_by_name"].ToString() + "'>" + row["create_by_name"].ToString() + "</p></td>");

                        if (row["pickup_by_name"].ToString() != "" && row["pickup_by_name"].ToString() != null)
                        {
                            sb.Append("<td><p class='soverflowTable ellipsis' title='" + row["pickup_by_name"].ToString() + "'>" + row["pickup_by_name"].ToString() + "</p></td>");
                        }
                        else
                        {
                            sb.Append("<td>-</td>");
                        }

                        //var dateaverage = "";
                        //if (row["average_end_date"].ToString() != "" && row["average_end_date"].ToString() != null)
                        //{
                        //    DateTime oDateLog = Convert.ToDateTime(row["average_end_date"].ToString());
                        //    string xLog = oDateLog.ToString("dd-MM-yyyy HH:mm", CultureInfo.InvariantCulture);
                        //    dateaverage = xLog;
                        //}
                        //else
                        //{
                        //    dateaverage = "-";
                        //}
                        //sb.Append("<td style='text-align: center;'>" + dateaverage + "</td>");
                        var txtDescWeb = row["desc_website_link"].ToString();
                        var txtDescUser = row["desc_username"].ToString();
                        var txtDescPass = row["desc_password"].ToString();
                        var txtDescProblem = row["desc_problem"].ToString().Replace("\r\n", "<br/>");
                        txtDescProblem = txtDescProblem.Replace("'", "").Replace("\"", "");
                        var txtDescTroubleshooting = row["desc_troubleshooting"].ToString().Replace("\r\n", "<br/>");
                        txtDescTroubleshooting = txtDescTroubleshooting.Replace("'", "").Replace("\"", "");
                        var txtDescAfter_fixed = row["desc_after_fixed"].ToString().Replace("\r\n", "<br/>");
                        txtDescAfter_fixed = txtDescAfter_fixed.Replace("'", "").Replace("\"", "");
                        var txtDescOther = row["desc_other"].ToString().Replace("\r\n", "<br/>");
                        txtDescOther = txtDescOther.Replace("'", "").Replace("\"", "");

                        if (row["pickup_by_name"].ToString() != "" && row["pickup_by_name"].ToString() != null)
                        {
                            sb.Append("<td style='text-align: center;'><a onclick='getDesc(\"" + row["ticket_id"].ToString() + "\",\"" + txtDescWeb + "\",\"" + txtDescUser + "\",\"" + txtDescPass + "\",\"" + txtDescProblem + "\",\"" + txtDescTroubleshooting + "\",\"" + txtDescAfter_fixed + "\",\"" + txtDescOther + "\");' style='font-size: 1rem;' class='link'><i class='fas fa-eye'></i></a></td>");
                        }
                        else if (row["create_by"].ToString() == Request.Cookies["Keys"]["ID"])
                        {
                            sb.Append("<td style='text-align: center;'><a onclick='getDesc(\"" + row["ticket_id"].ToString() + "\",\"" + txtDescWeb + "\",\"" + txtDescUser + "\",\"" + txtDescPass + "\",\"" + txtDescProblem + "\",\"" + txtDescTroubleshooting + "\",\"" + txtDescAfter_fixed + "\",\"" + txtDescOther + "\");' style='font-size: 1rem;' class='link'><i class='fas fa-eye'></i></a></td>");
                        }
                        else
                        {
                            sb.Append("<td style='text-align: center;'><a style='font-size: 1rem;' class='link disabled-link'><i class='fas fa-eye'></i></a></td>");
                        }

                        if (row["attached_file"].ToString() != "")
                        {
                            sb.Append("<td style='text-align: center;'><a onclick='getImage(\"" + row["attached_file"].ToString() + "\");' style='font-size: 1rem;' class='link'><i class='fas fa-file-alt'></i></a></td>");
                        }
                        else
                        {
                            sb.Append("<td style='text-align: center;'><a onclick='getImage(\"" + row["attached_file"].ToString() + "\");' style='font-size: 1rem;' class='link disabled-link'><i class='fas fa-file-alt'></i></a></td>");
                        }

                        if (row["status"].ToString() == "new" || row["status"].ToString() == "open" || row["status"].ToString() == "waiting")
                        {
                            sb.Append("<td style='text-align: center;'><a onclick='getPickup(\"" + row["id"].ToString() + "\");' style='font-size: 1rem;' class='link'><i class='fas fa-plus-square'></i></a></td>");
                            sb.Append("<td style='text-align: center;'>");

                            if (row["count_chat"].ToString() == "0" || row["count_chat"].ToString() == null)
                            {
                                sb.Append("<a onclick='getChat(\"" + row["id"].ToString() + "\");' style='font-size: 1rem;' class='link'><i class='fa fa-comment'></i></a>&emsp;");
                            }
                            else
                            {
                                sb.Append("<a onclick='getChat(\"" + row["id"].ToString() + "\");' style='font-size: 1rem;' class='link'><i class='fa fa-comment'></i><span class='dot'></span></a>&emsp;");
                            }

                            if (Request.Cookies["Keys"]["Agent_ID"] == "0" || Request.Cookies["Keys"]["Agent_ID"] == "1")
                            {
                                sb.Append("<a onclick='getCancel(\"" + row["id"].ToString() + "\");' style='font-size: 1rem;' class='link'><i class='fa fa-times-circle' style='color: red;'></i></a>&emsp;");
                                sb.Append("<a onclick='getClose(\"" + row["id"].ToString() + "\");' style='font-size: 1rem;' class='link'><i class='fa fa-check-circle' style='color: green;'></i></a>");
                            }

                            sb.Append("</td>");
                        }
                        else
                        {
                            sb.Append("<td style='text-align: center;'><a style='font-size: 1rem;' class='link disabled-link'><i class='fas fa-plus-square'></i></a></td>");
                            sb.Append("<td style='text-align: center;'>");

                            if (row["count_chat"].ToString() == "0" || row["count_chat"].ToString() == null)
                            {
                                sb.Append("<a onclick='getChat(\"" + row["id"].ToString() + "\");' style='font-size: 1rem;' class='link'><i class='fa fa-comment'></i></a>&emsp;");
                            }
                            else
                            {
                                sb.Append("<a onclick='getChat(\"" + row["id"].ToString() + "\");' style='font-size: 1rem;' class='link'><i class='fa fa-comment'></i><span class='dot'></span></a>&emsp;");
                            }

                            if (Request.Cookies["Keys"]["Agent_ID"] == "0" || Request.Cookies["Keys"]["Agent_ID"] == "1")
                            {
                                sb.Append("<a style='font-size: 1rem;' class='link disabled-link'><i class='fa fa-times-circle'></i></a>&emsp;");
                                sb.Append("<a style='font-size: 1rem;' class='link disabled-link'><i class='fa fa-check-circle'></i></a>");
                            }

                            sb.Append("</td>");
                        }

                        sb.Append("</tr>");
                    }
                    i++;
                }

                LiteralData.Text = sb.ToString();
            }
            else
            {
                StringBuilder sb = new StringBuilder();
                sb.Append("<tr><td colspan='15' style='text-align: center;' set-lan='text:No Data.'></td></tr>");
                LiteralData.Text = sb.ToString();
            }

            if (Request.Cookies["Keys"]["Agent_ID"] != "0" && Request.Cookies["Keys"]["Agent_ID"] != "1")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "$('#tbData > thead > tr > th:nth-child(14) , #tbData > tbody > tr > td:nth-child(14), #tbData > tfoot > tr > td:nth-child(14)').css('display', 'none');", true);
            }

            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "setDataLanguage();", true);
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "$('#myModalLoad').modal('hide');", true);

            if (eventPaging.Value != "paging")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "GetData(" + _idTotal.ToString() + ");", true);
            }
        }

        private void BindCategory()
        {
            try
            {
                ddlCategorySearch.DataSource = _sql.getAllCategory();
                ddlCategorySearch.DataBind();
                ddlCategorySearch.Items.Insert(0, new ListItem("All", "0"));

                for (int i = 0; i < ddlCategorySearch.Items.Count; i++)
                {
                    ListItem item = ddlCategorySearch.Items[i];
                    item.Attributes["set-lan"] = "text:" + item.Text;
                }

                ddlCategoryAdd.DataSource = _sql.getAllCategory();
                ddlCategoryAdd.DataBind();
                ddlCategoryAdd.Items.Insert(0, new ListItem("Select category", ""));

                for (int i = 0; i < ddlCategoryAdd.Items.Count; i++)
                {
                    ListItem item = ddlCategoryAdd.Items[i];
                    item.Attributes["set-lan"] = "text:" + item.Text;
                }

                ddlLevelAdd.DataSource = _sql.getAllLevel();
                ddlLevelAdd.DataBind();
                ddlLevelAdd.Items.Insert(0, new ListItem("Select level", ""));

                for (int i = 0; i < ddlLevelAdd.Items.Count; i++)
                {
                    ListItem item = ddlLevelAdd.Items[i];
                    item.Attributes["set-lan"] = "text:" + item.Text;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void AddDashboard_click(Object sender, EventArgs e)
        {
            List<string> allFile = new List<string>();
            if (AttahcFile1.PostedFile != null && AttahcFile1.PostedFile.ContentLength > 0)
            {
                string fileName = Path.GetFileName(AttahcFile1.PostedFile.FileName);
                string folder = Server.MapPath("~/FileAttach/");
                Directory.CreateDirectory(folder);
                Guid obj = Guid.NewGuid();
                string nameFile = obj.ToString();
                string strpath = System.IO.Path.GetExtension(AttahcFile1.FileName);
                AttahcFile1.PostedFile.SaveAs(Path.Combine(folder, nameFile + strpath));
                allFile.Add(nameFile + strpath);
            }

            if (AttahcFile2.PostedFile != null && AttahcFile2.PostedFile.ContentLength > 0)
            {
                string fileName = Path.GetFileName(AttahcFile2.PostedFile.FileName);
                string folder = Server.MapPath("~/FileAttach/");
                Directory.CreateDirectory(folder);
                Guid obj = Guid.NewGuid();
                string nameFile = obj.ToString();
                string strpath = System.IO.Path.GetExtension(AttahcFile2.FileName);
                AttahcFile2.PostedFile.SaveAs(Path.Combine(folder, nameFile + strpath));
                allFile.Add(nameFile + strpath);
            }

            if (AttahcFile3.PostedFile != null && AttahcFile3.PostedFile.ContentLength > 0)
            {
                string fileName = Path.GetFileName(AttahcFile3.PostedFile.FileName);
                string folder = Server.MapPath("~/FileAttach/");
                Directory.CreateDirectory(folder);
                Guid obj = Guid.NewGuid();
                string nameFile = obj.ToString();
                string strpath = System.IO.Path.GetExtension(AttahcFile3.FileName);
                AttahcFile3.PostedFile.SaveAs(Path.Combine(folder, nameFile + strpath));
                allFile.Add(nameFile + strpath);
            }

            if (AttahcFile4.PostedFile != null && AttahcFile4.PostedFile.ContentLength > 0)
            {
                string fileName = Path.GetFileName(AttahcFile4.PostedFile.FileName);
                string folder = Server.MapPath("~/FileAttach/");
                Directory.CreateDirectory(folder);
                Guid obj = Guid.NewGuid();
                string nameFile = obj.ToString();
                string strpath = System.IO.Path.GetExtension(AttahcFile4.FileName);
                AttahcFile4.PostedFile.SaveAs(Path.Combine(folder, nameFile + strpath));
                allFile.Add(nameFile + strpath);
            }

            if (AttahcFile5.PostedFile != null && AttahcFile5.PostedFile.ContentLength > 0)
            {
                string fileName = Path.GetFileName(AttahcFile5.PostedFile.FileName);
                string folder = Server.MapPath("~/FileAttach/");
                Directory.CreateDirectory(folder);
                Guid obj = Guid.NewGuid();
                string nameFile = obj.ToString();
                string strpath = System.IO.Path.GetExtension(AttahcFile5.FileName);
                AttahcFile5.PostedFile.SaveAs(Path.Combine(folder, nameFile + strpath));
                allFile.Add(nameFile + strpath);
            }

            string allFileAttach = string.Join(",", allFile.ToArray());
            try
            {
                int _id = _sql.AddDashboard(product.Text, agent.Text, int.Parse(CategoryAdd.Value), allFileAttach, int.Parse(Request.Cookies["Keys"]["ID"]), int.Parse(LevelAdd.Value), Website.Text, Username.Text, Password.Text, Problem.Text, Troubleshooting.Text, Afterfirstfixed.Text, Other.Text, int.Parse(Request.Cookies["Keys"]["Agent_ID"]));
                if (_id != 0)
                {
                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModal('Add new dashboard success.');", true);
                    //SearchData("");
                    Response.Redirect("../Menu_Dashboard/Report.aspx");
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModal('Data recording failed.');", true);
                }
            }
            catch
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModal('Data recording failed.');", true);
            }
        }

        public void AddPickupDashboard_click(Object sender, EventArgs e)
        {
            int _id = _sql.AddPickup(int.Parse(pickupID.Value), int.Parse(Request.Cookies["Keys"]["ID"]), pickupDate.Value);
            if (_id != 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModal('Pickup dashboard success.');", true);
                SearchData("");
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModal('Data recording failed.');", true);
            }
        }

        public void CloseDashboard_click(Object sender, EventArgs e)
        {
            int _id = _sql.CloseDashboard(int.Parse(closeID.Value), int.Parse(Request.Cookies["Keys"]["ID"]));
            if (_id != 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModal('Close dashboard success.');", true);
                SearchData("");
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModal('Data recording failed.');", true);
            }
        }

        public void CancelDashboard_click(Object sender, EventArgs e)
        {
            int _id = _sql.CancelDashboard(int.Parse(cancelID.Value), int.Parse(Request.Cookies["Keys"]["ID"]));
            if (_id != 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModal('Cancel dashboard success.');", true);
                SearchData("");
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModal('Data recording failed.');", true);
            }
        }

        public void ChatDashboard_click(Object sender, EventArgs e)
        {
            GetChatData("");
        }

        public void GetChatData(Object sender)
        {
            DataTable table = new DataTable();
            table = _sql.GetAllChat(int.Parse(chatID.Value), int.Parse(Request.Cookies["Keys"]["ID"]));
            if (table != null && table.Rows.Count > 0)
            {
                StringBuilder sb = new StringBuilder();
                foreach (DataRow row in table.Rows)
                {
                    if (row["action"].ToString() == "receive")
                    {
                        sb.Append("<div class='incoming_msg'>");
                        sb.Append("<div class='incoming_msg_img'>");
                        sb.Append("<p>" + row["fullname"].ToString() + "</p>");
                        sb.Append("</div>");
                        sb.Append("<div class='received_msg'>");
                        sb.Append("<div class='received_withd_msg'>");
                        if (row["chat_type"].ToString() == "0")
                        {
                            sb.Append("<p>");
                            sb.Append(row["chat_message"].ToString());
                            sb.Append("</p>");
                        }
                        else
                        {
                            if (row["chat_message"].ToString().Split('.')[1] == "mp4" || row["chat_message"].ToString().Split('.')[1] == "mov" || row["chat_message"].ToString().Split('.')[1] == "wmv" || row["chat_message"].ToString().Split('.')[1] == "avi")
                            {
                                sb.Append("<video class='col-4 vdo' style='width: 100%; height: 135px; margin-bottom: 1rem;' controls><source src='../FileAttach/" + row["chat_message"].ToString() + "'></video>");
                            }
                            else
                            {
                                sb.Append("<img class='imgShowChat' style='width: 250px; height: 150px; border-radius: .3rem;' src='../FileAttach/" + row["chat_message"].ToString() + "' />");
                            }
                        }

                        sb.Append("<span class='time_date'>" + row["create_date"].ToString() + "</span>");
                        sb.Append("</div>");
                        sb.Append("</div>");
                        sb.Append("</div>");
                    }
                    else
                    {
                        sb.Append("<div class='outgoing_msg'>");
                        sb.Append("<div class='sent_msg'>");
                        if (row["chat_type"].ToString() == "0")
                        {
                            sb.Append("<p>");
                            sb.Append(row["chat_message"].ToString());
                            sb.Append("</p>");
                        }
                        else
                        {
                            if (row["chat_message"].ToString().Split('.')[1] == "mp4" || row["chat_message"].ToString().Split('.')[1] == "mov" || row["chat_message"].ToString().Split('.')[1] == "wmv" || row["chat_message"].ToString().Split('.')[1] == "avi")
                            {
                                sb.Append("<video class='col-4 vdo' style='width: 100%; height: 135px; margin-bottom: 1rem;' controls><source src='../FileAttach/" + row["chat_message"].ToString() + "'></video>");
                            }
                            else
                            {
                                sb.Append("<img class='imgShowChat' style='width: 250px; height: 150px; border-radius: .3rem;' src='../FileAttach/" + row["chat_message"].ToString() + "' />");
                            }
                        }

                        sb.Append("<div style='display: inline-flex;'><span class='time_date'>" + row["create_date"].ToString() + "</span>&nbsp;|&nbsp;");
                        sb.Append("<a class='link' style='font-size: 10pt; padding-top: .4rem; text-decoration:underline; color: #747474;' onclick='getCancelChat(" + row["id"].ToString() + ");' set-lan='text:Unsend Chat'></a></div>");
                        sb.Append("</div>");
                        sb.Append("</div>");
                    }
                }

                LiteralDataChat.Text = sb.ToString();
            }
            else
            {
                StringBuilder sb = new StringBuilder();
                sb.Append("<p style='margin-top: 1rem;' set-lan='text:No Chat.'></p>");
                LiteralDataChat.Text = sb.ToString();
            }

            if (Request.Cookies["Keys"]["Agent_ID"] != "0" && Request.Cookies["Keys"]["Agent_ID"] != "1")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "$('#tbData > thead > tr > th:nth-child(14) , #tbData > tbody > tr > td:nth-child(14), #tbData > tfoot > tr > td:nth-child(14)').css('display', 'none');", true);
            }
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "$('#modalChatDashboard').modal();", true);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "GetImageChat();", true);
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "$('#myModalLoad').modal('hide');", true);
        }

        public void AddChatDashboard_click(Object sender, EventArgs e)
        {
            var statusText = false;
            var status1 = false;
            var status2 = false;
            var status3 = false;
            var status4 = false;
            var status5 = false;
            if (Chat.Text != "")
            {
                int _id = _sql.SendChatDashboard(Chat.Text, int.Parse(chatID.Value), int.Parse(Request.Cookies["Keys"]["ID"]), 0);
                if (_id != 0)
                {
                    statusText = true;
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModal('Data recording failed.');", true);
                }
            }

            if (FileUploadChat1.HasFile)
            {
                string fileName = Path.GetFileName(FileUploadChat1.PostedFile.FileName);
                string folder = Server.MapPath("~/FileAttach/");
                Directory.CreateDirectory(folder);
                Guid obj = Guid.NewGuid();
                string nameFile = obj.ToString();
                string strpath = System.IO.Path.GetExtension(FileUploadChat1.FileName);
                FileUploadChat1.PostedFile.SaveAs(Path.Combine(folder, nameFile + strpath));

                int _idImage = _sql.SendChatDashboard(nameFile + strpath, int.Parse(chatID.Value), int.Parse(Request.Cookies["Keys"]["ID"]), 1);
                if (_idImage != 0)
                {
                    status1 = true;
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModal('Data recording failed.');", true);
                }
            }

            if (FileUploadChat2.HasFile)
            {
                string fileName = Path.GetFileName(FileUploadChat2.PostedFile.FileName);
                string folder = Server.MapPath("~/FileAttach/");
                Directory.CreateDirectory(folder);
                Guid obj = Guid.NewGuid();
                string nameFile = obj.ToString();
                string strpath = System.IO.Path.GetExtension(FileUploadChat2.FileName);
                FileUploadChat2.PostedFile.SaveAs(Path.Combine(folder, nameFile + strpath));

                int _idImage = _sql.SendChatDashboard(nameFile + strpath, int.Parse(chatID.Value), int.Parse(Request.Cookies["Keys"]["ID"]), 1);
                if (_idImage != 0)
                {
                    status2 = true;
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModal('Data recording failed.');", true);
                }
            }

            if (FileUploadChat3.HasFile)
            {
                string fileName = Path.GetFileName(FileUploadChat3.PostedFile.FileName);
                string folder = Server.MapPath("~/FileAttach/");
                Directory.CreateDirectory(folder);
                Guid obj = Guid.NewGuid();
                string nameFile = obj.ToString();
                string strpath = System.IO.Path.GetExtension(FileUploadChat3.FileName);
                FileUploadChat3.PostedFile.SaveAs(Path.Combine(folder, nameFile + strpath));

                int _idImage = _sql.SendChatDashboard(nameFile + strpath, int.Parse(chatID.Value), int.Parse(Request.Cookies["Keys"]["ID"]), 1);
                if (_idImage != 0)
                {
                    status3 = true;
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModal('Data recording failed.');", true);
                }
            }

            if (FileUploadChat4.HasFile)
            {
                string fileName = Path.GetFileName(FileUploadChat4.PostedFile.FileName);
                string folder = Server.MapPath("~/FileAttach/");
                Directory.CreateDirectory(folder);
                Guid obj = Guid.NewGuid();
                string nameFile = obj.ToString();
                string strpath = System.IO.Path.GetExtension(FileUploadChat4.FileName);
                FileUploadChat4.PostedFile.SaveAs(Path.Combine(folder, nameFile + strpath));

                int _idImage = _sql.SendChatDashboard(nameFile + strpath, int.Parse(chatID.Value), int.Parse(Request.Cookies["Keys"]["ID"]), 1);
                if (_idImage != 0)
                {
                    status4 = true;
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModal('Data recording failed.');", true);
                }
            }

            if (FileUploadChat5.HasFile)
            {
                string fileName = Path.GetFileName(FileUploadChat5.PostedFile.FileName);
                string folder = Server.MapPath("~/FileAttach/");
                Directory.CreateDirectory(folder);
                Guid obj = Guid.NewGuid();
                string nameFile = obj.ToString();
                string strpath = System.IO.Path.GetExtension(FileUploadChat5.FileName);
                FileUploadChat5.PostedFile.SaveAs(Path.Combine(folder, nameFile + strpath));

                int _idImage = _sql.SendChatDashboard(nameFile + strpath, int.Parse(chatID.Value), int.Parse(Request.Cookies["Keys"]["ID"]), 1);
                if (_idImage != 0)
                {
                    status5 = true;
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModal('Data recording failed.');", true);
                }
            }

            if (statusText == true && status1 == true && status2 == true && status3 == true && status4 == true && status5 == true)
            {
                if (Request.Cookies["Keys"]["Agent_ID"] != "0" && Request.Cookies["Keys"]["Agent_ID"] != "1")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "$('#tbData > thead > tr > th:nth-child(14) , #tbData > tbody > tr > td:nth-child(14), #tbData > tfoot > tr > td:nth-child(14)').css('display', 'none');", true);
                }
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertModal('Chat dashboard success.');", true);
            }
        }

        public void CancelChat_click(Object sender, EventArgs e)
        {
            int _id = _sql.CancelChat(int.Parse(cancelChatID.Value));
            if (_id != 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModal('Unsend chat success.');", true);
                GetChatData("");
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModal('Data recording failed.');", true);
            }
        }
    }
}