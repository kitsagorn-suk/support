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
            try
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
                    if (tableAgent.Rows.Count > 0 && tableAgent != null)
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
                    newCookie["Agent_Master"] = string.Join(",", arrAgentMaster);
                    //newCookie["Agent_Master"] = "274,5447,12807,12901,12903,12904,12951,12969,12952,12953,12977,13022,13210,13218,13219,13311,12905,12906,12908,12909,12910,12911,12912,12913,12914,12915,12916,12917,12918,13349,13350,13351,13522,13362,13363,13430,13439,13440,12907,12919,12920,12921,12922,12923,12924,12925,12926,13198,12927,12928,12929,12930,12931,12932,12933,12934,12950,12936,13044,12937,12944,12945,12974,12946,12980,12981,12938,13528,12940,12941,12942,12943,12947,12949,12954,12955,12956,13276,13277,12957,12993,12964,12982,12965,12967,12968,12966,12970,12971,12985,12972,12973,12975,13003,12976,13047,13102,13138,12978,12979,12983,12984,12986,13012,12987,12991,12992,12994,12995,12997,12998,12999,13000,13001,13137,13213,13214,13007,13011,13035,13015,13016,13017,13018,13033,13034,13036,13037,13051,13019,13020,13021,13023,13025,13026,13028,13029,13031,13032,13038,13039,13042,13043,13040,13045,13046,13049,13435,13052,13053,13054,13056,13057,13058,13163,13059,13061,13062,13063,13064,13066,13323,13071,13074,13075,13076,13077,13089,13104,13105,13106,13107,13108,13109,13110,13156,13255,13319,13090,13091,13093,13094,13095,13097,13098,13205,13099,13100,13101,13111,13144,13275,13112,13113,13114,13115,13116,13117,13118,13119,13120,13121,13122,13123,13125,13126,13127,13128,13129,13130,13141,13142,13143,13180,13352,13147,13148,13149,13151,13152,13153,13154,13157,13158,13159,13162,13165,13166,13167,13168,13169,13170,13171,13175,13176,13177,13178,13181,13183,13184,13186,13187,13188,13189,13390,13190,13191,13192,13193,13194,13195,13202,13206,13207,13208,13211,13212,13215,13216,13220,13222,13223,13224,13225,13226,13227,13228,13229,13230,13231,13232,13233,13234,13236,13322,13239,13242,13243,13244,13246,13247,13248,13249,13250,13251,13252,13253,13254,13256,13261,13262,13263,13264,13265,13266,13267,13268,13269,13270,13271,13272,13273,13274,13278,13279,13280,13281,13283,13357,13284,13285,13286,13290,13292,13293,13294,13295,13331,13346,13348,13450,13452,13453,13461,13509,13510,13511,13512,13513,13514,13515,13516,13517,13518,13519,13520,13476,13477,13503,13296,13299,13300,13301,13302,13303,13307,13310,13312,13314,13317,13324,13325,13326,13329,13330,13332,13333,13526,13334,13337,13339,13340,13342,13343,13344,13345,13353,13354,13355,13356,13358,13360,13361,13366,13367,13368,13369,13371,13397,13370,13373,13374,13375,13376,13377,13378,13380,13382,13384,13385,13386,13457,13458,13460,13387,13391,13392,13394,13395,13396,13398,13399,13400,13402,13403,13406,13413,13414,13415,13416,13417,13418,13419,13420,13421,13422,13423,13489,13425,13428,13432,13433,13434,13436,13441,13442,13443,13444,13445,13446,13455,13456,13459,13466,13468,13473,13474,13481,13484,13501,13502,13525,13529,13531,12808,12809,12810,13024,13048,13161,13404,13405,12811,12958,12959,12960,12961,12962,12963,13372,12812,12813,12814,12815,12816,12817,12818,12819,12988,12989,12820,12821,12822,12823,12824,12889,12890,12893,12894,12899,13008,13050,13067,13072,13073,13240,13298,13507,13527,13532,12825,12826,12827,12896,12897,12935,12939,13060,13389,13401,12828,12829,12830,12831,12832,13424,12833,12834,12835,12836,13070,12837,12838,12839,12840,12841,12842,13160,12843,12844,13086,13087,13088,13308,13379,12845,12891,12846,12847,12848,12849,12850,12851,12852,12853,12854,12855,13155,13173,13199,13259,12856,13482,13483,13487,12857,12902,12990,12996,13145,13146,13185,13209,13235,13359,13454,12858,12859,12860,12861,12862,12863,12864,12865,12866,12867,12868,12869,13508,12870,12871,12872,12873,12874,12875,12876,12877,12878,12879,12880,13257,13258,12881,12882,12886,12888,13027,13041,13078,13080,13081,13082,13083,13084,13085,13092,13150,13164,13196,13197,13217,13241,13365,13245,13260,13288,13297,13304,13305,13306,13318,13388,13321,13327,13381,13431,13448,13449,13462,13463,13464,13465,13470,13471,13475,13478,13479,13485,13486,13490,13491,13492,13493,13494,13495,13496,13497,13498,13499,13500,13505,13506,13523,13524,1";
                    Response.Cookies.Add(newCookie);


                    txtSecurityCode.Text = "";
                    lblResult.Text = "";
                    GenerateTwoFactorAuthentication(pID);
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

                    string script = "window.onload = function() { alertModalAuthen(); };";
                    ClientScript.RegisterStartupScript(this.GetType(), "alertModalAuthen", script, true);
                }
                else
                {
                    string script = "window.onload = function() { alertModal('Login failed.'); };";
                    ClientScript.RegisterStartupScript(this.GetType(), "alertModal", script, true);
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Error : " + ex.Message + "')", true);
            }
        }

        protected void btnValidate_Click(object sender, EventArgs e)
        {
            try
            {
                String pin = txtSecurityCode.Text.Trim();
                Boolean status = ValidateTwoFactorPIN(pin);
                if (status)
                {
                    var _id = _sql.UsedCodeGUID(int.Parse(Request.Cookies["Keys"]["ID"].ToString()));
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
            catch (Exception ex)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Error : " + ex.Message + "')", true);
            }
        }

        public Boolean ValidateTwoFactorPIN(String pin)
        {
            TwoFactorAuthenticator tfa = new TwoFactorAuthenticator();
            return tfa.ValidateTwoFactorPIN(AuthenticationCode, pin);
        }

        public Boolean GenerateTwoFactorAuthentication(String id)
        {
            var uniqueUserKey = "";
            int userID = int.Parse(id);
            var _id = _sql.CheckGUIDLogin(userID);
            if (_id == null || _id == "")
            {
                Guid guid = Guid.NewGuid();
                int __id = _sql.AddGUIDLogin(userID, guid.ToString());
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
            if (tableAgent.Rows.Count > 0 && tableAgent != null)
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