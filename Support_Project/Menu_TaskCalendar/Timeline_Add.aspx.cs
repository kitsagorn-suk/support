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

namespace Support_Project.Menu_TaskCalendar
{
    public partial class Timeline_Add : System.Web.UI.Page
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
                    DataTable table = new DataTable();
                    table = _sql.getAllLeaveType();
                    if (table != null && table.Rows.Count > 0)
                    {
                        BindLeaveType();
                    }
                }
                else
                {
                    Response.Redirect("../Login.aspx");
                }
            }
        }

        private void BindLeaveType()
        {
            try
            {
                ddlLeaveTypeAdd.DataSource = _sql.getAllLeaveType();
                ddlLeaveTypeAdd.DataBind();
                ddlLeaveTypeAdd.Items.Insert(0, new ListItem("Select type", ""));

                ListItem item = ddlLeaveTypeAdd.Items[0];
                item.Attributes["set-lan"] = "text:Select type";
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void AddLeave_click(Object sender, EventArgs e)
        {
            try
            {
                int _id = _sql.AddLeave(LeaveStartDateAdd.Value, LeaveToDateAdd.Value, int.Parse(LeaveTypeAdd.Value), Description.Text, int.Parse(Request.Cookies["Keys"]["ID"]));
                if (_id != 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "alertModal('Add new leave success.');", true);
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
    }
}