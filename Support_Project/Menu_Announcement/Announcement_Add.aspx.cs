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
    public partial class Announcement_Add : System.Web.UI.Page
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
                    BindAgent();
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
                ddlAgent.DataSource = _sql.getAllAgent(int.Parse(Request.Cookies["Keys"]["Company_ID"]), _sql.allAgentMaster(), int.Parse(Request.Cookies["Keys"]["Agent_ID"]));
                ddlAgent.DataBind();
                ddlAgent.Items.Insert(0, new ListItem("Select agent", ""));
                ddlAgent.Items.Insert(1, new ListItem("All", "0"));

                ListItem item = ddlAgent.Items[0];
                item.Attributes["set-lan"] = "text:Select agent";

                ListItem item2 = ddlAgent.Items[1];
                item2.Attributes["set-lan"] = "text:All";

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void AddAnnouncement_click(Object sender, EventArgs e)
        {
            try { 
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
                int _id = _sql.AddAnnouncement(title.Text, description.Text, int.Parse(AnnouncementAgentAdd.Value), allFileAttach, AnnouncementStartDateAdd.Value, AnnouncementToDateAdd.Value, int.Parse(order.Text), int.Parse(Request.Cookies["Keys"]["ID"]));
                if (_id != 0)
                {
                    Response.Redirect("../Menu_Announcement/Announcement.aspx");
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
            catch (Exception ex)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Error : " + ex.Message + "')", true);
            }
        }
    }
}