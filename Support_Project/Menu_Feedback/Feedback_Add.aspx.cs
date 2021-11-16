using Support_Project.core;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Support_Project.Menu_Feedback
{
    public partial class Feedback_Add : System.Web.UI.Page
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

        public void AddFeedback_click(Object sender, EventArgs e)
        {
            try
            {
                int _id = _sql.AddFeedback(title.Text, MessageText.Text, int.Parse(Request.Cookies["Keys"]["Agent_ID"]), int.Parse(Request.Cookies["Keys"]["ID"]));
                if (_id != 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alertModal", "alertModal('Add new feedback success.');", true);
                }
                else
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