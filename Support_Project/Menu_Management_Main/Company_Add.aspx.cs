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

namespace Support_Project.Menu_Management_Main
{
    public partial class Company_Add : System.Web.UI.Page
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

        public void AddCompany_click(Object sender, EventArgs e)
        {
            try
            {
                int _idChk = _sql.CheckCompany(Name.Text, 0);
                if (_idChk == 0)
                {
                    int _id = _sql.AddCompany(Name.Text, Prefix.Text, Description.Text, Remark.Text, int.Parse(Request.Cookies["Keys"]["ID"]));
                    if (_id != 0)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModal('Add new company success.');", true);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModal('Data recording failed.');", true);
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModalDuplicate('Name is duplicate.');", true);
                }
            }
            catch
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModal('Data recording failed.');", true);
            }
        }
    }
}