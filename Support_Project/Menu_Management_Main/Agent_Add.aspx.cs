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
    public partial class Agent_Add : System.Web.UI.Page
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
                    CompanySearch.Value = Request.Cookies["Keys"]["Company_ID"];
                    ShareIDLogin.Value = Request.Cookies["Keys"]["Company_ID"];
                    BindCompany();
                }
                else
                {
                    Response.Redirect("../Login.aspx");
                }
            }
        }
        private void BindCompany()
        {
            try
            {
                ddlCompany.DataSource = _sql.getAllCompany();
                ddlCompany.DataBind();
                ddlCompany.Items.Insert(0, new ListItem("Select company", ""));

                ListItem item = ddlCompany.Items[0];
                item.Attributes["set-lan"] = "text:Select company";

                if (Request.Cookies["Keys"]["Company_ID"] != "0")
                {
                    ddlCompany.SelectedValue = Request.Cookies["Keys"]["Company_ID"].ToString();
                    ddlCompany.Attributes.Add("disabled", "disabled");
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void AddAgent_click(Object sender, EventArgs e)
        {
            try
            {
                int _idChk = _sql.CheckAgent(Name.Text, 0);
                if (_idChk == 0)
                {
                    int _id = _sql.AddAgent(Name.Text, Prefix.Text, Description.Text, Remark.Text, int.Parse(CompanyAdd.Value), int.Parse(Request.Cookies["Keys"]["ID"]), int.Parse(Request.Cookies["Keys"]["Agent_ID"]));
                    if (_id != 0)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alertModal", "alertModal('Add new agent success.');", true);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alertModal", "alertModal('Data recording failed.');", true);
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alertModalDuplicate", "alertModalDuplicate('Name is duplicate.');", true);
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Error : " + ex.Message + "')", true);
            }
        }
    }
}