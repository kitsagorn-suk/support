using Google.Authenticator;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Security.Cryptography;
using System.Net;
using System.Data;
using Support_Project.core;
using System.Text;
using System.IO;

namespace Support_Project
{
    public partial class Login : System.Web.UI.Page
    {
        SqlManager _sql = new SqlManager();

        String AuthenticationCode
        {
            get
            {
                if (ViewState["AuthenticationCode"] != null)
                    return ViewState["AuthenticationCode"].ToString().Trim();
                return String.Empty;
            }
            set
            {
                ViewState["AuthenticationCode"] = value.Trim();
            }
        }

        String AuthenticationTitle
        {
            get
            {
                return "Ankush";
            }
        }


        String AuthenticationBarCodeImage
        {
            get;
            set;
        }

        String AuthenticationManualCode
        {
            get;
            set;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                username.Text = "";
                password.Text = "";
            }
        }

        public void Login_click(Object sender, EventArgs e)
        {
            var _ip = GetIPAddress();
            DataTable table = new DataTable();
            var generator = new Utility.RandomGenerator();
            var numGen = generator.RandomPassword();
            table = _sql.CheckUserLogin(username.Text, Utility.Encryptdata2(password.Text), _ip, Lat.Value, Long.Value, numGen.ToString());

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                string pUsername = dr["username"].ToString();
                string pRole = dr["role_name"].ToString();
                string pID = dr["id"].ToString();
                string pPassword = dr["password"].ToString();
                string pCompany_id = dr["shareholder_id"].ToString();
                string pAgent_id = dr["agent_id"].ToString();
                string pAgent_name = dr["agent_name"].ToString();
                string pTokenID = dr["token_id"].ToString();
                string pSubAccount = dr["is_sub_account"].ToString();

                    HttpCookie newCookie = new HttpCookie("Keys");
                    newCookie["ID"] = pID;
                    newCookie["Username"] = pUsername;
                    newCookie["Position"] = pRole;
                    newCookie["Password"] = pPassword;
                    newCookie["Company_ID"] = pCompany_id;
                    newCookie["Agent_ID"] = pAgent_id;
                    newCookie["Agent_Name"] = pAgent_name;
                    newCookie["Token_ID"] = pTokenID;
                    newCookie["Lat"] = Lat.Value;
                    newCookie["Long"] = Long.Value;
                    newCookie["SubAccount"] = pSubAccount;

                    var arrAgentMaster = new List<string>();
                    DataTable tableAgent = new DataTable();
                    tableAgent = _sql.GetMasterAgent(int.Parse(pAgent_id));
                    if (tableAgent.Rows.Count > 0)
                    {
                        foreach (DataRow row in tableAgent.Rows)
                        {
                            arrAgentMaster.Add(row["id"].ToString());
                            var total = getAgent(int.Parse(row["id"].ToString()));
                            foreach (string item in total)
                            {
                                arrAgentMaster.Add(item);
                            }
                        }
                    }

                    arrAgentMaster.Add(pAgent_id);
                    //arrAgentMaster.Add("1");
                    newCookie["Agent_Master"] = string.Join(",", arrAgentMaster);
                    Response.Cookies.Add(newCookie);


                txtSecurityCode.Text = "";
                lblResult.Text = "";
                GenerateTwoFactorAuthentication();
                if (AuthenticationBarCodeImage != "")
                {
                    StringBuilder sb = new StringBuilder();
                    sb.Append("<div class='text-center' style='margin-top: 20px;'><img src='" + AuthenticationBarCodeImage + "' /></div>");
                    LiteralimgQrCode.Text = sb.ToString();
                }
                else
                {
                    StringBuilder sb = new StringBuilder();
                    sb.Append("");
                    LiteralimgQrCode.Text = sb.ToString();
                }
                
                //imgQrCode.ImageUrl = AuthenticationBarCodeImage;
                string script = "window.onload = function() { alertModalAuthen(); };";
                ClientScript.RegisterStartupScript(this.GetType(), "alertModalAuthen", script, true);
                //Response.Redirect("/Close.html");
                //Response.Redirect("Menu_Dashboard/Dashboard.aspx");
                //}
            }
            else
            {
                string script = "window.onload = function() { alertModal('Login failed.'); };";
                ClientScript.RegisterStartupScript(this.GetType(), "alertModal", script, true);
            }
        }

        protected void btnValidate_Click(object sender, EventArgs e)
        {
            String pin = txtSecurityCode.Text.Trim();
            Boolean status = ValidateTwoFactorPIN(pin);
            if (status)
            {
                int userID = int.Parse(Request.Cookies["Keys"]["ID"]);
                var _id = _sql.UsedCodeGUID(userID);
                if (_id == null || _id == "")
                {
                    lblResult.Visible = true;
                    lblResult.Text = "ยืนยันตัวตนไม่สำเร็จ กรุณาลองใหม่อีกครั้ง";

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "HidePopup", "$('#myModalLoad').modal('hide')", true);
                }
                else
                {
                    lblResult.Visible = true;
                    lblResult.Text = "";

                    var statusMain = _sql.GetSystemMaintenance();
                    //Response.Write("Test" + statusMain);
                    if (statusMain == "True")
                    {
                        Response.Redirect("/Close.html");
                    }
                    else
                    {
                        Response.Redirect("Menu_Dashboard/Dashboard.aspx");
                    }
                }
            }
            else
            {
                lblResult.Visible = true;
                lblResult.Text = "ยืนยันตัวตนไม่สำเร็จ กรุณาลองใหม่อีกครั้ง";

                ScriptManager.RegisterStartupScript(this, this.GetType(), "HidePopup", "$('#myModalLoad').modal('hide')", true);
            }
        }

        public Boolean ValidateTwoFactorPIN(String pin)
        {
            TwoFactorAuthenticator tfa = new TwoFactorAuthenticator();
            return tfa.ValidateTwoFactorPIN(AuthenticationCode, pin);
        }

        public Boolean GenerateTwoFactorAuthentication()
        {
            var uniqueUserKey = "";
            int userID = int.Parse(Request.Cookies["Keys"]["ID"]);
            var _id = _sql.CheckGUIDLogin(userID);
            if (_id == null || _id == "")
            {
                Guid guid = Guid.NewGuid();
                int __id = _sql.AddGUIDLogin(int.Parse(Request.Cookies["Keys"]["ID"]), guid.ToString());
                if (__id != 0)
                {
                    uniqueUserKey = Convert.ToString(guid).Replace("-", "").Substring(0, 10);

                    AuthenticationCode = uniqueUserKey;

                    Dictionary<String, String> result = new Dictionary<String, String>();
                    TwoFactorAuthenticator tfa = new TwoFactorAuthenticator();
                    var setupInfo = tfa.GenerateSetupCode("Complio", AuthenticationTitle, AuthenticationCode, false, 5);
                    if (setupInfo != null)
                    {
                        AuthenticationBarCodeImage = setupInfo.QrCodeSetupImageUrl;
                        AuthenticationManualCode = setupInfo.ManualEntryKey;
                        return true;
                    }

                    lblResult.Visible = true;
                    lblResult.Text = "";
                }
                else
                {
                    lblResult.Visible = true;
                    lblResult.Text = "ยืนยันตัวตนไม่สำเร็จ กรุณาลองใหม่อีกครั้ง";

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "HidePopup", "$('#myModalLoad').modal('hide')", true);
                }
            }
            else
            {
                uniqueUserKey = Convert.ToString(_id).Replace("-", "").Substring(0, 10);

                AuthenticationCode = uniqueUserKey;

                Dictionary<String, String> result = new Dictionary<String, String>();
                TwoFactorAuthenticator tfa = new TwoFactorAuthenticator();
                var setupInfo = tfa.GenerateSetupCode("Complio", AuthenticationTitle, AuthenticationCode, false, 5);
                if (setupInfo != null)
                {
                    AuthenticationBarCodeImage = "";
                    AuthenticationManualCode = setupInfo.ManualEntryKey;
                    return true;
                }
            }

            return false;
        }

        private string GetIPAddress()
        {
            String strHostName = string.Empty;
            strHostName = Dns.GetHostName();
            IPHostEntry ipHostEntry = Dns.GetHostEntry(strHostName);
            IPAddress[] address = ipHostEntry.AddressList;
            return address[1].ToString();
        }

        public List<string> getAgent(int agentID)
        {
            var arrAgent = new List<string>();
            DataTable tableAgent = new DataTable();
            tableAgent = _sql.GetMasterAgent(agentID);
            if (tableAgent.Rows.Count > 0)
            {
                foreach (DataRow row in tableAgent.Rows)
                {
                    arrAgent.Add(row["id"].ToString());
                    var total = getAgent(int.Parse(row["id"].ToString()));
                    foreach (string item in total)
                    {
                        arrAgent.Add(item);
                    }
                }
            }

            return arrAgent;
        }
    }
}