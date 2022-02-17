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
using System.Net;
using Newtonsoft.Json;

namespace Support_Project
{
    public partial class AnnouncementLine_Add : System.Web.UI.Page
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
                }
                else
                {
                    Response.Redirect("../Login.aspx");
                }
            }
        }

        public void AddAnnouncement_click(Object sender, EventArgs e)
        {
            try { 
            DataTable table = new DataTable();      
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

            string allFileAttach = string.Join(",", allFile.ToArray());
            try
            {
                string total = _sql.AddAnnouncementLine(description.Text, allFileAttach, int.Parse(Request.Cookies["Keys"]["ID"]));
                if (total.Split(',')[0] != "0")
                {
                    table = _sql.getAllLineToken();
                    if (table != null && table.Rows.Count > 0)
                    {
                        foreach (DataRow row in table.Rows)
                        {
                            string token = row["token"].ToString();
                            try
                            {
                                var request = (HttpWebRequest)WebRequest.Create("https://notify-api.line.me/api/notify");
                                var postData = string.Format("message={0}", description.Text.Replace("",""));

                                if (allFileAttach != "")
                                {
                                    var imageThumbnail = string.Format("imageThumbnail={0}", "https://ambsupport.com/FileAttach/" + total.Split(',')[1]);
                                    var imageFullsize = string.Format("imageFullsize={0}", "https://ambsupport.com/FileAttach/" + total.Split(',')[1]);
                                    postData += "&" + imageThumbnail.ToString() + "&" + imageFullsize.ToString();
                                }

                                var data = Encoding.UTF8.GetBytes(postData);
                                    Encoding.

                                request.Method = "POST";
                                request.ContentType = "application/x-www-form-urlencoded";
                                request.ContentLength = data.Length;
                                request.Headers.Add("Authorization", "Bearer " + token);

                                using (var stream = request.GetRequestStream()) stream.Write(data, 0, data.Length);
                                var response = (HttpWebResponse)request.GetResponse();
                                var responseString = new StreamReader(response.GetResponseStream()).ReadToEnd();
                            }
                            catch (Exception ex)
                            {
                                    LogManager.ServiceLog.WriteExceptionLog(ex, "AddAnnouncement_click");
                                    Response.Write(ex.ToString());
                            }
                        }
                    }

                    Response.Redirect("../Menu_Announcement/AnnouncementLine.aspx");
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alertModal", "alertModal('Data recording failed.');", true);
                }
            }
            catch
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertModal", "alertModal('Data recording failed.');", true);
            }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Error : " + ex.Message + "')", true);
            }
        }
    }
}