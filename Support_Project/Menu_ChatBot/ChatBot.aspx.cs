using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Support_Project.Menu_ChatBot
{
    public partial class ChatBot : System.Web.UI.Page
    {
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

            if (status == false)
            {
                Response.Redirect("../Login.aspx");
            }
        }

        public void Test_click(Object sender, EventArgs e)
        {
        }
    }
}