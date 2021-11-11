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

namespace Support_Project.Menu_Announcement
{
    public partial class AnnouncementLine : System.Web.UI.Page
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
                    searchDateStart.Value = DateTime.Now.ToString("yyyy-MM-dd") + " 00:00:00";
                    searchDateTo.Value = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
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
            DataTable table = new DataTable();
            int _idTotal = 0;
            _idTotal = _sql.SearcAnnouncementLineAllPaging(searchDateStart.Value, searchDateTo.Value);
            totalDocs.Value = _idTotal.ToString();

            if (thisPage.Value == "" || thisPage.Value == null)
            {
                PageNow = "1";
            }
            else
            {
                PageNow = thisPage.Value;
            }

            table = _sql.SearchAnnouncementLine(searchDateStart.Value, searchDateTo.Value, int.Parse(PageNow), 100);
            if (table != null && table.Rows.Count > 0)
            {
                var no = 1;
                StringBuilder sb = new StringBuilder();
                foreach (DataRow row in table.Rows)
                {
                    sb.Append("<tr>");
                    sb.Append("<td style='text-align: center;'>" + (((int.Parse(PageNow) - 1) * 100) + no) + "</td>");
                    sb.Append("<td>" + row["description"].ToString() + "</td>");

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

                    if (row["image_name"].ToString() != "")
                    {
                        sb.Append("<td style='text-align: center;'><a onclick='getImage(\"" + row["image_name"].ToString() + "\");' style='font-size: 1rem;' class='link'><i class='fas fa-file-alt'></i></a></td>");
                    }
                    else
                    {
                        sb.Append("<td style='text-align: center;'><a onclick='getImage(\"" + row["image_name"].ToString() + "\");' style='font-size: 1rem;' class='link disabled-link'><i class='fas fa-file-alt'></i></a></td>");
                    }

                    sb.Append("<td style='text-align: center;'>" + create_date + "</td>");
                    sb.Append("<td style='text-align: center;'>" + row["create_by"].ToString() + "</td>");

                    no++;
                }
                LiteralData.Text = sb.ToString();
            }
            else
            {
                StringBuilder sb = new StringBuilder();
                sb.Append("<tr><td colspan='5' style='text-align: center;' set-lan='text:No Data.'></td></tr>");
                LiteralData.Text = sb.ToString();
            }

            ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "setDataLanguage();", true);

            if (eventPaging.Value != "paging")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "GetData(" + _idTotal.ToString() + ");", true);
            }
        }

    }
}