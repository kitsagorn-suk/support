using Google.Authenticator;  
using System;  
using System.Collections.Generic;  
using System.Linq;  
using System.Web;  
using System.Web.UI;  
using System.Web.UI.WebControls;
using Support_Project.core;

namespace Support_Project
{
    public partial class Authen : System.Web.UI.Page
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
            if (!Page.IsPostBack)
            {
                lblResult.Text = String.Empty;
                lblResult.Visible = false;
                GenerateTwoFactorAuthentication();
                imgQrCode.ImageUrl = AuthenticationBarCodeImage;
            }
        }

        protected void btnValidate_Click(object sender, EventArgs e)
        {
            String pin = txtSecurityCode.Text.Trim();
            Boolean status = ValidateTwoFactorPIN(pin);
            if (status)
            {
                lblResult.Visible = true;
                Response.Redirect("Menu_Dashboard/Dashboard.aspx");
            }
            else
            {
                lblResult.Visible = true;
                lblResult.Text = "ยืนยันตัวตนไม่สำเร็จ กรุณาลองใหม่อีกครั้ง";
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
                }
                else
                {
                    lblResult.Visible = true;
                    lblResult.Text = "ยืนยันตัวตนไม่สำเร็จ กรุณาลองใหม่อีกครั้ง";
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
                    //AuthenticationBarCodeImage = setupInfo.QrCodeSetupImageUrl;
                    AuthenticationManualCode = setupInfo.ManualEntryKey;
                    return true;
                }
            }
           
            return false;
        }
    }
}