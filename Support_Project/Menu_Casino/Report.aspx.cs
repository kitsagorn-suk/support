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

namespace Support_Project.Menu_Casino
{
    public partial class Report : System.Web.UI.Page
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
                BindAgent();
                IDRole.Value = Request.Cookies["Keys"]["Position"];
            }
            else
            {
                Response.Redirect("../Login.aspx");
            }
        }

        private void BindAgent()
        {
            DataTable table = new DataTable();
            table = _sql.getAllDropdownAgent();
            StringBuilder sb = new StringBuilder();
            if (table != null && table.Rows.Count > 0)
            {
                foreach (DataRow row in table.Rows)
                {
                    sb.Append("<option value='" + row["name"].ToString() + "'>" + row["name"].ToString() + "</option>");
                }
                LiteralDataDropdown.Text = sb.ToString();
            }
        }

        public void Test_click(Object sender, EventArgs e)
        {
        }
    }
}