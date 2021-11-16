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
    public partial class SubAccount_Add : System.Web.UI.Page
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
                    BindLevel();

                    LevelSearch.Value = "0";
                    AgentSearch.Value = Request.Cookies["Keys"]["Agent_ID"];
                    CompanySearch.Value = Request.Cookies["Keys"]["Company_ID"];
                    IDRole.Value = Request.Cookies["Keys"]["Position"];
                    IDAgent.Value = Request.Cookies["Keys"]["Agent_ID"];
                    IDCompany.Value = Request.Cookies["Keys"]["Company_ID"];
                    ShareIDLogin.Value = Request.Cookies["Keys"]["Company_ID"];
                    AgentIDLogin.Value = Request.Cookies["Keys"]["Agent_ID"];
                    LoginPosi.Value = Request.Cookies["Keys"]["Position"];
                }
                else
                {
                    Response.Redirect("../Login.aspx");
                }
            }
        }
        private void BindLevel()
        {
            try
            {
                ddlLevel.DataSource = _sql.getAllRole();
                ddlLevel.DataBind();
                ddlLevel.Items.Insert(0, new ListItem("Select level", ""));

                ListItem item = ddlLevel.Items[0];
                item.Attributes["set-lan"] = "text:Select level";
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void AddMember_click(Object sender, EventArgs e)
        {
            try
            {
                int _idChk = _sql.CheckUsername(username.Text, 0);
                if (_idChk == 0)
                {
                    int _id = _sql.AddSubAccount(username.Text, Utility.Encryptdata2(password.Text), int.Parse(LevelAdd.Value), contact.Text, int.Parse(Request.Cookies["Keys"]["ID"]), name.Text, int.Parse(Request.Cookies["Keys"]["Company_ID"]), int.Parse(Request.Cookies["Keys"]["Agent_ID"]));
                    if (_id != 0)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alertModal", "alertModal('Add new sub account success.');", true);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alertModal", "alertModal('Data recording failed.');", true);
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alertModalDuplicate", "alertModalDuplicate('Username is duplicate.');", true);
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Error : " + ex.Message + "')", true);
            }
        }
    }
}