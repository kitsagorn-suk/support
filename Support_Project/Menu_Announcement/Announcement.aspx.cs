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
    public partial class Announcement : System.Web.UI.Page
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
                    BindAgent();
                    AgentID.Value = Request.Cookies["Keys"]["Agent_ID"];

                    AgentSearch.Value = "0";
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

        private void BindAgent()
        {
            try
            {
                ddlAgent.DataSource = _sql.getAllAgent(int.Parse(Request.Cookies["Keys"]["Company_ID"]), allagentmaster, int.Parse(Request.Cookies["Keys"]["Agent_ID"]));
                ddlAgent.DataBind();
                ddlAgent.Items.Insert(0, new ListItem("Select agent", ""));
                ddlAgent.Items.Insert(1, new ListItem("All", "0"));

                ListItem item = ddlAgent.Items[0];
                item.Attributes["set-lan"] = "text:Select agent";

                ListItem item2 = ddlAgent.Items[1];
                item2.Attributes["set-lan"] = "text:All";

                ddlAgentSearch.DataSource = _sql.getAllAgent(int.Parse(Request.Cookies["Keys"]["Company_ID"]), allagentmaster, int.Parse(Request.Cookies["Keys"]["Agent_ID"]));
                ddlAgentSearch.DataBind();
                ddlAgentSearch.Items.Insert(0, new ListItem("All", "0"));

                ListItem itemSearch = ddlAgentSearch.Items[0];
                itemSearch.Attributes["set-lan"] = "text:All";
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
            if (AgentSearch.Value == "")
            {
                AgentSearch.Value = "0";
            }

            int _idTotal = 0;
            _idTotal = _sql.SearcAnnouncementAllPaging(searchDateStart.Value, searchDateTo.Value, int.Parse(AgentSearch.Value));
            totalDocs.Value = _idTotal.ToString();

            if (thisPage.Value == "" || thisPage.Value == null)
            {
                PageNow = "1";
            }
            else
            {
                PageNow = thisPage.Value;
            }

            table = _sql.SearchAnnouncement(searchDateStart.Value, searchDateTo.Value, int.Parse(PageNow), 100, int.Parse(AgentSearch.Value));
            if (table != null && table.Rows.Count > 0)
            {
                var no = 1;
                StringBuilder sb = new StringBuilder();
                foreach (DataRow row in table.Rows)
                {
                    sb.Append("<tr>");
                    sb.Append("<td style='text-align: center;'>" + (((int.Parse(PageNow) - 1) * 100) + no) + "</td>");
                    sb.Append("<td>" + row["title"].ToString() + "</td>");
                    sb.Append("<td>" + row["description"].ToString() + "</td>");

                    var start_date = "";
                    if (row["start_date"].ToString() != "" && row["start_date"].ToString() != null)
                    {
                        DateTime oDateLog = Convert.ToDateTime(row["start_date"].ToString());
                        string xLog = oDateLog.ToString("dd-MM-yyyy HH:mm", CultureInfo.InvariantCulture);
                        start_date = xLog;
                    }
                    else
                    {
                        start_date = "-";
                    }

                    var end_date = "";
                    if (row["end_date"].ToString() != "" && row["end_date"].ToString() != null)
                    {
                        DateTime oDateLog = Convert.ToDateTime(row["end_date"].ToString());
                        string xLog = oDateLog.ToString("dd-MM-yyyy HH:mm", CultureInfo.InvariantCulture);
                        end_date = xLog;
                    }
                    else
                    {
                        end_date = "-";
                    }

                    sb.Append("<td style='text-align: center;'>" + row["agent_name"].ToString() + "</td>");
                    sb.Append("<td style='text-align: center;'>" + start_date + "</td>");
                    sb.Append("<td style='text-align: center;'>" + end_date + "</td>");

                    //sb.Append("<td style='text-align: center;'>" + row["order0"].ToString() + "</td>");

                    if (row["image_name"].ToString() != "")
                    {
                        sb.Append("<td style='text-align: center;'><a onclick='getImage(\"" + row["image_name"].ToString() + "\");' style='font-size: 1rem;' class='link'><i class='fas fa-file-alt'></i></a></td>");
                    }
                    else
                    {
                        sb.Append("<td style='text-align: center;'><a onclick='getImage(\"" + row["image_name"].ToString() + "\");' style='font-size: 1rem;' class='link disabled-link'><i class='fas fa-file-alt'></i></a></td>");
                    }

                    if (Request.Cookies["Keys"]["Position"] != "Super User" && Request.Cookies["Keys"]["Position"] != "Master")
                    {
                        sb.Append("<td style='text-align: center;'><a class='link disabled-link'><i class='fas fa-pencil-alt'></i></a>&emsp;<a class='link disabled-link' style='font-size: 1rem;' class='link'><i class='fas fa-file-alt'></i></a>&emsp;<a class='link disabled-link' onclick='viewDelete(\"" + row["id"].ToString() + "\");'><i class='fas fa-trash'></i></a></td>");
                    }
                    else if (Request.Cookies["Keys"]["Position"] == "Super User" || Request.Cookies["Keys"]["Position"] == "Master")
                    {
                        if (Request.Cookies["Keys"]["Agent_ID"] != "0" && Request.Cookies["Keys"]["Agent_ID"] != "1")
                        {
                            sb.Append("<td style='text-align: center;'><a class='link disabled-link'><i class='fas fa-pencil-alt'></i></a>&emsp;<a class='link disabled-link' style='font-size: 1rem;' class='link'><i class='fas fa-file-alt'></i></a>&emsp;<a class='link disabled-link' onclick='viewDelete(\"" + row["id"].ToString() + "\");'><i class='fas fa-trash'></i></a></td>");
                        }
                        else
                        {
                            var txtDesc = row["description"].ToString().Replace("\r\n", "<br/>");
                            txtDesc = txtDesc.Replace("'", "").Replace("\"", "");

                            var start = "";
                            if (row["start_date"].ToString() != "" && row["start_date"].ToString() != null)
                            {
                                DateTime oDateLog = Convert.ToDateTime(row["start_date"].ToString());
                                string xLog = oDateLog.ToString("yyyy-MM-dd HH:mm", CultureInfo.InvariantCulture);
                                start = xLog;
                            }
                            else
                            {
                                start = "-";
                            }

                            var end = "";
                            if (row["end_date"].ToString() != "" && row["end_date"].ToString() != null)
                            {
                                DateTime oDateLog = Convert.ToDateTime(row["end_date"].ToString());
                                string xLog = oDateLog.ToString("yyyy-MM-dd HH:mm", CultureInfo.InvariantCulture);
                                end = xLog;
                            }
                            else
                            {
                                end = "-";
                            }

                            if (row["image_name"].ToString() != "")
                            {
                                sb.Append("<td style='text-align: center;'><a class='link' attr-id='" + row["id"].ToString() + "' attr-title='" + row["title"].ToString() + "' attr-desc='" + txtDesc + "' attr-start='" + start + "'  attr-end='" + end + "' attr-agent='" + row["to_agent"].ToString() + "' attr-order='" + row["order"].ToString() + "' attr-img='" + row["image_name"].ToString() + "' onclick='viewEdit(this);'><i class='fas fa-pencil-alt'></i></a>&emsp;<a onclick='getImageEdit(\"" + row["image_name"].ToString() + "\",\"" + row["id"].ToString() + "\");' style='font-size: 1rem;' class='link'><i class='fas fa-file-alt'></i></a>&emsp;<a class='link' onclick='viewDelete(\"" + row["id"].ToString() + "\");'><i class='fas fa-trash'></i></a></td>");
                            }
                            else
                            {
                                sb.Append("<td style='text-align: center;'><a class='link' attr-id='" + row["id"].ToString() + "' attr-title='" + row["title"].ToString() + "' attr-desc='" + txtDesc + "' attr-start='" + start + "'  attr-end='" + end + "' attr-agent='" + row["to_agent"].ToString() + "' attr-order='" + row["order"].ToString() + "' attr-img='" + row["image_name"].ToString() + "' onclick='viewEdit(this);'><i class='fas fa-pencil-alt'></i></a>&emsp;<a style='font-size: 1rem;' class='link disabled-link'><i class='fas fa-file-alt'></i></a>&emsp;<a class='link' onclick='viewDelete(\"" + row["id"].ToString() + "\");'><i class='fas fa-trash'></i></a></td>");
                            }
                        }
                    }
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

            ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "setDataLanguage();", true);

            if (eventPaging.Value != "paging")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "GetData(" + _idTotal.ToString() + ");", true);
            }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Error : " + ex.Message + "')", true);
            }
        }

        public void DeleteAnnouncement_click(Object sender, EventArgs e)
        {
            try { 
            int _idDel = _sql.DeleteAnnouncement(int.Parse(IDDelete.Value), int.Parse(Request.Cookies["Keys"]["ID"]));
            if (_idDel != 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModal('Delete announcement success.');", true);
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

        public void DeleteImageAnnouncement_click(Object sender, EventArgs e)
        {
            try { 
            int _idDel = _sql.EditImageAnnouncement(int.Parse(IDEditImage.Value), NameDeleteImage.Value);
            if (_idDel != 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModal('Delete file success.');", true);
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

        public void EditAnnouncement_click(Object sender, EventArgs e)
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
            if (NameImage.Value != "")
            {
                allFileAttach = allFileAttach + "," + NameImage.Value;
            }
            try
            {
                int _id = _sql.EditAnnouncement(int.Parse(IDEdit.Value), title.Text, description.Text, int.Parse(AnnouncementAgentAdd.Value), allFileAttach, AnnouncementStartDateAdd.Value, AnnouncementToDateAdd.Value, int.Parse(order.Text), int.Parse(Request.Cookies["Keys"]["ID"]));
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

        public List<string> getAgent(int agentID)
        {
            var arrAgent = new List<string>();
            DataTable tableAgent = new DataTable();
            tableAgent = _sql.GetMasterAgent(agentID);
            if (tableAgent.Rows.Count > 0 && tableAgent != null)
            {
                foreach (DataRow row in tableAgent.Rows)
                {
                    arrAgent.Add(row["id"].ToString());
                    var total = getAgent(int.Parse(row["id"].ToString()));
                    foreach (string item in total)
                    {
                        arrAgent.Add(item);
                    }
                }
            }

            return arrAgent;
        }
    }
}