using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Support_Project.core;

namespace Support_Project.Menu_AMBBO
{
    public partial class ReportConclude : System.Web.UI.Page
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
                IDRole.Value = Request.Cookies["Keys"]["Position"];
            }
            else
            {
                Response.Redirect("../Login.aspx");
            }
        }

        public void Test_click(Object sender, EventArgs e)
        {
        }
    }
}