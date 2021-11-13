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

namespace Support_Project.Menu_Dashboard
{
    public partial class Dashboard : System.Web.UI.Page
    {
        SqlManager _sql = new SqlManager();
        public static string PageNow;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                    MyTask.Value = "0";
                    CategorySearch.Value = "0";
                    searchDateStart.Value = DateTime.Now.ToString("yyyy-MM-dd") + " 00:00:00";
                    searchDateTo.Value = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");

                    GetAllCaseDashboard();                   
            }
        }

        public void GetAllCaseDashboard()
        {
            try
            {
                DataTable table = new DataTable();
                table = _sql.getAllCaseDashboard(int.Parse(Request.Cookies["Keys"]["Agent_ID"]));
                StringBuilder sb = new StringBuilder();
                StringBuilder sbFooter = new StringBuilder();
                foreach (DataRow row in table.Rows)
                {
                    sb.Append("<tr>");
                    sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'><a onclick='getModalDetail(0);' class='link' set-lan='text:Sport'></a></td>");
                    var countSport = int.Parse(row["sportnew"].ToString()) + int.Parse(row["sportpending"].ToString()) + int.Parse(row["sportclose"].ToString()) + int.Parse(row["sportcancel"].ToString()) + int.Parse(row["sportopen"].ToString());
                    sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + countSport.ToString() + "</td>");
                    sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["sportnew"].ToString() + "</td>");
                    sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["sportopen"].ToString() + "</td>");
                    sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["sportpending"].ToString() + "</td>");
                    sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["sportclose"].ToString() + "</td>");
                    sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["sportcancel"].ToString() + "</td>");
                    sb.Append("</tr>");
                    sb.Append("<tr>");
                    sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'><a onclick='getModalDetail(1);' class='link' set-lan='text:Lotto'></a></td>");
                    var countLotto = int.Parse(row["lottonew"].ToString()) + int.Parse(row["lottopending"].ToString()) + int.Parse(row["lottoclose"].ToString()) + int.Parse(row["lottocancel"].ToString()) + int.Parse(row["lottoopen"].ToString());
                    sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + countLotto + "</td>");
                    sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["lottonew"].ToString() + "</td>");
                    sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["lottoopen"].ToString() + "</td>");
                    sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["lottopending"].ToString() + "</td>");
                    sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["lottoclose"].ToString() + "</td>");
                    sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["lottocancel"].ToString() + "</td>");
                    sb.Append("</tr>");
                    sb.Append("<tr>");
                    sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'><a onclick='getModalDetail(2);' class='link' set-lan='text:Casino'></a></td>");
                    var countCasino = int.Parse(row["casinonew"].ToString()) + int.Parse(row["casinopending"].ToString()) + int.Parse(row["casinoclose"].ToString()) + int.Parse(row["casinocancel"].ToString()) + int.Parse(row["casinoopen"].ToString());
                    sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + countCasino.ToString() + "</td>");
                    sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["casinonew"].ToString() + "</td>");
                    sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["casinoopen"].ToString() + "</td>");
                    sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["casinopending"].ToString() + "</td>");
                    sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["casinoclose"].ToString() + "</td>");
                    sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["casinocancel"].ToString() + "</td>");
                    sb.Append("</tr>");
                    sb.Append("<tr>");
                    sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'><a onclick='getModalDetail(3);' class='link' set-lan='text:Game'></a></td>");
                    var countGame = int.Parse(row["gamenew"].ToString()) + int.Parse(row["gamepending"].ToString()) + int.Parse(row["gameclose"].ToString()) + int.Parse(row["gamecancel"].ToString()) + int.Parse(row["gameopen"].ToString());
                    sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + countGame + "</td>");
                    sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["gamenew"].ToString() + "</td>");
                    sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["gameopen"].ToString() + "</td>");
                    sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["gamepending"].ToString() + "</td>");
                    sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["gameclose"].ToString() + "</td>");
                    sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["gamecancel"].ToString() + "</td>");
                    sb.Append("</tr>");

                    sb.Append("<tr>");
                    sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'><a onclick='getModalDetail(4);' class='link' set-lan='text:Multiplayer'></a></td>");
                    var countMultiplayer = int.Parse(row["multinew"].ToString()) + int.Parse(row["multipending"].ToString()) + int.Parse(row["multiclose"].ToString()) + int.Parse(row["multicancel"].ToString()) + int.Parse(row["multiopen"].ToString());
                    sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + countMultiplayer.ToString() + "</td>");
                    sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["multinew"].ToString() + "</td>");
                    sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["multiopen"].ToString() + "</td>");
                    sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["multipending"].ToString() + "</td>");
                    sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["multiclose"].ToString() + "</td>");
                    sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["multicancel"].ToString() + "</td>");
                    sb.Append("</tr>");

                    sbFooter.Append("<tr class='total'>");
                    sbFooter.Append("<td style='border: 1px #ced4da solid; text-align: right; background-color: #f2e8be; color: rgb(23, 23, 44);' set-lan='text:Total case'>Total case :</td>");
                    var countTotal = int.Parse(countSport.ToString()) + int.Parse(countLotto.ToString()) + int.Parse(countCasino.ToString()) + int.Parse(countGame.ToString()) + int.Parse(countMultiplayer.ToString());
                    sbFooter.Append("<td style='border: 1px #ced4da solid; text-align: center; background-color: #f2e8be; color: rgb(23, 23, 44);'>" + countTotal.ToString() + "</td>");
                    var count1 = int.Parse(row["sportnew"].ToString()) + int.Parse(row["lottonew"].ToString()) + int.Parse(row["casinonew"].ToString()) + int.Parse(row["gamenew"].ToString()) + int.Parse(row["multinew"].ToString());
                    sbFooter.Append("<td style='border: 1px #ced4da solid; text-align: center; background-color: #f2e8be; color: rgb(23, 23, 44);'>" + count1.ToString() + "</td>");
                    var count1_1 = int.Parse(row["sportopen"].ToString()) + int.Parse(row["lottoopen"].ToString()) + int.Parse(row["casinoopen"].ToString()) + int.Parse(row["gameopen"].ToString()) + int.Parse(row["multiopen"].ToString());
                    sbFooter.Append("<td style='border: 1px #ced4da solid; text-align: center; background-color: #f2e8be; color: rgb(23, 23, 44);'>" + count1_1.ToString() + "</td>");
                    var count2 = int.Parse(row["sportpending"].ToString()) + int.Parse(row["lottopending"].ToString()) + int.Parse(row["casinopending"].ToString()) + int.Parse(row["gamepending"].ToString()) + int.Parse(row["multipending"].ToString());
                    sbFooter.Append("<td style='border: 1px #ced4da solid; text-align: center; background-color: #f2e8be; color: rgb(23, 23, 44);'>" + count2.ToString() + "</td>");
                    var count3 = int.Parse(row["sportclose"].ToString()) + int.Parse(row["lottoclose"].ToString()) + int.Parse(row["casinoclose"].ToString()) + int.Parse(row["gameclose"].ToString()) + int.Parse(row["multiclose"].ToString());
                    sbFooter.Append("<td style='border: 1px #ced4da solid; text-align: center; background-color: #f2e8be; color: rgb(23, 23, 44);'>" + count3.ToString() + "</td>");
                    var count4 = int.Parse(row["sportcancel"].ToString()) + int.Parse(row["lottocancel"].ToString()) + int.Parse(row["casinocancel"].ToString()) + int.Parse(row["gamecancel"].ToString()) + int.Parse(row["multicancel"].ToString());
                    sbFooter.Append("<td style='border: 1px #ced4da solid; text-align: center; background-color: #f2e8be; color: rgb(23, 23, 44);'>" + count4.ToString() + "</td>");
                    sbFooter.Append("</tr>");
                }
                LiteralDataAll.Text = sb.ToString();
                LiteralDataAllFooter.Text = sbFooter.ToString();
                GetAllCaseDashboardToday();
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Error : " + ex.Message + "')", true);
            }
        }

        public void GetAllCaseDashboardToday()
        {
            try
            { 
            DataTable table = new DataTable();
            table = _sql.getAllCaseDashboardToday(int.Parse(Request.Cookies["Keys"]["Agent_ID"]));
            StringBuilder sb = new StringBuilder();
            StringBuilder sbFooter = new StringBuilder();
            foreach (DataRow row in table.Rows)
            {
                sb.Append("<tr>");
                sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'><a onclick='getModalDetailToday(0);' class='link' set-lan='text:Sport'></a></td>");
                var countSport = int.Parse(row["sportnew"].ToString()) + int.Parse(row["sportpending"].ToString()) + int.Parse(row["sportclose"].ToString()) + int.Parse(row["sportcancel"].ToString()) + int.Parse(row["sportopen"].ToString());
                sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + countSport.ToString() + "</td>");
                sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["sportnew"].ToString() + "</td>");
                sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["sportopen"].ToString() + "</td>");
                sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["sportpending"].ToString() + "</td>");
                sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["sportclose"].ToString() + "</td>");
                sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["sportcancel"].ToString() + "</td>");
                sb.Append("</tr>");
                sb.Append("<tr>");
                sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'><a onclick='getModalDetailToday(1);' class='link' set-lan='text:Lotto'></a></td>");
                var countLotto = int.Parse(row["lottonew"].ToString()) + int.Parse(row["lottopending"].ToString()) + int.Parse(row["lottoclose"].ToString()) + int.Parse(row["lottocancel"].ToString()) + int.Parse(row["lottoopen"].ToString());
                sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + countLotto + "</td>");
                sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["lottonew"].ToString() + "</td>");
                sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["lottoopen"].ToString() + "</td>");
                sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["lottopending"].ToString() + "</td>");
                sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["lottoclose"].ToString() + "</td>");
                sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["lottocancel"].ToString() + "</td>");
                sb.Append("</tr>");
                sb.Append("<tr>");
                sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'><a onclick='getModalDetailToday(2);' class='link' set-lan='text:Casino'></a></td>");
                var countCasino = int.Parse(row["casinonew"].ToString()) + int.Parse(row["casinopending"].ToString()) + int.Parse(row["casinoclose"].ToString()) + int.Parse(row["casinocancel"].ToString()) + int.Parse(row["casinoopen"].ToString());
                sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + countCasino.ToString() + "</td>");
                sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["casinonew"].ToString() + "</td>");
                sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["casinoopen"].ToString() + "</td>");
                sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["casinopending"].ToString() + "</td>");
                sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["casinoclose"].ToString() + "</td>");
                sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["casinocancel"].ToString() + "</td>");
                sb.Append("</tr>");
                sb.Append("<tr>");
                sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'><a onclick='getModalDetailToday(3);' class='link' set-lan='text:Game'></a></td>");
                var countGame = int.Parse(row["gamenew"].ToString()) + int.Parse(row["gamepending"].ToString()) + int.Parse(row["gameclose"].ToString()) + int.Parse(row["gamecancel"].ToString()) + int.Parse(row["gameopen"].ToString());
                sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + countGame + "</td>");
                sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["gamenew"].ToString() + "</td>");
                sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["gameopen"].ToString() + "</td>");
                sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["gamepending"].ToString() + "</td>");
                sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["gameclose"].ToString() + "</td>");
                sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["gamecancel"].ToString() + "</td>");
                sb.Append("</tr>");

                sb.Append("<tr>");
                sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'><a onclick='getModalDetailToday(4);' class='link' set-lan='text:Multiplayer'></a></td>");
                var countMultiplayer = int.Parse(row["multinew"].ToString()) + int.Parse(row["multipending"].ToString()) + int.Parse(row["multiclose"].ToString()) + int.Parse(row["multicancel"].ToString()) + int.Parse(row["multiopen"].ToString());
                sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + countMultiplayer.ToString() + "</td>");
                sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["multinew"].ToString() + "</td>");
                sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["multiopen"].ToString() + "</td>");
                sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["multipending"].ToString() + "</td>");
                sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["multiclose"].ToString() + "</td>");
                sb.Append("<td style='border: 1px #ced4da solid; text-align: center;'>" + row["multicancel"].ToString() + "</td>");
                sb.Append("</tr>");

                sbFooter.Append("<tr class='total'>");
                sbFooter.Append("<td style='border: 1px #ced4da solid; text-align: right; background-color: #f2e8be; color: rgb(23, 23, 44);' set-lan='text:Total case'>Total case :</td>");
                var countTotal = int.Parse(countSport.ToString()) + int.Parse(countLotto.ToString()) + int.Parse(countCasino.ToString()) + int.Parse(countGame.ToString()) + int.Parse(countMultiplayer.ToString());
                sbFooter.Append("<td style='border: 1px #ced4da solid; text-align: center; background-color: #f2e8be; color: rgb(23, 23, 44);'>" + countTotal.ToString() + "</td>");
                var count1 = int.Parse(row["sportnew"].ToString()) + int.Parse(row["lottonew"].ToString()) + int.Parse(row["casinonew"].ToString()) + int.Parse(row["gamenew"].ToString()) + int.Parse(row["multinew"].ToString());
                sbFooter.Append("<td style='border: 1px #ced4da solid; text-align: center; background-color: #f2e8be; color: rgb(23, 23, 44);'>" + count1.ToString() + "</td>");
                var count1_1 = int.Parse(row["sportopen"].ToString()) + int.Parse(row["lottoopen"].ToString()) + int.Parse(row["casinoopen"].ToString()) + int.Parse(row["gameopen"].ToString()) + int.Parse(row["multiopen"].ToString());
                sbFooter.Append("<td style='border: 1px #ced4da solid; text-align: center; background-color: #f2e8be; color: rgb(23, 23, 44);'>" + count1_1.ToString() + "</td>");
                var count2 = int.Parse(row["sportpending"].ToString()) + int.Parse(row["lottopending"].ToString()) + int.Parse(row["casinopending"].ToString()) + int.Parse(row["gamepending"].ToString()) + int.Parse(row["multipending"].ToString());
                sbFooter.Append("<td style='border: 1px #ced4da solid; text-align: center; background-color: #f2e8be; color: rgb(23, 23, 44);'>" + count2.ToString() + "</td>");
                var count3 = int.Parse(row["sportclose"].ToString()) + int.Parse(row["lottoclose"].ToString()) + int.Parse(row["casinoclose"].ToString()) + int.Parse(row["gameclose"].ToString()) + int.Parse(row["multiclose"].ToString());
                sbFooter.Append("<td style='border: 1px #ced4da solid; text-align: center; background-color: #f2e8be; color: rgb(23, 23, 44);'>" + count3.ToString() + "</td>");
                var count4 = int.Parse(row["sportcancel"].ToString()) + int.Parse(row["lottocancel"].ToString()) + int.Parse(row["casinocancel"].ToString()) + int.Parse(row["gamecancel"].ToString()) + int.Parse(row["multicancel"].ToString());
                sbFooter.Append("<td style='border: 1px #ced4da solid; text-align: center; background-color: #f2e8be; color: rgb(23, 23, 44);'>" + count4.ToString() + "</td>");
                sbFooter.Append("</tr>");
            }
            LiteralDataAllToday.Text = sb.ToString();
            LiteralDataAllFooterToday.Text = sbFooter.ToString();
                GetAllReportDashboard();
                
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Error : " + ex.Message + "')", true);
            }
        }

        public void GetAllReportDashboard()
        {
            try { 
            DataTable table = new DataTable();
            table = _sql.getAllReportSportDashboard(int.Parse(Request.Cookies["Keys"]["Agent_ID"]));
            StringBuilder sbSport = new StringBuilder();
            List<string> SportAgentList = new List<string>();
            List<string> SportTotalList = new List<string>();
            var iSport = 1;
            if (table != null && table.Rows.Count > 0)
            {
                foreach (DataRow row in table.Rows)
                {
                    SportAgentList.Add(row["agent_name"].ToString());
                    SportTotalList.Add(row["total"].ToString());

                    sbSport.Append("<tr>");
                    sbSport.Append("<td>" + iSport + "</td>");
                    sbSport.Append("<td>" + row["agent_name"].ToString() + "</td>");
                    sbSport.Append("<td>" + row["total"].ToString() + "</td>");
                    sbSport.Append("</tr>");
                    iSport++;
                }
            }
            else
            {
                sbSport.Append("<tr><td colspan='3' set-lan='text:No Data.'></td></tr>");
            }
            LiteralSport.Text = sbSport.ToString();
            string SportAgent = string.Join(",", SportAgentList.ToArray());
            dataSportAgent.Value = SportAgent.ToString();
            string SportTotal = string.Join(",", SportTotalList.ToArray());
            dataSportTotal.Value = SportTotal.ToString();

            DataTable table2 = new DataTable();
            table2 = _sql.getAllReportLottoDashboard(int.Parse(Request.Cookies["Keys"]["Agent_ID"]));
            StringBuilder sbLotto = new StringBuilder();
            List<string> LottoAgentList = new List<string>();
            List<string> LottoTotalList = new List<string>();
            var iLotto = 1;
            if (table2.Rows.Count > 0)
            {
                foreach (DataRow row in table2.Rows)
                {
                    LottoAgentList.Add(row["agent_name"].ToString());
                    LottoTotalList.Add(row["total"].ToString());

                    sbLotto.Append("<tr>");
                    sbLotto.Append("<td>" + iLotto + "</td>");
                    sbLotto.Append("<td>" + row["agent_name"].ToString() + "</td>");
                    sbLotto.Append("<td>" + row["total"].ToString() + "</td>");
                    sbLotto.Append("</tr>");
                    iLotto++;
                }
            }
            else
            {
                sbLotto.Append("<tr><td colspan='3' set-lan='text:No Data.'></td></tr>");
            }
            LiteralLotto.Text = sbLotto.ToString();
            string LottoAgent = string.Join(",", LottoAgentList.ToArray());
            dataLottoAgent.Value = LottoAgent.ToString();
            string LottoTotal = string.Join(",", LottoTotalList.ToArray());
            dataLottoTotal.Value = LottoTotal.ToString();

            DataTable table3 = new DataTable();
            table3 = _sql.getAllReportCasinoDashboard(int.Parse(Request.Cookies["Keys"]["Agent_ID"]));
            StringBuilder sbCasino = new StringBuilder();
            List<string> CasinoAgentList = new List<string>();
            List<string> CasinoTotalList = new List<string>();
            var iCasino = 1;
            if (table3.Rows.Count > 0)
            {
                foreach (DataRow row in table3.Rows)
                {
                    CasinoAgentList.Add(row["agent_name"].ToString());
                    CasinoTotalList.Add(row["total"].ToString());

                    sbCasino.Append("<tr>");
                    sbCasino.Append("<td>" + iCasino + "</td>");
                    sbCasino.Append("<td>" + row["agent_name"].ToString() + "</td>");
                    sbCasino.Append("<td>" + row["total"].ToString() + "</td>");
                    sbCasino.Append("</tr>");
                    iCasino++;
                }
            }
            else
            {
                sbCasino.Append("<tr><td colspan='3' set-lan='text:No Data.'></td></tr>");
            }
            LiteralCasino.Text = sbCasino.ToString();
            string CasinoAgent = string.Join(",", CasinoAgentList.ToArray());
            dataCasinoAgent.Value = CasinoAgent.ToString();
            string CasinoTotal = string.Join(",", CasinoTotalList.ToArray());
            dataCasinoTotal.Value = CasinoTotal.ToString();

            DataTable table4 = new DataTable();
            table4 = _sql.getAllReportGameDashboard(int.Parse(Request.Cookies["Keys"]["Agent_ID"]));
            StringBuilder sbGame = new StringBuilder();
            List<string> GameAgentList = new List<string>();
            List<string> GameTotalList = new List<string>();
            var iGame = 1;
            if (table4.Rows.Count > 0)
            {
                foreach (DataRow row in table4.Rows)
                {
                    GameAgentList.Add(row["agent_name"].ToString());
                    GameTotalList.Add(row["total"].ToString());

                    sbGame.Append("<tr>");
                    sbGame.Append("<td>" + iGame + "</td>");
                    sbGame.Append("<td>" + row["agent_name"].ToString() + "</td>");
                    sbGame.Append("<td>" + row["total"].ToString() + "</td>");
                    sbGame.Append("</tr>");
                    iGame++;
                }
            }
            else
            {
                sbGame.Append("<tr><td colspan='3' set-lan='text:No Data.'></td></tr>");
            }
            LiteralGame.Text = sbGame.ToString();
            string GameAgent = string.Join(",", GameAgentList.ToArray());
            dataGameAgent.Value = GameAgent.ToString();
            string GameTotal = string.Join(",", GameTotalList.ToArray());
            dataGameTotal.Value = GameTotal.ToString();

            DataTable table5 = new DataTable();
            table5 = _sql.getAllReportMultiPlayerDashboard(int.Parse(Request.Cookies["Keys"]["Agent_ID"]));
            StringBuilder sbMulti = new StringBuilder();
            List<string> MultiAgentList = new List<string>();
            List<string> MultiTotalList = new List<string>();
            var iMulti = 1;
            if (table5.Rows.Count > 0)
            {
                foreach (DataRow row in table5.Rows)
                {
                    MultiAgentList.Add(row["agent_name"].ToString());
                    MultiTotalList.Add(row["total"].ToString());

                    sbMulti.Append("<tr>");
                    sbMulti.Append("<td>" + iMulti + "</td>");
                    sbMulti.Append("<td>" + row["agent_name"].ToString() + "</td>");
                    sbMulti.Append("<td>" + row["total"].ToString() + "</td>");
                    sbMulti.Append("</tr>");
                    iMulti++;
                }
            }
            else
            {
                sbMulti.Append("<tr><td colspan='3' set-lan='text:No Data.'></td></tr>");
            }
            LiteralMulti.Text = sbMulti.ToString();
            string MultiAgent = string.Join(",", MultiAgentList.ToArray());
            dataMultiAgent.Value = MultiAgent.ToString();
            string MultiTotal = string.Join(",", MultiTotalList.ToArray());
            dataMultiTotal.Value = MultiTotal.ToString();

            DataTable tableAll = new DataTable();
            tableAll = _sql.getAllCaseForDateDashboard(int.Parse(Request.Cookies["Keys"]["Agent_ID"]));
            List<string> DateList = new List<string>();
            List<string> TotalList = new List<string>();
            foreach (DataRow row in tableAll.Rows)
            {
                DateList.Add(row["date"].ToString());
                TotalList.Add(row["total"].ToString());
            }
            string ForDate = string.Join(",", DateList.ToArray());
            dataForDate.Value = ForDate.ToString();
            string ForTotal = string.Join(",", TotalList.ToArray());
            dataForTotal.Value = ForTotal.ToString();
                GetAllReportDashboardToday();
                
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Error : " + ex.Message + "')", true);
            }
        }

        public void GetAllReportDashboardToday()
        {
            try
            {
                DataTable table = new DataTable();
                table = _sql.getAllReportSportDashboardToday(int.Parse(Request.Cookies["Keys"]["Agent_ID"]));
                StringBuilder sbSport = new StringBuilder();
                List<string> SportAgentList = new List<string>();
                List<string> SportTotalList = new List<string>();
                var iSport = 1;
                if (table != null && table.Rows.Count > 0)
                {
                    foreach (DataRow row in table.Rows)
                    {
                        SportAgentList.Add(row["agent_name"].ToString());
                        SportTotalList.Add(row["total"].ToString());

                        sbSport.Append("<tr>");
                        sbSport.Append("<td>" + iSport + "</td>");
                        sbSport.Append("<td>" + row["agent_name"].ToString() + "</td>");
                        sbSport.Append("<td>" + row["total"].ToString() + "</td>");
                        sbSport.Append("</tr>");
                        iSport++;
                    }
                }
                else
                {
                    sbSport.Append("<tr><td colspan='3' set-lan='text:No Data.'></td></tr>");
                }
                LiteralSportToday.Text = sbSport.ToString();

                DataTable table2 = new DataTable();
                table2 = _sql.getAllReportLottoDashboardToday(int.Parse(Request.Cookies["Keys"]["Agent_ID"]));
                StringBuilder sbLotto = new StringBuilder();
                List<string> LottoAgentList = new List<string>();
                List<string> LottoTotalList = new List<string>();
                var iLotto = 1;
                if (table != null && table.Rows.Count > 0)
                {
                    foreach (DataRow row in table2.Rows)
                    {
                        LottoAgentList.Add(row["agent_name"].ToString());
                        LottoTotalList.Add(row["total"].ToString());

                        sbLotto.Append("<tr>");
                        sbLotto.Append("<td>" + iLotto + "</td>");
                        sbLotto.Append("<td>" + row["agent_name"].ToString() + "</td>");
                        sbLotto.Append("<td>" + row["total"].ToString() + "</td>");
                        sbLotto.Append("</tr>");
                        iLotto++;
                    }
                }
                else
                {
                    sbLotto.Append("<tr><td colspan='3' set-lan='text:No Data.'></td></tr>");
                }
                LiteralLottoToday.Text = sbLotto.ToString();

                DataTable table3 = new DataTable();
                table3 = _sql.getAllReportCasinoDashboardToday(int.Parse(Request.Cookies["Keys"]["Agent_ID"]));
                StringBuilder sbCasino = new StringBuilder();
                List<string> CasinoAgentList = new List<string>();
                List<string> CasinoTotalList = new List<string>();
                var iCasino = 1;
                if (table != null && table.Rows.Count > 0)
                {
                    foreach (DataRow row in table3.Rows)
                    {
                        CasinoAgentList.Add(row["agent_name"].ToString());
                        CasinoTotalList.Add(row["total"].ToString());

                        sbCasino.Append("<tr>");
                        sbCasino.Append("<td>" + iCasino + "</td>");
                        sbCasino.Append("<td>" + row["agent_name"].ToString() + "</td>");
                        sbCasino.Append("<td>" + row["total"].ToString() + "</td>");
                        sbCasino.Append("</tr>");
                        iCasino++;
                    }
                }
                else
                {
                    sbCasino.Append("<tr><td colspan='3' set-lan='text:No Data.'></td></tr>");
                }
                LiteralCasinoToday.Text = sbCasino.ToString();

                DataTable table4 = new DataTable();
                table4 = _sql.getAllReportGameDashboardToday(int.Parse(Request.Cookies["Keys"]["Agent_ID"]));
                StringBuilder sbGame = new StringBuilder();
                List<string> GameAgentList = new List<string>();
                List<string> GameTotalList = new List<string>();
                var iGame = 1;
                if (table4.Rows.Count > 0)
                {
                    foreach (DataRow row in table4.Rows)
                    {
                        GameAgentList.Add(row["agent_name"].ToString());
                        GameTotalList.Add(row["total"].ToString());

                        sbGame.Append("<tr>");
                        sbGame.Append("<td>" + iGame + "</td>");
                        sbGame.Append("<td>" + row["agent_name"].ToString() + "</td>");
                        sbGame.Append("<td>" + row["total"].ToString() + "</td>");
                        sbGame.Append("</tr>");
                        iGame++;
                    }
                }
                else
                {
                    sbGame.Append("<tr><td colspan='3' set-lan='text:No Data.'></td></tr>");
                }
                LiteralGameToday.Text = sbGame.ToString();

                DataTable table5 = new DataTable();
                table5 = _sql.getAllReportMultiPlayerDashboardToday(int.Parse(Request.Cookies["Keys"]["Agent_ID"]));
                StringBuilder sbMulti = new StringBuilder();
                List<string> MultiAgentList = new List<string>();
                List<string> MultiTotalList = new List<string>();
                var iMulti = 1;
                if (table5.Rows.Count > 0)
                {
                    foreach (DataRow row in table5.Rows)
                    {
                        MultiAgentList.Add(row["agent_name"].ToString());
                        MultiTotalList.Add(row["total"].ToString());

                        sbMulti.Append("<tr>");
                        sbMulti.Append("<td>" + iMulti + "</td>");
                        sbMulti.Append("<td>" + row["agent_name"].ToString() + "</td>");
                        sbMulti.Append("<td>" + row["total"].ToString() + "</td>");
                        sbMulti.Append("</tr>");
                        iMulti++;
                    }
                }
                else
                {
                    sbMulti.Append("<tr><td colspan='3' set-lan='text:No Data.'></td></tr>");
                }
                LiteralMultiToday.Text = sbMulti.ToString();
                GetAnnouncement();
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Error : " + ex.Message + "')", true);
            }
        }

        public void Search_click(Object sender, EventArgs e)
        {
            GetAnnouncement();
        }

        public void GetAnnouncement()
        {
            try
            {
                DataTable table = new DataTable();

                int _idTotal = 0;
                _idTotal = _sql.SearcAnnouncementPaging(int.Parse(Request.Cookies["Keys"]["Agent_ID"]));
                totalDocs.Value = _idTotal.ToString();

                if (thisPage.Value == "" || thisPage.Value == null)
                {
                    PageNow = "1";
                }
                else
                {
                    PageNow = thisPage.Value;
                }

                table = _sql.GetAnnouncement(int.Parse(PageNow), 1, int.Parse(Request.Cookies["Keys"]["Agent_ID"]));
                if (table != null && table.Rows.Count > 0)
                {
                    foreach (DataRow row in table.Rows)
                    {
                        title.Text = row["title"].ToString();
                        description.Text = row["description"].ToString();

                        var datestartdate = "";
                        if (row["start_date"].ToString() != "" && row["start_date"].ToString() != null)
                        {
                            DateTime oDateStart = Convert.ToDateTime(row["start_date"].ToString());
                            string xStart = oDateStart.ToString("dd-MM-yyyy HH:mm", CultureInfo.InvariantCulture);
                            datestartdate = xStart;
                        }
                        else
                        {
                            datestartdate = "-";
                        }

                        var dateenddate = "";
                        if (row["end_date"].ToString() != "" && row["end_date"].ToString() != null)
                        {
                            DateTime oDateEnd = Convert.ToDateTime(row["end_date"].ToString());
                            string xEnd = oDateEnd.ToString("dd-MM-yyyy HH:mm", CultureInfo.InvariantCulture);
                            dateenddate = xEnd;
                        }
                        else
                        {
                            dateenddate = "-";
                        }

                        startdate.Text = datestartdate;
                        todate.Text = dateenddate;

                        string arrImage = row["image_name"].ToString();
                        StringBuilder sbImage = new StringBuilder();
                        if (arrImage != "" && arrImage != null)
                        {
                            string[] img = arrImage.Split(',');
                            foreach (string item in img)
                            {
                                if (item.Split('.')[1] == "mp4" || item.Split('.')[1] == "mov" || item.Split('.')[1] == "wmv" || item.Split('.')[1] == "avi")
                                {
                                    sbImage.Append("<video class='col-4 vdo' style='width: 100%; height: 135px; margin-bottom: 1rem;' controls>");
                                    sbImage.Append("<source src='../FileAttach/" + item + "'>");
                                    sbImage.Append("</video>");
                                }
                                else
                                {
                                    sbImage.Append("<img class='col-4 imgShow' src='../FileAttach/" + item + "' />");
                                }
                            }

                            LiteralImage.Text = sbImage.ToString();
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "clickzoom();", true);
                        }
                    }

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "$('#modalAnnouncement').modal();", true);
                }

                ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "$('#myModalLoad').modal('hide');", true);

                if (eventPaging.Value != "paging")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "function", "GetData(" + _idTotal.ToString() + ");", true);
                }
             }
            catch (Exception ex)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Error : " + ex.Message + "')", true);
            }
        }
    }
}