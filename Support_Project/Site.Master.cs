using System;
using System.Collections.Generic;
using System.Security.Claims;
using System.Security.Principal;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using Support_Project.core;
using System.Data;
using System.Net;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace Support_Project
{
    public partial class SiteMaster : MasterPage
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
                LoginID.Value = Request.Cookies["Keys"]["ID"];
                LoginUser.Value = Request.Cookies["Keys"]["Username"];
                LoginPosi.Value = Request.Cookies["Keys"]["Position"];
                ShareIDLogin.Value = Request.Cookies["Keys"]["Company_ID"];
                AgentIDLogin.Value = Request.Cookies["Keys"]["Agent_ID"];
                AgentName.Value = Request.Cookies["Keys"]["Agent_Name"];
                ToeknID.Value = Request.Cookies["Keys"]["Token_ID"];
                SubAccount.Value = Request.Cookies["Keys"]["SubAccount"];
        }
            else
            {
                Response.Redirect("../Login.aspx");
            }
}

        public void Logout_click(Object sender, EventArgs e)
        {
            var _ip = GetIPAddress();
            DataTable table = new DataTable();
            table = _sql.Logout(int.Parse(Request.Cookies["Keys"]["ID"]), Lat.Value, Long.Value);

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

        public void Emergency_click(Object sender, EventArgs e)
        {
            int _idDel = _sql.LockAgent(int.Parse(Request.Cookies["Keys"]["Agent_ID"]), int.Parse(Request.Cookies["Keys"]["ID"]));
            if (_idDel != 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModalEmer('Lock agent success.');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModalEmer('Data recording failed.');", true);
            }
        }

        public void Logout2_click(Object sender, EventArgs e)
        {
            HttpCookie currentUserCookie = Request.Cookies["Keys"];
            Response.Cookies.Remove("Keys");
            currentUserCookie.Expires = DateTime.Now.AddDays(-10);
            currentUserCookie.Value = null;
            Response.SetCookie(currentUserCookie);
            Response.Redirect("../Login.aspx");
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