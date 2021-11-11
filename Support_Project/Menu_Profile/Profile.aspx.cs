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

namespace Support_Project.Menu_Profile
{
    public partial class Profile : System.Web.UI.Page
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
                username.Text = Request.Cookies["Keys"]["Username"];
                level.Text = Request.Cookies["Keys"]["Position"];
                Agent.Text = Request.Cookies["Keys"]["Agent_Name"];
            }
            else
            {
                Response.Redirect("../Login.aspx");
            }
        }
    }
}