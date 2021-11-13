using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Security.Cryptography;
using System.Net;
using System.Data;
using Support_Project.core;

namespace Support_Project.Menu_Profile
{
    public partial class Password : System.Web.UI.Page
    {
        SqlManager _sql = new SqlManager();
        protected void Page_Load(object sender, EventArgs e)
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
                CurrentPassword.Value = Utility.Decryptdata(Request.Cookies["Keys"]["Password"]);
            }
            else
            {
                Response.Redirect("../Login.aspx");
            }
        }

        public void ChangePass_click(Object sender, EventArgs e)
        {
            try { 
            int _id = _sql.ChangePassword(int.Parse(Request.Cookies["Keys"]["ID"]), Utility.Encryptdata2(oldpassword.Text), Utility.Encryptdata2(confirmpassword.Text));
            if (_id != 0)
            {
                Response.Cookies.Remove("Keys");
                Response.Redirect("../Login.aspx");
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "LogOutSuccess();", true);
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

        public void Logout_click(Object sender, EventArgs e)
        {
            try { 
            var _ip = GetIPAddress();
            DataTable table = new DataTable();
            table = _sql.Logout(int.Parse(Request.Cookies["Keys"]["ID"]), Request.Cookies["Keys"]["Lat"], Request.Cookies["Keys"]["Long"]);

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];

                HttpCookie currentUserCookie = Request.Cookies["Keys"];
                Response.Cookies.Remove("Keys");
                currentUserCookie.Expires = DateTime.Now.AddDays(-10);
                currentUserCookie.Value = null;
                Response.SetCookie(currentUserCookie);

                Response.Redirect("../Login.aspx");
            }
            else
            {
                Response.Write("Data : " + table.Rows.Count);
            }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Error : " + ex.Message + "')", true);
            }
        }

        private string GetIPAddress()
        {
            String strHostName = string.Empty;
            strHostName = Dns.GetHostName();
            IPHostEntry ipHostEntry = Dns.GetHostEntry(strHostName);
            IPAddress[] address = ipHostEntry.AddressList;
            return address[1].ToString();
        }
    }
}