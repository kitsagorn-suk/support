using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Threading;
using System.Web;
using System.Web.Configuration;

namespace Support_Project.core
{
    public class SqlManager
    {
        public static string LoginUsername;
        public static string LoginPosition;
        public static string LoginID;

        public List<String> getAgent(int agentID)
        {
            var arrAgent = new List<String>();
            DataTable tableAgent = new DataTable();
            tableAgent = GetMasterAgent(agentID);
            if (tableAgent.Rows.Count > 0 && tableAgent != null)
            {
                foreach (DataRow row in tableAgent.Rows)
                {
                    arrAgent.Add(row["id"].ToString());
                    var total = getAgent(int.Parse(row["id"].ToString()));
                    foreach (String item in total)
                    {
                        arrAgent.Add(item);
                    }
                }
            }

            return arrAgent;
        }

        public String allAgentMaster()
        {

            var arrAgentMasterAll = "";
            var arrAgentMaster = new List<String>();
            DataTable tableAgent = new DataTable();
            tableAgent = GetMasterAgent(int.Parse(System.Web.HttpContext.Current.Request.Cookies["Keys"]["Agent_ID"]));
            if (tableAgent.Rows.Count > 0 && tableAgent != null)
            {
                try
                {
                    foreach (DataRow row in tableAgent.Rows)
                    {
                        arrAgentMaster.Add(row["id"].ToString());
                        var total = getAgent(int.Parse(row["id"].ToString()));
                        foreach (String item in total)
                        {
                            arrAgentMaster.Add(item);
                        }
                    }
                }
                catch(Exception ex)
                {

                }
            }

            arrAgentMaster.Add(System.Web.HttpContext.Current.Request.Cookies["Keys"]["Agent_ID"]);
            arrAgentMasterAll = String.Join(",", arrAgentMaster);
            return arrAgentMasterAll;
        }

        public int LockAgent(int pID, int pCancelBy)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec cancel_agent @pID, @pCancelBy");

            SqlParameter paramID = new SqlParameter(@"pID", SqlDbType.Int);
            paramID.Direction = ParameterDirection.Input;
            paramID.Value = pID;

            SqlParameter paramCancelBy = new SqlParameter(@"pCancelBy", SqlDbType.Int);
            paramCancelBy.Direction = ParameterDirection.Input;
            paramCancelBy.Value = pCancelBy;

            sql.Parameters.Add(paramID);
            sql.Parameters.Add(paramCancelBy);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["id"]);
            }
            return id;
        }

        public DataTable getAllDropdownAgent()
        {
            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_dropdown_agent");

            table = sql.executeQueryWithReturnTable();

            return table;
        }

        public DataTable GetMasterAgent(int pAgentID)
        {
            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_master_agent @pAgentID");

            SqlParameter paramAgentID = new SqlParameter(@"pAgentID", SqlDbType.Int);
            paramAgentID.Direction = ParameterDirection.Input;
            paramAgentID.Value = pAgentID;

            sql.Parameters.Add(paramAgentID);

            table = sql.executeQueryWithReturnTable();

            return table;
        }

        public int EditImageAnnouncement(int pID, string pImageName)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec update_image_announcement @pID, @pImageName");

            SqlParameter parampID = new SqlParameter(@"pID", SqlDbType.Int);
            parampID.Direction = ParameterDirection.Input;
            parampID.Value = pID;

            SqlParameter paramImageName = new SqlParameter(@"pImageName", SqlDbType.VarChar, 255);
            paramImageName.Direction = ParameterDirection.Input;
            paramImageName.Value = pImageName;

            sql.Parameters.Add(parampID);
            sql.Parameters.Add(paramImageName);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["id"]);

            }
            return id;
        }

        public int CheckBeforeCancelAgent(int pAgentID)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec check_before_cancel_agent @pAgentID");

            SqlParameter paramAgentID = new SqlParameter(@"pAgentID", SqlDbType.Int);
            paramAgentID.Direction = ParameterDirection.Input;
            paramAgentID.Value = pAgentID;

            sql.Parameters.Add(paramAgentID);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["count_id"]);

            }
            return id;
        }

        public int CheckBeforeCancelCompany(int pShareHolderID)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec check_before_cancel_shareholder @pShareHolderID");

            SqlParameter paramShareHolderID = new SqlParameter(@"pShareHolderID", SqlDbType.Int);
            paramShareHolderID.Direction = ParameterDirection.Input;
            paramShareHolderID.Value = pShareHolderID;

            sql.Parameters.Add(paramShareHolderID);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["count_id"]);

            }
            return id;
        }

        public int CheckCompany(string pName, int pID)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec check_shareholder @pName, @pID");

            SqlParameter paramName = new SqlParameter(@"pName", SqlDbType.VarChar, 100);
            paramName.Direction = ParameterDirection.Input;
            paramName.Value = pName;

            SqlParameter paramID = new SqlParameter(@"pID", SqlDbType.Int);
            paramID.Direction = ParameterDirection.Input;
            paramID.Value = pID;

            sql.Parameters.Add(paramName);
            sql.Parameters.Add(paramID);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["count_id"]);

            }
            return id;
        }

        public int CheckAgent(string pName, int pID)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec check_agent @pName, @pID");

            SqlParameter paramName = new SqlParameter(@"pName", SqlDbType.VarChar, 100);
            paramName.Direction = ParameterDirection.Input;
            paramName.Value = pName;

            SqlParameter paramID = new SqlParameter(@"pID", SqlDbType.Int);
            paramID.Direction = ParameterDirection.Input;
            paramID.Value = pID;

            sql.Parameters.Add(paramName);
            sql.Parameters.Add(paramID);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["count_id"]);

            }
            return id;
        }

        public DataTable SearchFeedback(int pAgentID, string pDateFrom, string pDateTo)
        {
            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_search_feedback @pAgentID, @pDateFrom, @pDateTo");

            SqlParameter paramAgentID = new SqlParameter(@"pAgentID", SqlDbType.Int);
            paramAgentID.Direction = ParameterDirection.Input;
            paramAgentID.Value = pAgentID;

            SqlParameter paramDateFrom = new SqlParameter(@"pDateFrom", SqlDbType.VarChar, 100);
            paramDateFrom.Direction = ParameterDirection.Input;
            paramDateFrom.Value = pDateFrom;

            SqlParameter paramDateTo = new SqlParameter(@"pDateTo", SqlDbType.VarChar, 100);
            paramDateTo.Direction = ParameterDirection.Input;
            paramDateTo.Value = pDateTo;

            sql.Parameters.Add(paramAgentID);
            sql.Parameters.Add(paramDateFrom);
            sql.Parameters.Add(paramDateTo);
            
            table = sql.executeQueryWithReturnTable();

            return table;
        }

        public DataTable SearchAnnouncement(string pDateFrom, string pDateTo, int pPage, int pPerPage, int pAgentID)
        {
            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_search_announcement @pDateFrom, @pDateTo, @pPage, @pPerPage, @pAgentID");

            SqlParameter paramDateFrom = new SqlParameter(@"pDateFrom", SqlDbType.VarChar, 100);
            paramDateFrom.Direction = ParameterDirection.Input;
            paramDateFrom.Value = pDateFrom;

            SqlParameter paramDateTo = new SqlParameter(@"pDateTo", SqlDbType.VarChar, 100);
            paramDateTo.Direction = ParameterDirection.Input;
            paramDateTo.Value = pDateTo;

            SqlParameter paramPage = new SqlParameter(@"pPage", SqlDbType.Int);
            paramPage.Direction = ParameterDirection.Input;
            paramPage.Value = pPage;

            SqlParameter paramPerPage = new SqlParameter(@"pPerPage", SqlDbType.Int);
            paramPerPage.Direction = ParameterDirection.Input;
            paramPerPage.Value = pPerPage;

            SqlParameter paramAgentID = new SqlParameter(@"pAgentID", SqlDbType.Int);
            paramAgentID.Direction = ParameterDirection.Input;
            paramAgentID.Value = pAgentID;

            sql.Parameters.Add(paramDateFrom);
            sql.Parameters.Add(paramDateTo);
            sql.Parameters.Add(paramAgentID);
            sql.Parameters.Add(paramPage);
            sql.Parameters.Add(paramPerPage);

            table = sql.executeQueryWithReturnTable();

            return table;
        }

        public int AddAnnouncement(string pTitle, string pDesc, int pToAgent, string pImageName, string pStartDate, string pEndDate, int pOrder, int pCreateBy)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec insert_announcement @pTitle, @pDesc, @pToAgent, @pImageName, @pStartDate, @pEndDate, @pOrder, @pCreateBy");

            SqlParameter paramTitle = new SqlParameter(@"pTitle", SqlDbType.VarChar, 100);
            paramTitle.Direction = ParameterDirection.Input;
            paramTitle.Value = pTitle;

            SqlParameter paramDesc = new SqlParameter(@"pDesc", SqlDbType.Text);
            paramDesc.Direction = ParameterDirection.Input;
            paramDesc.Value = pDesc;

            SqlParameter paramToAgent = new SqlParameter(@"pToAgent", SqlDbType.Int);
            paramToAgent.Direction = ParameterDirection.Input;
            paramToAgent.Value = pToAgent;

            SqlParameter paramImageName = new SqlParameter(@"pImageName", SqlDbType.VarChar, 255);
            paramImageName.Direction = ParameterDirection.Input;
            paramImageName.Value = pImageName;

            SqlParameter paramStartDate = new SqlParameter(@"pStartDate", SqlDbType.VarChar, 100);
            paramStartDate.Direction = ParameterDirection.Input;
            paramStartDate.Value = pStartDate;

            SqlParameter paramEndDate = new SqlParameter(@"pEndDate", SqlDbType.VarChar, 100);
            paramEndDate.Direction = ParameterDirection.Input;
            paramEndDate.Value = pEndDate;

            SqlParameter paramOrder = new SqlParameter(@"pOrder", SqlDbType.Int);
            paramOrder.Direction = ParameterDirection.Input;
            paramOrder.Value = pOrder;

            SqlParameter paramCreateBy = new SqlParameter(@"pCreateBy", SqlDbType.Int);
            paramCreateBy.Direction = ParameterDirection.Input;
            paramCreateBy.Value = pCreateBy;

            sql.Parameters.Add(paramTitle);
            sql.Parameters.Add(paramDesc);
            sql.Parameters.Add(paramToAgent);
            sql.Parameters.Add(paramImageName);
            sql.Parameters.Add(paramStartDate);
            sql.Parameters.Add(paramEndDate);
            sql.Parameters.Add(paramOrder);
            sql.Parameters.Add(paramCreateBy);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["id"]);

            }
            return id;
        }

        public string AddAnnouncementLine(string pDesc, string pImageName, int pCreateBy)
        {
            string img = "";

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec insert_announcement_line @pDesc, @pImageName, @pCreateBy");

            SqlParameter paramDesc = new SqlParameter(@"pDesc", SqlDbType.Text);
            paramDesc.Direction = ParameterDirection.Input;
            paramDesc.Value = pDesc;

            SqlParameter paramImageName = new SqlParameter(@"pImageName", SqlDbType.VarChar, 255);
            paramImageName.Direction = ParameterDirection.Input;
            paramImageName.Value = pImageName;

            SqlParameter paramCreateBy = new SqlParameter(@"pCreateBy", SqlDbType.Int);
            paramCreateBy.Direction = ParameterDirection.Input;
            paramCreateBy.Value = pCreateBy;

            sql.Parameters.Add(paramDesc);
            sql.Parameters.Add(paramImageName);
            sql.Parameters.Add(paramCreateBy);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                img = dr["id"].ToString() + "," + dr["image_name"].ToString();
            }
            return img;
        }

        public int EditAnnouncement(int pID, string pTitle, string pDesc, int pToAgent, string pImageName, string pStartDate, string pEndDate, int pOrder, int pUpdateBy)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec update_announcement @pID, @pTitle, @pDesc, @pToAgent, @pImageName, @pStartDate, @pEndDate, @pOrder, @pUpdateBy");

            SqlParameter paramID = new SqlParameter(@"pID", SqlDbType.Int);
            paramID.Direction = ParameterDirection.Input;
            paramID.Value = pID;

            SqlParameter paramTitle = new SqlParameter(@"pTitle", SqlDbType.VarChar, 100);
            paramTitle.Direction = ParameterDirection.Input;
            paramTitle.Value = pTitle;

            SqlParameter paramDesc = new SqlParameter(@"pDesc", SqlDbType.VarChar, 255);
            paramDesc.Direction = ParameterDirection.Input;
            paramDesc.Value = pDesc;

            SqlParameter paramToAgent = new SqlParameter(@"pToAgent", SqlDbType.Int);
            paramToAgent.Direction = ParameterDirection.Input;
            paramToAgent.Value = pToAgent;

            SqlParameter paramImageName = new SqlParameter(@"pImageName", SqlDbType.VarChar, 255);
            paramImageName.Direction = ParameterDirection.Input;
            paramImageName.Value = pImageName;

            SqlParameter paramStartDate = new SqlParameter(@"pStartDate", SqlDbType.VarChar, 100);
            paramStartDate.Direction = ParameterDirection.Input;
            paramStartDate.Value = pStartDate;

            SqlParameter paramEndDate = new SqlParameter(@"pEndDate", SqlDbType.VarChar, 100);
            paramEndDate.Direction = ParameterDirection.Input;
            paramEndDate.Value = pEndDate;

            SqlParameter paramOrder = new SqlParameter(@"pOrder", SqlDbType.Int);
            paramOrder.Direction = ParameterDirection.Input;
            paramOrder.Value = pOrder;

            SqlParameter paramUpdateBy = new SqlParameter(@"pUpdateBy", SqlDbType.Int);
            paramUpdateBy.Direction = ParameterDirection.Input;
            paramUpdateBy.Value = pUpdateBy;

            sql.Parameters.Add(paramID);
            sql.Parameters.Add(paramTitle);
            sql.Parameters.Add(paramDesc);
            sql.Parameters.Add(paramToAgent);
            sql.Parameters.Add(paramImageName);
            sql.Parameters.Add(paramStartDate);
            sql.Parameters.Add(paramEndDate);
            sql.Parameters.Add(paramOrder);
            sql.Parameters.Add(paramUpdateBy);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["id"]);

            }
            return id;
        }

        public int DeleteAnnouncement(int pID, int pCancelBy)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec cancel_announcement @pID, @pCancelBy");

            SqlParameter paramID = new SqlParameter(@"pID", SqlDbType.Int);
            paramID.Direction = ParameterDirection.Input;
            paramID.Value = pID;

            SqlParameter paramCancelBy = new SqlParameter(@"pCancelBy", SqlDbType.Int);
            paramCancelBy.Direction = ParameterDirection.Input;
            paramCancelBy.Value = pCancelBy;

            sql.Parameters.Add(paramID);
            sql.Parameters.Add(paramCancelBy);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["id"]);
            }
            return id;
        }

        public DataTable GetAnnouncement(int pPage, int pPerPage, int pAgentID)
        {
            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_announcement @pPage, @pPerPage, @pAgentID");

            SqlParameter paramPage = new SqlParameter(@"pPage", SqlDbType.Int);
            paramPage.Direction = ParameterDirection.Input;
            paramPage.Value = pPage;

            SqlParameter paramPerPage = new SqlParameter(@"pPerPage", SqlDbType.Int);
            paramPerPage.Direction = ParameterDirection.Input;
            paramPerPage.Value = pPerPage;

            SqlParameter paramAgentID = new SqlParameter(@"pAgentID", SqlDbType.Int);
            paramAgentID.Direction = ParameterDirection.Input;
            paramAgentID.Value = pAgentID;

            sql.Parameters.Add(paramPage);
            sql.Parameters.Add(paramPerPage);
            sql.Parameters.Add(paramAgentID);

            table = sql.executeQueryWithReturnTable();

            return table;
        }

        public int SearcAnnouncementPaging(int pAgentID)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_total_announcement @pAgentID");

            SqlParameter paramAgentID = new SqlParameter(@"pAgentID", SqlDbType.Int);
            paramAgentID.Direction = ParameterDirection.Input;
            paramAgentID.Value = pAgentID;

            sql.Parameters.Add(paramAgentID);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["total"].ToString());
            }

            return id;
        }

        public int SearcAnnouncementAllPaging(string pDateFrom, string pDateTo, int pAgentID)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_total_search_announcement @pDateFrom, @pDateTo, @pAgentID");

            SqlParameter paramDateFrom = new SqlParameter(@"pDateFrom", SqlDbType.DateTime);
            paramDateFrom.Direction = ParameterDirection.Input;
            paramDateFrom.Value = pDateFrom;

            SqlParameter paramDateTo = new SqlParameter(@"pDateTo", SqlDbType.DateTime);
            paramDateTo.Direction = ParameterDirection.Input;
            paramDateTo.Value = pDateTo;

            SqlParameter paramAgentID = new SqlParameter(@"pAgentID", SqlDbType.Int);
            paramAgentID.Direction = ParameterDirection.Input;
            paramAgentID.Value = pAgentID;

            sql.Parameters.Add(paramDateFrom);
            sql.Parameters.Add(paramDateTo);
            sql.Parameters.Add(paramAgentID);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["total"].ToString());
            }

            return id;
        }

        public int SearcAnnouncementLineAllPaging(string pDateFrom, string pDateTo)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_total_search_announcement_line @pDateFrom, @pDateTo");

            SqlParameter paramDateFrom = new SqlParameter(@"pDateFrom", SqlDbType.DateTime);
            paramDateFrom.Direction = ParameterDirection.Input;
            paramDateFrom.Value = pDateFrom;

            SqlParameter paramDateTo = new SqlParameter(@"pDateTo", SqlDbType.DateTime);
            paramDateTo.Direction = ParameterDirection.Input;
            paramDateTo.Value = pDateTo;

            sql.Parameters.Add(paramDateFrom);
            sql.Parameters.Add(paramDateTo);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["total"].ToString());
            }

            return id;
        }

        public DataTable SearchAnnouncementLine(string pDateFrom, string pDateTo, int pPage, int pPerPage)
        {
            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_search_announcement_line @pDateFrom, @pDateTo, @pPage, @pPerPage");

            SqlParameter paramDateFrom = new SqlParameter(@"pDateFrom", SqlDbType.VarChar, 100);
            paramDateFrom.Direction = ParameterDirection.Input;
            paramDateFrom.Value = pDateFrom;

            SqlParameter paramDateTo = new SqlParameter(@"pDateTo", SqlDbType.VarChar, 100);
            paramDateTo.Direction = ParameterDirection.Input;
            paramDateTo.Value = pDateTo;

            SqlParameter paramPage = new SqlParameter(@"pPage", SqlDbType.Int);
            paramPage.Direction = ParameterDirection.Input;
            paramPage.Value = pPage;

            SqlParameter paramPerPage = new SqlParameter(@"pPerPage", SqlDbType.Int);
            paramPerPage.Direction = ParameterDirection.Input;
            paramPerPage.Value = pPerPage;

            sql.Parameters.Add(paramDateFrom);
            sql.Parameters.Add(paramDateTo);
            sql.Parameters.Add(paramPage);
            sql.Parameters.Add(paramPerPage);

            table = sql.executeQueryWithReturnTable();

            return table;
        }

        public DataTable CheckUserLogin(string pUserName, string pPassword, string pIp, string pLat, string pLng, string pTokenID)
        {
            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec login @pUserName, @pPassword, @pIp, @pLat, @pLng, @pTokenID");

            SqlParameter paramUserName = new SqlParameter(@"pUserName", SqlDbType.VarChar, 100);
            paramUserName.Direction = ParameterDirection.Input;
            paramUserName.Value = pUserName;

            SqlParameter paramPassword = new SqlParameter(@"pPassword", SqlDbType.VarChar, 250);
            paramPassword.Direction = ParameterDirection.Input;
            paramPassword.Value = pPassword;

            SqlParameter paramIp = new SqlParameter(@"pIp", SqlDbType.VarChar, 100);
            paramIp.Direction = ParameterDirection.Input;
            paramIp.Value = pIp;

            SqlParameter paramLat = new SqlParameter(@"pLat", SqlDbType.VarChar, 100);
            paramLat.Direction = ParameterDirection.Input;
            paramLat.Value = pLat;

            SqlParameter paramLng = new SqlParameter(@"pLng", SqlDbType.VarChar, 100);
            paramLng.Direction = ParameterDirection.Input;
            paramLng.Value = pLng;

            SqlParameter paramTokenID = new SqlParameter(@"pTokenID", SqlDbType.VarChar, 150);
            paramTokenID.Direction = ParameterDirection.Input;
            paramTokenID.Value = pTokenID;

            sql.Parameters.Add(paramUserName);
            sql.Parameters.Add(paramPassword);
            sql.Parameters.Add(paramIp);
            sql.Parameters.Add(paramLat);
            sql.Parameters.Add(paramLng);
            sql.Parameters.Add(paramTokenID);

            table = sql.executeQueryWithReturnTable();

            return table;
        }

        public DataTable getAllRole()
        {
            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_all_role");

            table = sql.executeQueryWithReturnTable();

            //if (table != null && table.Rows.Count > 0)
            //{
            //    DataRow dr = table.Rows[0];
            //    id = Convert.ToInt32(dr["id"]);

            //}
            return table;
        }

        public DataTable getAllCompany()
        {
            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_all_shareholder");

            table = sql.executeQueryWithReturnTable();

            //if (table != null && table.Rows.Count > 0)
            //{
            //    DataRow dr = table.Rows[0];
            //    id = Convert.ToInt32(dr["id"]);

            //}
            return table;
        }

        public DataTable getAllAgent(int pShareHolderID, string pAllAgentID, int pAgentID)
        {
            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_all_agent @pShareHolderID, @pAllAgentID, @pAgentID");

            SqlParameter paramShareHolderID = new SqlParameter(@"pShareHolderID", SqlDbType.Int);
            paramShareHolderID.Direction = ParameterDirection.Input;
            paramShareHolderID.Value = pShareHolderID;

            SqlParameter paramAllAgentID = new SqlParameter(@"pAllAgentID", SqlDbType.VarChar, 8000);
            paramAllAgentID.Direction = ParameterDirection.Input;
            paramAllAgentID.Value = pAllAgentID;

            SqlParameter paramAgentID = new SqlParameter(@"pAgentID", SqlDbType.Int);
            paramAgentID.Direction = ParameterDirection.Input;
            paramAgentID.Value = pAgentID;

            sql.Parameters.Add(paramShareHolderID);
            sql.Parameters.Add(paramAllAgentID);
            sql.Parameters.Add(paramAgentID);

            table = sql.executeQueryWithReturnTable();

            return table;
        }

        public DataTable getCountNotification(int pUserID)
        {
            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec count_noti_user @pUserID");

            SqlParameter paramUserID = new SqlParameter(@"pUserID", SqlDbType.Int);
            paramUserID.Direction = ParameterDirection.Input;
            paramUserID.Value = pUserID;

            sql.Parameters.Add(paramUserID);

            table = sql.executeQueryWithReturnTable();

            return table;
        }

        public DataTable getAllNotification(int pUserID)
        {
            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_my_task_dashboard @pUserID");

            SqlParameter paramUserID = new SqlParameter(@"pUserID", SqlDbType.Int);
            paramUserID.Direction = ParameterDirection.Input;
            paramUserID.Value = pUserID;

            sql.Parameters.Add(paramUserID);

            table = sql.executeQueryWithReturnTable();

            return table; 
        }

        public DataTable getAllCaseDashboard(int pAgentID)
        {
            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_sum_case_dashboard @pAgentID");

            SqlParameter paramAgentID = new SqlParameter(@"pAgentID", SqlDbType.Int);
            paramAgentID.Direction = ParameterDirection.Input;
            paramAgentID.Value = pAgentID;

            sql.Parameters.Add(paramAgentID);

            table = sql.executeQueryWithReturnTable();

            return table;
        }

        public DataTable getAllCaseDashboardToday(int pAgentID)
        {
            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_sum_case_dashboard_today @pAgentID");

            SqlParameter paramAgentID = new SqlParameter(@"pAgentID", SqlDbType.Int);
            paramAgentID.Direction = ParameterDirection.Input;
            paramAgentID.Value = pAgentID;

            sql.Parameters.Add(paramAgentID);

            table = sql.executeQueryWithReturnTable();

            return table;
        }

        public DataTable getAllCaseForDateDashboard(int pAgentID)
        {
            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_sum_case_for_date @pAgentID");

            SqlParameter paramAgentID = new SqlParameter(@"pAgentID", SqlDbType.Int);
            paramAgentID.Direction = ParameterDirection.Input;
            paramAgentID.Value = pAgentID;

            sql.Parameters.Add(paramAgentID);

            table = sql.executeQueryWithReturnTable();

            return table;
        }

        public DataTable getAllReportSportDashboard(int pAgentID)
        {
            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_sum_sport @pAgentID");

            SqlParameter paramAgentID = new SqlParameter(@"pAgentID", SqlDbType.Int);
            paramAgentID.Direction = ParameterDirection.Input;
            paramAgentID.Value = pAgentID;

            sql.Parameters.Add(paramAgentID);

            table = sql.executeQueryWithReturnTable();

            return table;
        }

        public DataTable getAllReportLottoDashboard(int pAgentID)
        {
            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_sum_lotto @pAgentID");

            SqlParameter paramAgentID = new SqlParameter(@"pAgentID", SqlDbType.Int);
            paramAgentID.Direction = ParameterDirection.Input;
            paramAgentID.Value = pAgentID;

            sql.Parameters.Add(paramAgentID);

            table = sql.executeQueryWithReturnTable();

            return table;
        }

        public DataTable getAllReportCasinoDashboard(int pAgentID)
        {
            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_sum_casino @pAgentID");

            SqlParameter paramAgentID = new SqlParameter(@"pAgentID", SqlDbType.Int);
            paramAgentID.Direction = ParameterDirection.Input;
            paramAgentID.Value = pAgentID;

            sql.Parameters.Add(paramAgentID);

            table = sql.executeQueryWithReturnTable();

            return table;
        }

        public DataTable getAllReportGameDashboard(int pAgentID)
        {
            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_sum_game @pAgentID");

            SqlParameter paramAgentID = new SqlParameter(@"pAgentID", SqlDbType.Int);
            paramAgentID.Direction = ParameterDirection.Input;
            paramAgentID.Value = pAgentID;

            sql.Parameters.Add(paramAgentID);

            table = sql.executeQueryWithReturnTable();

            return table;
        }

        public DataTable getAllReportMultiPlayerDashboard(int pAgentID)
        {
            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_sum_multiplayer @pAgentID");

            SqlParameter paramAgentID = new SqlParameter(@"pAgentID", SqlDbType.Int);
            paramAgentID.Direction = ParameterDirection.Input;
            paramAgentID.Value = pAgentID;

            sql.Parameters.Add(paramAgentID);

            table = sql.executeQueryWithReturnTable();

            return table;
        }

        public DataTable getAllReportSportDashboardToday(int pAgentID)
        {
            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_sum_sport_today @pAgentID");

            SqlParameter paramAgentID = new SqlParameter(@"pAgentID", SqlDbType.Int);
            paramAgentID.Direction = ParameterDirection.Input;
            paramAgentID.Value = pAgentID;

            sql.Parameters.Add(paramAgentID);

            table = sql.executeQueryWithReturnTable();

            return table;
        }

        public DataTable getAllReportLottoDashboardToday(int pAgentID)
        {
            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_sum_lotto_today @pAgentID");

            SqlParameter paramAgentID = new SqlParameter(@"pAgentID", SqlDbType.Int);
            paramAgentID.Direction = ParameterDirection.Input;
            paramAgentID.Value = pAgentID;

            sql.Parameters.Add(paramAgentID);

            table = sql.executeQueryWithReturnTable();

            return table;
        }

        public DataTable getAllReportCasinoDashboardToday(int pAgentID)
        {
            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_sum_casino_today @pAgentID");

            SqlParameter paramAgentID = new SqlParameter(@"pAgentID", SqlDbType.Int);
            paramAgentID.Direction = ParameterDirection.Input;
            paramAgentID.Value = pAgentID;

            sql.Parameters.Add(paramAgentID);

            table = sql.executeQueryWithReturnTable();

            return table;
        }

        public DataTable getAllReportGameDashboardToday(int pAgentID)
        {
            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_sum_game_today @pAgentID");

            SqlParameter paramAgentID = new SqlParameter(@"pAgentID", SqlDbType.Int);
            paramAgentID.Direction = ParameterDirection.Input;
            paramAgentID.Value = pAgentID;

            sql.Parameters.Add(paramAgentID);

            table = sql.executeQueryWithReturnTable();

            return table;
        }

        public DataTable getAllReportMultiPlayerDashboardToday(int pAgentID)
        {
            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_sum_multiplayer_today @pAgentID");

            SqlParameter paramAgentID = new SqlParameter(@"pAgentID", SqlDbType.Int);
            paramAgentID.Direction = ParameterDirection.Input;
            paramAgentID.Value = pAgentID;

            sql.Parameters.Add(paramAgentID);

            table = sql.executeQueryWithReturnTable();

            return table;
        }

        public DataTable getAllLevel()
        {
            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_level");

            table = sql.executeQueryWithReturnTable();

            return table;
        }

        public DataTable GetAllChat(int pDashboardID, int pUserID)
        {
            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_all_chat @pDashboardID, @pUserID");

            SqlParameter paramDashboardID = new SqlParameter(@"pDashboardID", SqlDbType.Int);
            paramDashboardID.Direction = ParameterDirection.Input;
            paramDashboardID.Value = pDashboardID;

            SqlParameter paramUserID = new SqlParameter(@"pUserID", SqlDbType.Int);
            paramUserID.Direction = ParameterDirection.Input;
            paramUserID.Value = pUserID;

            sql.Parameters.Add(paramDashboardID);
            sql.Parameters.Add(paramUserID);

            table = sql.executeQueryWithReturnTable();

            return table;
        }

        public int AddMember(string pUserName, string pPassword, int pRole, string pContact, int pCreateBy, string pFullName, int pShareHolderID, int pAgentID)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec insert_user_login @pUserName, @pPassword, @pRole, @pContact, @pCreateBy, @pFullName, @pShareHolderID, @pAgentID");

            SqlParameter paramUserName = new SqlParameter(@"pUserName", SqlDbType.VarChar, 100);
            paramUserName.Direction = ParameterDirection.Input;
            paramUserName.Value = pUserName;

            SqlParameter paramPassword = new SqlParameter(@"pPassword", SqlDbType.VarChar, 250);
            paramPassword.Direction = ParameterDirection.Input;
            paramPassword.Value = pPassword;

            SqlParameter paramRole = new SqlParameter(@"pRole", SqlDbType.Int);
            paramRole.Direction = ParameterDirection.Input;
            paramRole.Value = pRole;

            SqlParameter paramContact = new SqlParameter(@"pContact", SqlDbType.VarChar, 150);
            paramContact.Direction = ParameterDirection.Input;
            paramContact.Value = pContact;

            SqlParameter paramCreateBy = new SqlParameter(@"pCreateBy", SqlDbType.Int);
            paramCreateBy.Direction = ParameterDirection.Input;
            paramCreateBy.Value = pCreateBy;

            SqlParameter paramFullName = new SqlParameter(@"pFullName", SqlDbType.VarChar, 250);
            paramFullName.Direction = ParameterDirection.Input;
            paramFullName.Value = pFullName;

            SqlParameter paramShareHolderID = new SqlParameter(@"pShareHolderID", SqlDbType.Int);
            paramShareHolderID.Direction = ParameterDirection.Input;
            paramShareHolderID.Value = pShareHolderID;

            SqlParameter paramAgentID = new SqlParameter(@"pAgentID", SqlDbType.Int);
            paramAgentID.Direction = ParameterDirection.Input;
            paramAgentID.Value = pAgentID;

            sql.Parameters.Add(paramUserName);
            sql.Parameters.Add(paramPassword);
            sql.Parameters.Add(paramRole);
            sql.Parameters.Add(paramContact);
            sql.Parameters.Add(paramCreateBy);
            sql.Parameters.Add(paramFullName);
            sql.Parameters.Add(paramShareHolderID);
            sql.Parameters.Add(paramAgentID);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["id"]);

            }
            return id;
        }

        public int AddSubAccount(string pUserName, string pPassword, int pRole, string pContact, int pCreateBy, string pFullName, int pShareHolderID, int pAgentID)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec insert_user_login_sub_account @pUserName, @pPassword, @pRole, @pContact, @pCreateBy, @pFullName, @pShareHolderID, @pAgentID");

            SqlParameter paramUserName = new SqlParameter(@"pUserName", SqlDbType.VarChar, 100);
            paramUserName.Direction = ParameterDirection.Input;
            paramUserName.Value = pUserName;

            SqlParameter paramPassword = new SqlParameter(@"pPassword", SqlDbType.VarChar, 250);
            paramPassword.Direction = ParameterDirection.Input;
            paramPassword.Value = pPassword;

            SqlParameter paramRole = new SqlParameter(@"pRole", SqlDbType.Int);
            paramRole.Direction = ParameterDirection.Input;
            paramRole.Value = pRole;

            SqlParameter paramContact = new SqlParameter(@"pContact", SqlDbType.VarChar, 150);
            paramContact.Direction = ParameterDirection.Input;
            paramContact.Value = pContact;

            SqlParameter paramCreateBy = new SqlParameter(@"pCreateBy", SqlDbType.Int);
            paramCreateBy.Direction = ParameterDirection.Input;
            paramCreateBy.Value = pCreateBy;

            SqlParameter paramFullName = new SqlParameter(@"pFullName", SqlDbType.VarChar, 250);
            paramFullName.Direction = ParameterDirection.Input;
            paramFullName.Value = pFullName;

            SqlParameter paramShareHolderID = new SqlParameter(@"pShareHolderID", SqlDbType.Int);
            paramShareHolderID.Direction = ParameterDirection.Input;
            paramShareHolderID.Value = pShareHolderID;

            SqlParameter paramAgentID = new SqlParameter(@"pAgentID", SqlDbType.Int);
            paramAgentID.Direction = ParameterDirection.Input;
            paramAgentID.Value = pAgentID;

            sql.Parameters.Add(paramUserName);
            sql.Parameters.Add(paramPassword);
            sql.Parameters.Add(paramRole);
            sql.Parameters.Add(paramContact);
            sql.Parameters.Add(paramCreateBy);
            sql.Parameters.Add(paramFullName);
            sql.Parameters.Add(paramShareHolderID);
            sql.Parameters.Add(paramAgentID);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["id"]);

            }
            return id;
        }

        public DataTable SearchSubAccount(string pTextSearch, int pType, int pPage, int pPerPage, int pUserID)
        {
            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_search_user_login_sub_account @pTextSearch, @pType, @pPage, @pPerPage, @pUserID");

            SqlParameter paramTextSearch = new SqlParameter(@"pTextSearch", SqlDbType.VarChar, 20);
            paramTextSearch.Direction = ParameterDirection.Input;
            paramTextSearch.Value = pTextSearch;

            SqlParameter paramType = new SqlParameter(@"pType", SqlDbType.Int);
            paramType.Direction = ParameterDirection.Input;
            paramType.Value = pType;

            SqlParameter paramPage = new SqlParameter(@"pPage", SqlDbType.Int);
            paramPage.Direction = ParameterDirection.Input;
            paramPage.Value = pPage;

            SqlParameter paramPerPage = new SqlParameter(@"pPerPage", SqlDbType.Int);
            paramPerPage.Direction = ParameterDirection.Input;
            paramPerPage.Value = pPerPage;

            SqlParameter paramUserID = new SqlParameter(@"pUserID", SqlDbType.Int);
            paramUserID.Direction = ParameterDirection.Input;
            paramUserID.Value = pUserID;

            sql.Parameters.Add(paramTextSearch);
            sql.Parameters.Add(paramType);
            sql.Parameters.Add(paramPage);
            sql.Parameters.Add(paramPerPage);
            sql.Parameters.Add(paramUserID);

            table = sql.executeQueryWithReturnTable();

            return table;
        }

        public int SearchSubAccountPaging(string pTextSearch, int pType, int pUserID)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_total_search_user_login_sub_account @pTextSearch, @pType, @pUserID");

            SqlParameter paramTextSearch = new SqlParameter(@"pTextSearch", SqlDbType.VarChar, 20);
            paramTextSearch.Direction = ParameterDirection.Input;
            paramTextSearch.Value = pTextSearch;

            SqlParameter paramType = new SqlParameter(@"pType", SqlDbType.Int);
            paramType.Direction = ParameterDirection.Input;
            paramType.Value = pType;

            SqlParameter paramUserID = new SqlParameter(@"pUserID", SqlDbType.Int);
            paramUserID.Direction = ParameterDirection.Input;
            paramUserID.Value = pUserID;

            sql.Parameters.Add(paramTextSearch);
            sql.Parameters.Add(paramType);
            sql.Parameters.Add(paramUserID);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["total"].ToString());
            }

            return id;
        }

        public DataTable SearchMember(string pTextSearch, int pType, string pAllAgentID, int pShareholderID, int pPage, int pPerPage, int pUserID, int pAgentID)
        {
            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_search_user_login @pTextSearch, @pType, @pAllAgentID, @pShareholderID, @pPage, @pPerPage, @pUserID, @pAgentID");

            SqlParameter paramTextSearch = new SqlParameter(@"pTextSearch", SqlDbType.VarChar, 20);
            paramTextSearch.Direction = ParameterDirection.Input;
            paramTextSearch.Value = pTextSearch;

            SqlParameter paramType = new SqlParameter(@"pType", SqlDbType.Int);
            paramType.Direction = ParameterDirection.Input;
            paramType.Value = pType;

            SqlParameter paramAllAgent = new SqlParameter(@"pAllAgentID", SqlDbType.VarChar, 8000);
            paramAllAgent.Direction = ParameterDirection.Input;
            paramAllAgent.Value = pAllAgentID;

            SqlParameter paramShareholder = new SqlParameter(@"pShareholderID", SqlDbType.Int);
            paramShareholder.Direction = ParameterDirection.Input;
            paramShareholder.Value = pShareholderID;

            SqlParameter paramPage = new SqlParameter(@"pPage", SqlDbType.Int);
            paramPage.Direction = ParameterDirection.Input;
            paramPage.Value = pPage;

            SqlParameter paramPerPage = new SqlParameter(@"pPerPage", SqlDbType.Int);
            paramPerPage.Direction = ParameterDirection.Input;
            paramPerPage.Value = pPerPage;

            SqlParameter paramUserID = new SqlParameter(@"pUserID", SqlDbType.Int);
            paramUserID.Direction = ParameterDirection.Input;
            paramUserID.Value = pUserID;

            SqlParameter paramAgentID = new SqlParameter(@"pAgentID", SqlDbType.Int);
            paramAgentID.Direction = ParameterDirection.Input;
            paramAgentID.Value = pAgentID;

            sql.Parameters.Add(paramTextSearch);
            sql.Parameters.Add(paramType);
            sql.Parameters.Add(paramAllAgent);
            sql.Parameters.Add(paramShareholder);
            sql.Parameters.Add(paramPage);
            sql.Parameters.Add(paramPerPage);
            sql.Parameters.Add(paramUserID);
            sql.Parameters.Add(paramAgentID);

            table = sql.executeQueryWithReturnTable();

            return table;
        }

        public int SearchMemberPaging(string pTextSearch, int pType, string pAllAgentID, int pShareholderID, int pUserID, int pAgentID)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_total_search_user_login @pTextSearch, @pType, @pAllAgentID, @pShareholderID, @pUserID, @pAgentID");

            SqlParameter paramTextSearch = new SqlParameter(@"pTextSearch", SqlDbType.VarChar, 20);
            paramTextSearch.Direction = ParameterDirection.Input;
            paramTextSearch.Value = pTextSearch;

            SqlParameter paramType = new SqlParameter(@"pType", SqlDbType.Int);
            paramType.Direction = ParameterDirection.Input;
            paramType.Value = pType;

            SqlParameter paramAllAgent = new SqlParameter(@"pAllAgentID", SqlDbType.VarChar, 8000);
            paramAllAgent.Direction = ParameterDirection.Input;
            paramAllAgent.Value = pAllAgentID;

            SqlParameter paramShareholder = new SqlParameter(@"pShareholderID", SqlDbType.Int);
            paramShareholder.Direction = ParameterDirection.Input;
            paramShareholder.Value = pShareholderID;

            SqlParameter paramUserID = new SqlParameter(@"pUserID", SqlDbType.Int);
            paramUserID.Direction = ParameterDirection.Input;
            paramUserID.Value = pUserID;

            SqlParameter paramAgentID = new SqlParameter(@"pAgentID", SqlDbType.Int);
            paramAgentID.Direction = ParameterDirection.Input;
            paramAgentID.Value = pAgentID;

            sql.Parameters.Add(paramTextSearch);
            sql.Parameters.Add(paramType);
            sql.Parameters.Add(paramAllAgent);
            sql.Parameters.Add(paramShareholder);
            sql.Parameters.Add(paramUserID);
            sql.Parameters.Add(paramAgentID);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["total"].ToString());
            }

            return id;
        }

        public int SearchMemberSubPaging(int pUserID, string pAllAgentID, int pAgentID)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_total_user_login_parent @pUserID, @pAllAgentID, @pAgentID");

            SqlParameter paramUserID = new SqlParameter(@"pUserID", SqlDbType.VarChar, 20);
            paramUserID.Direction = ParameterDirection.Input;
            paramUserID.Value = pUserID;

            SqlParameter paramAllAgent = new SqlParameter(@"pAllAgentID", SqlDbType.VarChar, 8000);
            paramAllAgent.Direction = ParameterDirection.Input;
            paramAllAgent.Value = pAllAgentID;

            SqlParameter paramAgentID = new SqlParameter(@"pAgentID", SqlDbType.Int);
            paramAgentID.Direction = ParameterDirection.Input;
            paramAgentID.Value = pAgentID;

            sql.Parameters.Add(paramUserID);
            sql.Parameters.Add(paramAllAgent);
            sql.Parameters.Add(paramAgentID);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["total"].ToString());
            }

            return id;
        }

        public DataTable SearchMemberSub(int pUserID, string pAllAgentID, int pPage, int pPerPage, int pAgentID)
        {
            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_user_login_parent @pUserID, @pAllAgentID, @pPage, @pPerPage, @pAgentID");

            SqlParameter paramUserID = new SqlParameter(@"pUserID", SqlDbType.Int);
            paramUserID.Direction = ParameterDirection.Input;
            paramUserID.Value = pUserID;

            SqlParameter paramAllAgent = new SqlParameter(@"pAllAgentID", SqlDbType.VarChar, 8000);
            paramAllAgent.Direction = ParameterDirection.Input;
            paramAllAgent.Value = pAllAgentID;

            SqlParameter paramPage = new SqlParameter(@"pPage", SqlDbType.Int);
            paramPage.Direction = ParameterDirection.Input;
            paramPage.Value = pPage;

            SqlParameter paramPerPage = new SqlParameter(@"pPerPage", SqlDbType.Int);
            paramPerPage.Direction = ParameterDirection.Input;
            paramPerPage.Value = pPerPage;

            SqlParameter paramAgentID = new SqlParameter(@"pAgentID", SqlDbType.Int);
            paramAgentID.Direction = ParameterDirection.Input;
            paramAgentID.Value = pAgentID;

            sql.Parameters.Add(paramUserID);
            sql.Parameters.Add(paramAllAgent);
            sql.Parameters.Add(paramPage);
            sql.Parameters.Add(paramPerPage);
            sql.Parameters.Add(paramAgentID);

            table = sql.executeQueryWithReturnTable();

            return table;
        }

        public int CheckUsername(string pUserName, int pUserID)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec check_username @pUserName, @pUserID");

            SqlParameter paramUserName = new SqlParameter(@"pUserName", SqlDbType.VarChar, 100);
            paramUserName.Direction = ParameterDirection.Input;
            paramUserName.Value = pUserName;

            SqlParameter paramUserID = new SqlParameter(@"pUserID", SqlDbType.Int);
            paramUserID.Direction = ParameterDirection.Input;
            paramUserID.Value = pUserID;

            sql.Parameters.Add(paramUserName);
            sql.Parameters.Add(paramUserID);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["count_id"]);

            }
            return id;
        }

        public int SendChatDashboard(string pChatMessage, int pDashboardID, int pCreateBy, int pChatType)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec insert_chat @pChatMessage, @pDashboardID, @pCreateBy, @pChatType");

            SqlParameter paramChatMessage = new SqlParameter(@"pChatMessage", SqlDbType.VarChar, 250);
            paramChatMessage.Direction = ParameterDirection.Input;
            paramChatMessage.Value = pChatMessage;

            SqlParameter paramDashboardID = new SqlParameter(@"pDashboardID", SqlDbType.Int);
            paramDashboardID.Direction = ParameterDirection.Input;
            paramDashboardID.Value = pDashboardID;

            SqlParameter paramCreateBy = new SqlParameter(@"pCreateBy", SqlDbType.Int);
            paramCreateBy.Direction = ParameterDirection.Input;
            paramCreateBy.Value = pCreateBy;

            SqlParameter paramChatType = new SqlParameter(@"pChatType", SqlDbType.Int);
            paramChatType.Direction = ParameterDirection.Input;
            paramChatType.Value = pChatType;

            sql.Parameters.Add(paramChatMessage);
            sql.Parameters.Add(paramDashboardID);
            sql.Parameters.Add(paramCreateBy);
            sql.Parameters.Add(paramChatType);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["id"]);

            }
            return id;
        }

        public int DeleteMember(int pUserID, int pCancelBy)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec cancel_user_login @pUserID, @pCancelBy");

            SqlParameter paramUserID = new SqlParameter(@"pUserID", SqlDbType.Int);
            paramUserID.Direction = ParameterDirection.Input;
            paramUserID.Value = pUserID;

            SqlParameter paramCancelBy = new SqlParameter(@"pCancelBy", SqlDbType.Int);
            paramCancelBy.Direction = ParameterDirection.Input;
            paramCancelBy.Value = pCancelBy;

            sql.Parameters.Add(paramUserID);
            sql.Parameters.Add(paramCancelBy);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["id"]);
            }
            return id;
        }

        public int ReQR(int pUserID)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec reset_qrcode @pUserID");

            SqlParameter paramUserID = new SqlParameter(@"pUserID", SqlDbType.Int);
            paramUserID.Direction = ParameterDirection.Input;
            paramUserID.Value = pUserID;

            sql.Parameters.Add(paramUserID);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["id"]);
            }
            return id;
        }

        public int EditMember(int pUserID, string pUserName, string pPassword, int pRole, string pContact, int pUpdateBy, int pIsActive, string pFullName, int pShareHolderID, int pAgentID)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec update_user_login @pUserID, @pPassword, @pRole, @pContact, @pUpdateBy, @pIsActive, @pUserName, @pFullName, @pShareHolderID, @pAgentID");

            SqlParameter paramUserID = new SqlParameter(@"pUserID", SqlDbType.Int);
            paramUserID.Direction = ParameterDirection.Input;
            paramUserID.Value = pUserID;

            SqlParameter paramPassword = new SqlParameter(@"pPassword", SqlDbType.VarChar, 250);
            paramPassword.Direction = ParameterDirection.Input;
            paramPassword.Value = pPassword;

            SqlParameter paramRole = new SqlParameter(@"pRole", SqlDbType.Int);
            paramRole.Direction = ParameterDirection.Input;
            paramRole.Value = pRole;

            SqlParameter paramContact = new SqlParameter(@"pContact", SqlDbType.VarChar, 150);
            paramContact.Direction = ParameterDirection.Input;
            paramContact.Value = pContact;

            SqlParameter paramUpdateBy = new SqlParameter(@"pUpdateBy", SqlDbType.Int);
            paramUpdateBy.Direction = ParameterDirection.Input;
            paramUpdateBy.Value = pUpdateBy;

            SqlParameter paramStatus = new SqlParameter(@"pIsActive", SqlDbType.Int);
            paramStatus.Direction = ParameterDirection.Input;
            paramStatus.Value = pIsActive;

            SqlParameter paramUserName = new SqlParameter(@"pUserName", SqlDbType.VarChar, 100);
            paramUserName.Direction = ParameterDirection.Input;
            paramUserName.Value = pUserName;

            SqlParameter paramFullName = new SqlParameter(@"pFullName", SqlDbType.VarChar, 250);
            paramFullName.Direction = ParameterDirection.Input;
            paramFullName.Value = pFullName;

            SqlParameter paramShareHolderID = new SqlParameter(@"pShareHolderID", SqlDbType.Int);
            paramShareHolderID.Direction = ParameterDirection.Input;
            paramShareHolderID.Value = pShareHolderID;

            SqlParameter paramAgentID = new SqlParameter(@"pAgentID", SqlDbType.Int);
            paramAgentID.Direction = ParameterDirection.Input;
            paramAgentID.Value = pAgentID;

            sql.Parameters.Add(paramUserID);
            sql.Parameters.Add(paramPassword);
            sql.Parameters.Add(paramRole);
            sql.Parameters.Add(paramContact);
            sql.Parameters.Add(paramUpdateBy);
            sql.Parameters.Add(paramStatus);
            sql.Parameters.Add(paramUserName);
            sql.Parameters.Add(paramFullName);
            sql.Parameters.Add(paramShareHolderID);
            sql.Parameters.Add(paramAgentID);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["id"]);

            }
            return id;
        }

        public DataTable Logout(int pID, string pLat, string pLng)
        {
            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec logout @pId, @pLat, @pLng");

            SqlParameter paramID = new SqlParameter(@"pId", SqlDbType.Int);
            paramID.Direction = ParameterDirection.Input;
            paramID.Value = pID;

            SqlParameter paramLat = new SqlParameter(@"pLat", SqlDbType.VarChar, 100);
            paramLat.Direction = ParameterDirection.Input;
            paramLat.Value = pLat;

            SqlParameter paramLng = new SqlParameter(@"pLng", SqlDbType.VarChar, 100);
            paramLng.Direction = ParameterDirection.Input;
            paramLng.Value = pLng;

            sql.Parameters.Add(paramID);
            sql.Parameters.Add(paramLat);
            sql.Parameters.Add(paramLng);

            table = sql.executeQueryWithReturnTable();

            return table;
        }

        public DataTable getAllCategory()
        {
            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_all_categories");

            table = sql.executeQueryWithReturnTable();

            return table;
        }

        public int AddDashboard(string pProduct, string pAgent, int pCategories, string pImage, int pCreateBy, int pLevel, string pDescWebLink, string pDescUsername, string pDescPassword, string pDescProblem, string pDescTroubleshoot, string pDescAfterFixed, string pDescOther, int pAgentID)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec insert_dashboard @pProduct, @pAgent, @pCategories, @pImage, @pCreateBy, @pLevel, @pDescWebLink, @pDescUsername, @pDescPassword, @pDescProblem, @pDescTroubleshoot, @pDescAfterFixed, @pDescOther, @pAgentID");

            SqlParameter paramProduct = new SqlParameter(@"pProduct", SqlDbType.VarChar, 200);
            paramProduct.Direction = ParameterDirection.Input;
            paramProduct.Value = pProduct;

            SqlParameter paramAgent = new SqlParameter(@"pAgent", SqlDbType.VarChar, 200);
            paramAgent.Direction = ParameterDirection.Input;
            paramAgent.Value = pAgent;

            SqlParameter paramCategories = new SqlParameter(@"pCategories", SqlDbType.Int);
            paramCategories.Direction = ParameterDirection.Input;
            paramCategories.Value = pCategories;

            SqlParameter paramImage = new SqlParameter(@"pImage", SqlDbType.Text);
            paramImage.Direction = ParameterDirection.Input;
            paramImage.Value = pImage;

            SqlParameter paramCreateBy = new SqlParameter(@"pCreateBy", SqlDbType.Int);
            paramCreateBy.Direction = ParameterDirection.Input;
            paramCreateBy.Value = pCreateBy;

            SqlParameter paramLevel = new SqlParameter(@"pLevel", SqlDbType.Int);
            paramLevel.Direction = ParameterDirection.Input;
            paramLevel.Value = pLevel;

            SqlParameter paramWebLink = new SqlParameter(@"pDescWebLink", SqlDbType.VarChar, 255);
            paramWebLink.Direction = ParameterDirection.Input;
            paramWebLink.Value = pDescWebLink;

            SqlParameter paramUsername = new SqlParameter(@"pDescUsername", SqlDbType.VarChar, 255);
            paramUsername.Direction = ParameterDirection.Input;
            paramUsername.Value = pDescUsername;

            SqlParameter paramPassword = new SqlParameter(@"pDescPassword", SqlDbType.VarChar, 255);
            paramPassword.Direction = ParameterDirection.Input;
            paramPassword.Value = pDescPassword;

            SqlParameter paramProblem = new SqlParameter(@"pDescProblem", SqlDbType.VarChar, 255);
            paramProblem.Direction = ParameterDirection.Input;
            paramProblem.Value = pDescProblem;

            SqlParameter paramTroubleshoot = new SqlParameter(@"pDescTroubleshoot", SqlDbType.VarChar, 255);
            paramTroubleshoot.Direction = ParameterDirection.Input;
            paramTroubleshoot.Value = pDescTroubleshoot;

            SqlParameter paramAfterFixed = new SqlParameter(@"pDescAfterFixed", SqlDbType.VarChar, 255);
            paramAfterFixed.Direction = ParameterDirection.Input;
            paramAfterFixed.Value = pDescAfterFixed;

            SqlParameter paramOther = new SqlParameter(@"pDescOther", SqlDbType.VarChar, 255);
            paramOther.Direction = ParameterDirection.Input;
            paramOther.Value = pDescOther;

            SqlParameter paramAgentID = new SqlParameter(@"pAgentID", SqlDbType.Int);
            paramAgentID.Direction = ParameterDirection.Input;
            paramAgentID.Value = pAgentID;

            sql.Parameters.Add(paramProduct);
            sql.Parameters.Add(paramAgent);
            sql.Parameters.Add(paramCategories);
            sql.Parameters.Add(paramImage);
            sql.Parameters.Add(paramCreateBy);
            sql.Parameters.Add(paramLevel);
            sql.Parameters.Add(paramWebLink);
            sql.Parameters.Add(paramUsername);
            sql.Parameters.Add(paramPassword);
            sql.Parameters.Add(paramProblem);
            sql.Parameters.Add(paramTroubleshoot);
            sql.Parameters.Add(paramAfterFixed);
            sql.Parameters.Add(paramOther);
            sql.Parameters.Add(paramAgentID);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["id"]);

            }
            return id;
        }

        public DataTable SearchDashboard(string pTextSearch, int pUserID, string pDateFrom, string pDateTo, int pCategories, string pStatus, int pAgentID, int pPage, int pPerPage, String pAllAgentID)
        {
            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_search_dashboard @pTextSearch, @pUserID, @pDateFrom, @pDateTo, @pCategories, @pStatus, @pAgentID, @pPage, @pPerPage, @pAllAgentID");

            SqlParameter paramTextSearch = new SqlParameter(@"pTextSearch", SqlDbType.VarChar, 20);
            paramTextSearch.Direction = ParameterDirection.Input;
            paramTextSearch.Value = pTextSearch;

            SqlParameter paramUserID = new SqlParameter(@"pUserID", SqlDbType.Int);
            paramUserID.Direction = ParameterDirection.Input;
            paramUserID.Value = pUserID;

            SqlParameter paramDateFrom = new SqlParameter(@"pDateFrom", SqlDbType.VarChar, 100);
            paramDateFrom.Direction = ParameterDirection.Input;
            paramDateFrom.Value = pDateFrom;

            SqlParameter paramDateTo = new SqlParameter(@"pDateTo", SqlDbType.VarChar, 100);
            paramDateTo.Direction = ParameterDirection.Input;
            paramDateTo.Value = pDateTo;

            SqlParameter paramCategories = new SqlParameter(@"pCategories", SqlDbType.Int);
            paramCategories.Direction = ParameterDirection.Input;
            paramCategories.Value = pCategories;

            SqlParameter paramStatus = new SqlParameter(@"pStatus", SqlDbType.VarChar, 100);
            paramStatus.Direction = ParameterDirection.Input;
            paramStatus.Value = pStatus;

            SqlParameter paramAgentID = new SqlParameter(@"pAgentID", SqlDbType.Int);
            paramAgentID.Direction = ParameterDirection.Input;
            paramAgentID.Value = pAgentID;

            SqlParameter paramPage = new SqlParameter(@"pPage", SqlDbType.Int);
            paramPage.Direction = ParameterDirection.Input;
            paramPage.Value = pPage;

            SqlParameter paramPerPage = new SqlParameter(@"pPerPage", SqlDbType.Int);
            paramPerPage.Direction = ParameterDirection.Input;
            paramPerPage.Value = pPerPage;

            SqlParameter paramAllAgentID = new SqlParameter(@"pAllAgentID", SqlDbType.Text);
            paramAllAgentID.Direction = ParameterDirection.Input;
            paramAllAgentID.Value = pAllAgentID;

            sql.Parameters.Add(paramTextSearch);
            sql.Parameters.Add(paramUserID);
            sql.Parameters.Add(paramDateFrom);
            sql.Parameters.Add(paramDateTo);
            sql.Parameters.Add(paramCategories);
            sql.Parameters.Add(paramStatus);
            sql.Parameters.Add(paramAgentID);
            sql.Parameters.Add(paramPage);
            sql.Parameters.Add(paramPerPage);
            sql.Parameters.Add(paramAllAgentID);

            table = sql.executeQueryWithReturnTable();

            return table;
        }

        public int SearchDashboardPaging(string pTextSearch, int pUserID, string pDateFrom, string pDateTo, int pCategories, string pStatus, int pAgentID, String pAllAgentID)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_total_search_dashboard @pTextSearch, @pUserID, @pDateFrom, @pDateTo, @pCategories, @pStatus, @pAgentID, @pAllAgentID");

            SqlParameter paramTextSearch = new SqlParameter(@"pTextSearch", SqlDbType.VarChar, 20);
            paramTextSearch.Direction = ParameterDirection.Input;
            paramTextSearch.Value = pTextSearch;

            SqlParameter paramUserID = new SqlParameter(@"pUserID", SqlDbType.Int);
            paramUserID.Direction = ParameterDirection.Input;
            paramUserID.Value = pUserID;

            SqlParameter paramDateFrom = new SqlParameter(@"pDateFrom", SqlDbType.VarChar, 100);
            paramDateFrom.Direction = ParameterDirection.Input;
            paramDateFrom.Value = pDateFrom;

            SqlParameter paramDateTo = new SqlParameter(@"pDateTo", SqlDbType.VarChar, 100);
            paramDateTo.Direction = ParameterDirection.Input;
            paramDateTo.Value = pDateTo;

            SqlParameter paramCategories = new SqlParameter(@"pCategories", SqlDbType.Int);
            paramCategories.Direction = ParameterDirection.Input;
            paramCategories.Value = pCategories;

            SqlParameter paramStatus = new SqlParameter(@"pStatus", SqlDbType.VarChar, 200);
            paramStatus.Direction = ParameterDirection.Input;
            paramStatus.Value = pStatus;

            SqlParameter paramAgentID = new SqlParameter(@"pAgentID", SqlDbType.Int);
            paramAgentID.Direction = ParameterDirection.Input;
            paramAgentID.Value = pAgentID;

            SqlParameter paramAllAgentID = new SqlParameter(@"pAllAgentID", SqlDbType.Text);
            paramAllAgentID.Direction = ParameterDirection.Input;
            paramAllAgentID.Value = pAllAgentID;

            sql.Parameters.Add(paramTextSearch);
            sql.Parameters.Add(paramUserID);
            sql.Parameters.Add(paramDateFrom);
            sql.Parameters.Add(paramDateTo);
            sql.Parameters.Add(paramCategories);
            sql.Parameters.Add(paramStatus);
            sql.Parameters.Add(paramAgentID);
            sql.Parameters.Add(paramAllAgentID);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["total"].ToString());
            }

            return id;
        }

        public int AddPickup(int pID, int pUserID, string pDateAverage)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec pickup_dashboard @pID, @pUserID, @pDateAverage");

            SqlParameter paramID = new SqlParameter(@"pID", SqlDbType.Int);
            paramID.Direction = ParameterDirection.Input;
            paramID.Value = pID;

            SqlParameter paramUserID = new SqlParameter(@"pUserID", SqlDbType.Int);
            paramUserID.Direction = ParameterDirection.Input;
            paramUserID.Value = pUserID;

            SqlParameter paramDateAverage = new SqlParameter(@"pDateAverage", SqlDbType.VarChar, 100);
            paramDateAverage.Direction = ParameterDirection.Input;
            paramDateAverage.Value = pDateAverage;

            sql.Parameters.Add(paramID);
            sql.Parameters.Add(paramUserID);
            sql.Parameters.Add(paramDateAverage);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["id"]);

            }
            return id;
        }

        public int AddAgent(string pName, string pPrefix, string pDesc, string pRemark, int pShareHolderID, int pCreateBy, int pAgentID)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec insert_agent @pName, @pPrefix, @pDesc, @pRemark, @pShareHolderID, @pCreateBy, @pAgentID");

            SqlParameter paramName = new SqlParameter(@"pName", SqlDbType.VarChar, 50);
            paramName.Direction = ParameterDirection.Input;
            paramName.Value = pName;

            SqlParameter paramPrefix = new SqlParameter(@"pPrefix", SqlDbType.VarChar, 20);
            paramPrefix.Direction = ParameterDirection.Input;
            paramPrefix.Value = pPrefix;

            SqlParameter paramDesc = new SqlParameter(@"pDesc", SqlDbType.VarChar, 255);
            paramDesc.Direction = ParameterDirection.Input;
            paramDesc.Value = pDesc;

            SqlParameter paramRemark = new SqlParameter(@"pRemark", SqlDbType.VarChar, 255);
            paramRemark.Direction = ParameterDirection.Input;
            paramRemark.Value = pRemark;

            SqlParameter paramShareHolderID = new SqlParameter(@"pShareHolderID", SqlDbType.Int);
            paramShareHolderID.Direction = ParameterDirection.Input;
            paramShareHolderID.Value = pShareHolderID;

            SqlParameter paramCreateBy = new SqlParameter(@"pCreateBy", SqlDbType.Int);
            paramCreateBy.Direction = ParameterDirection.Input;
            paramCreateBy.Value = pCreateBy;

            SqlParameter paramAgentID = new SqlParameter(@"pAgentID", SqlDbType.Int);
            paramAgentID.Direction = ParameterDirection.Input;
            paramAgentID.Value = pAgentID;

            sql.Parameters.Add(paramName);
            sql.Parameters.Add(paramPrefix);
            sql.Parameters.Add(paramDesc);
            sql.Parameters.Add(paramRemark);
            sql.Parameters.Add(paramShareHolderID);
            sql.Parameters.Add(paramCreateBy);
            sql.Parameters.Add(paramAgentID);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["id"]);

            }
            return id;
        }

        public int AddCommentDashboard(int pID, string pEditCaseText, int pEditCaseBy)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec update_edit_case @pID, @pEditCaseText, @pEditCaseBy");

            SqlParameter paramID = new SqlParameter(@"pID", SqlDbType.Int);
            paramID.Direction = ParameterDirection.Input;
            paramID.Value = pID;

            SqlParameter paramEditCaseText = new SqlParameter(@"pEditCaseText", SqlDbType.VarChar, 200);
            paramEditCaseText.Direction = ParameterDirection.Input;
            paramEditCaseText.Value = pEditCaseText;

            SqlParameter paramEditCaseBy = new SqlParameter(@"pEditCaseBy", SqlDbType.Int);
            paramEditCaseBy.Direction = ParameterDirection.Input;
            paramEditCaseBy.Value = pEditCaseBy;

            sql.Parameters.Add(paramID);
            sql.Parameters.Add(paramEditCaseText);
            sql.Parameters.Add(paramEditCaseBy);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["id"]);

            }
            return id;
        }

        public int EditAgent(int pID, string pName, string pPrefix, string pDesc, string pRemark, int pShareHolderID, int pUpdateBy)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec update_agent @pID, @pName, @pPrefix, @pDesc, @pRemark, @pShareHolderID, @pUpdateBy");

            SqlParameter paramID = new SqlParameter(@"pID", SqlDbType.Int);
            paramID.Direction = ParameterDirection.Input;
            paramID.Value = pID;

            SqlParameter paramName = new SqlParameter(@"pName", SqlDbType.VarChar, 50);
            paramName.Direction = ParameterDirection.Input;
            paramName.Value = pName;

            SqlParameter paramPrefix = new SqlParameter(@"pPrefix", SqlDbType.VarChar, 20);
            paramPrefix.Direction = ParameterDirection.Input;
            paramPrefix.Value = pPrefix;

            SqlParameter paramDesc = new SqlParameter(@"pDesc", SqlDbType.VarChar, 255);
            paramDesc.Direction = ParameterDirection.Input;
            paramDesc.Value = pDesc;

            SqlParameter paramRemark = new SqlParameter(@"pRemark", SqlDbType.VarChar, 255);
            paramRemark.Direction = ParameterDirection.Input;
            paramRemark.Value = pRemark;

            SqlParameter paramShareHolderID = new SqlParameter(@"pShareHolderID", SqlDbType.Int);
            paramShareHolderID.Direction = ParameterDirection.Input;
            paramShareHolderID.Value = pShareHolderID;

            SqlParameter paramUpdateBy = new SqlParameter(@"pUpdateBy", SqlDbType.Int);
            paramUpdateBy.Direction = ParameterDirection.Input;
            paramUpdateBy.Value = pUpdateBy;

            sql.Parameters.Add(paramID);
            sql.Parameters.Add(paramName);
            sql.Parameters.Add(paramPrefix);
            sql.Parameters.Add(paramDesc);
            sql.Parameters.Add(paramRemark);
            sql.Parameters.Add(paramShareHolderID);
            sql.Parameters.Add(paramUpdateBy);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["id"]);
            }
            return id;
        }

        public int DeleteAgent(int pID, int pCancelBy)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec cancel_agent @pID, @pCancelBy");

            SqlParameter paramID = new SqlParameter(@"pID", SqlDbType.Int);
            paramID.Direction = ParameterDirection.Input;
            paramID.Value = pID;

            SqlParameter paramCancelBy = new SqlParameter(@"pCancelBy", SqlDbType.Int);
            paramCancelBy.Direction = ParameterDirection.Input;
            paramCancelBy.Value = pCancelBy;

            sql.Parameters.Add(paramID);
            sql.Parameters.Add(paramCancelBy);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["id"]);

            }
            return id;
        }

        public int AddFeedback(string pTitle, string pMessageText, int pAgentID, int pCreateBy)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec insert_feedback @pTitle, @pMessageText, @pAgentID, @pCreateBy");

            SqlParameter paramTitle = new SqlParameter(@"pTitle", SqlDbType.VarChar, 150);
            paramTitle.Direction = ParameterDirection.Input;
            paramTitle.Value = pTitle;

            SqlParameter paramMessageText = new SqlParameter(@"pMessageText", SqlDbType.VarChar, 255);
            paramMessageText.Direction = ParameterDirection.Input;
            paramMessageText.Value = pMessageText;

            SqlParameter paramAgentID = new SqlParameter(@"pAgentID", SqlDbType.Int);
            paramAgentID.Direction = ParameterDirection.Input;
            paramAgentID.Value = pAgentID;

            SqlParameter paramCreateBy = new SqlParameter(@"pCreateBy", SqlDbType.Int);
            paramCreateBy.Direction = ParameterDirection.Input;
            paramCreateBy.Value = pCreateBy;

            sql.Parameters.Add(paramTitle);
            sql.Parameters.Add(paramMessageText);
            sql.Parameters.Add(paramAgentID);
            sql.Parameters.Add(paramCreateBy);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["id"]);

            }
            return id;
        }

        public int AddCompany(string pName, string pPrefix, string pDesc, string pRemark, int pCreateBy)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec insert_shareholder @pName, @pPrefix, @pDesc, @pRemark, @pCreateBy");

            SqlParameter paramName = new SqlParameter(@"pName", SqlDbType.VarChar, 50);
            paramName.Direction = ParameterDirection.Input;
            paramName.Value = pName;

            SqlParameter paramPrefix = new SqlParameter(@"pPrefix", SqlDbType.VarChar, 20);
            paramPrefix.Direction = ParameterDirection.Input;
            paramPrefix.Value = pPrefix;

            SqlParameter paramDesc = new SqlParameter(@"pDesc", SqlDbType.VarChar, 255);
            paramDesc.Direction = ParameterDirection.Input;
            paramDesc.Value = pDesc;

            SqlParameter paramRemark = new SqlParameter(@"pRemark", SqlDbType.VarChar, 255);
            paramRemark.Direction = ParameterDirection.Input;
            paramRemark.Value = pRemark;

            SqlParameter paramCreateBy = new SqlParameter(@"pCreateBy", SqlDbType.Int);
            paramCreateBy.Direction = ParameterDirection.Input;
            paramCreateBy.Value = pCreateBy;

            sql.Parameters.Add(paramName);
            sql.Parameters.Add(paramPrefix);
            sql.Parameters.Add(paramDesc);
            sql.Parameters.Add(paramRemark);
            sql.Parameters.Add(paramCreateBy);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["id"]);

            }
            return id;
        }

        public int EditCompany(int pID, string pName, string pPrefix, string pDesc, string pRemark, int pUpdateBy)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec update_shareholder @pID, @pName, @pPrefix, @pDesc, @pRemark, @pUpdateBy");

            SqlParameter paramID = new SqlParameter(@"pID", SqlDbType.Int);
            paramID.Direction = ParameterDirection.Input;
            paramID.Value = pID;

            SqlParameter paramName = new SqlParameter(@"pName", SqlDbType.VarChar, 50);
            paramName.Direction = ParameterDirection.Input;
            paramName.Value = pName;

            SqlParameter paramPrefix = new SqlParameter(@"pPrefix", SqlDbType.VarChar, 20);
            paramPrefix.Direction = ParameterDirection.Input;
            paramPrefix.Value = pPrefix;

            SqlParameter paramDesc = new SqlParameter(@"pDesc", SqlDbType.VarChar, 255);
            paramDesc.Direction = ParameterDirection.Input;
            paramDesc.Value = pDesc;

            SqlParameter paramRemark = new SqlParameter(@"pRemark", SqlDbType.VarChar, 255);
            paramRemark.Direction = ParameterDirection.Input;
            paramRemark.Value = pRemark;

            SqlParameter paramUpdateBy = new SqlParameter(@"pUpdateBy", SqlDbType.Int);
            paramUpdateBy.Direction = ParameterDirection.Input;
            paramUpdateBy.Value = pUpdateBy;

            sql.Parameters.Add(paramID);
            sql.Parameters.Add(paramName);
            sql.Parameters.Add(paramPrefix);
            sql.Parameters.Add(paramDesc);
            sql.Parameters.Add(paramRemark);
            sql.Parameters.Add(paramUpdateBy);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["id"]);

            }
            return id;
        }

        public int DeleteCompany(int pID, int pCancelBy)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec cancel_shareholder @pID, @pCancelBy");

            SqlParameter paramID = new SqlParameter(@"pID", SqlDbType.Int);
            paramID.Direction = ParameterDirection.Input;
            paramID.Value = pID;

            SqlParameter paramCancelBy = new SqlParameter(@"pCancelBy", SqlDbType.Int);
            paramCancelBy.Direction = ParameterDirection.Input;
            paramCancelBy.Value = pCancelBy;

            sql.Parameters.Add(paramID);
            sql.Parameters.Add(paramCancelBy);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["id"]);

            }
            return id;
        }

        public int CloseMyTask(int pID, int pUserID)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec update_acknowledge @pID, @pUserID");

            SqlParameter paramID = new SqlParameter(@"pID", SqlDbType.Int);
            paramID.Direction = ParameterDirection.Input;
            paramID.Value = pID;

            SqlParameter paramUserID = new SqlParameter(@"pUserID", SqlDbType.Int);
            paramUserID.Direction = ParameterDirection.Input;
            paramUserID.Value = pUserID;

            sql.Parameters.Add(paramID);
            sql.Parameters.Add(paramUserID);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["id"]);

            }
            return id;
        }

        public int CommentMyTask(int pID, int pUserID)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec update_acknowledge_edit @pID, @pUserID");

            SqlParameter paramID = new SqlParameter(@"pID", SqlDbType.Int);
            paramID.Direction = ParameterDirection.Input;
            paramID.Value = pID;

            SqlParameter paramUserID = new SqlParameter(@"pUserID", SqlDbType.Int);
            paramUserID.Direction = ParameterDirection.Input;
            paramUserID.Value = pUserID;

            sql.Parameters.Add(paramID);
            sql.Parameters.Add(paramUserID);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["id"]);

            }
            return id;
        }

        public int CloseDashboard(int pID, int pUserID)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec close_dashboard @pID, @pUserID");

            SqlParameter paramID = new SqlParameter(@"pID", SqlDbType.Int);
            paramID.Direction = ParameterDirection.Input;
            paramID.Value = pID;

            SqlParameter paramUserID = new SqlParameter(@"pUserID", SqlDbType.Int);
            paramUserID.Direction = ParameterDirection.Input;
            paramUserID.Value = pUserID;

            sql.Parameters.Add(paramID);
            sql.Parameters.Add(paramUserID);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["id"]);

            }
            return id;
        }

        public int CancelDashboard(int pID, int pUserID)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec cancel_dashboard @pID, @pUserID");

            SqlParameter paramID = new SqlParameter(@"pID", SqlDbType.Int);
            paramID.Direction = ParameterDirection.Input;
            paramID.Value = pID;

            SqlParameter paramUserID = new SqlParameter(@"pUserID", SqlDbType.Int);
            paramUserID.Direction = ParameterDirection.Input;
            paramUserID.Value = pUserID;

            sql.Parameters.Add(paramID);
            sql.Parameters.Add(paramUserID);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["id"]);

            }
            return id;
        }

        public int CancelChat(int pChatID)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec cancel_chat @pChatID");

            SqlParameter paramID = new SqlParameter(@"pChatID", SqlDbType.Int);
            paramID.Direction = ParameterDirection.Input;
            paramID.Value = pChatID;

            sql.Parameters.Add(paramID);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["id"]);

            }
            return id;
        }

        public DataTable getAllLeaveType()
        {
            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_all_leave_type");

            table = sql.executeQueryWithReturnTable();

            return table;
        }

        public DataTable SearchLeave(int pLeaveType, string pDateFrom, string pDateTo)
        {
            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_search_leave @pLeaveType, @pDateFrom, @pDateTo");

            SqlParameter paramLeaveType = new SqlParameter(@"pLeaveType", SqlDbType.Int);
            paramLeaveType.Direction = ParameterDirection.Input;
            paramLeaveType.Value = pLeaveType;

            SqlParameter paramDateFrom = new SqlParameter(@"pDateFrom", SqlDbType.VarChar, 100);
            paramDateFrom.Direction = ParameterDirection.Input;
            paramDateFrom.Value = pDateFrom;

            SqlParameter paramDateTo = new SqlParameter(@"pDateTo", SqlDbType.VarChar, 100);
            paramDateTo.Direction = ParameterDirection.Input;
            paramDateTo.Value = pDateTo;

            sql.Parameters.Add(paramLeaveType);
            sql.Parameters.Add(paramDateFrom);
            sql.Parameters.Add(paramDateTo);

            table = sql.executeQueryWithReturnTable();

            return table;
        }

        public int AddLeave(string pLeaveStartDate, string pLeaveEndDate, int pLeaveType, string pDesc, int pCreateBy)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec insert_leave @pLeaveStartDate, @pLeaveEndDate, @pLeaveType, @pDesc, @pCreateBy");

            SqlParameter paramLeaveStartDate = new SqlParameter(@"pLeaveStartDate", SqlDbType.VarChar, 100);
            paramLeaveStartDate.Direction = ParameterDirection.Input;
            paramLeaveStartDate.Value = pLeaveStartDate;

            SqlParameter paramLeaveEndDate = new SqlParameter(@"pLeaveEndDate", SqlDbType.VarChar, 100);
            paramLeaveEndDate.Direction = ParameterDirection.Input;
            paramLeaveEndDate.Value = pLeaveEndDate;

            SqlParameter paramLeaveType = new SqlParameter(@"pLeaveType", SqlDbType.Int);
            paramLeaveType.Direction = ParameterDirection.Input;
            paramLeaveType.Value = pLeaveType;

            SqlParameter paramDesc = new SqlParameter(@"pDesc", SqlDbType.VarChar, 200);
            paramDesc.Direction = ParameterDirection.Input;
            paramDesc.Value = pDesc;

            SqlParameter paramCreateBy = new SqlParameter(@"pCreateBy", SqlDbType.Int);
            paramCreateBy.Direction = ParameterDirection.Input;
            paramCreateBy.Value = pCreateBy;

            sql.Parameters.Add(paramLeaveStartDate);
            sql.Parameters.Add(paramLeaveEndDate);
            sql.Parameters.Add(paramLeaveType);
            sql.Parameters.Add(paramDesc);
            sql.Parameters.Add(paramCreateBy);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["id"]);

            }
            return id;
        }

        public int ApproveLeave(int pID, int pApproveBy)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec update_approve_leave @pID, @pApproveBy");

            SqlParameter paramID = new SqlParameter(@"pID", SqlDbType.Int);
            paramID.Direction = ParameterDirection.Input;
            paramID.Value = pID;

            SqlParameter paramApproveBy = new SqlParameter(@"pApproveBy", SqlDbType.Int);
            paramApproveBy.Direction = ParameterDirection.Input;
            paramApproveBy.Value = pApproveBy;

            sql.Parameters.Add(paramID);
            sql.Parameters.Add(paramApproveBy);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["id"]);

            }
            return id;
        }

        public int RejectLeave(int pID, int pRejectBy)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec update_reject_leave @pID, @pRejectBy");

            SqlParameter paramID = new SqlParameter(@"pID", SqlDbType.Int);
            paramID.Direction = ParameterDirection.Input;
            paramID.Value = pID;

            SqlParameter paramRejectBy = new SqlParameter(@"pRejectBy", SqlDbType.Int);
            paramRejectBy.Direction = ParameterDirection.Input;
            paramRejectBy.Value = pRejectBy;

            sql.Parameters.Add(paramID);
            sql.Parameters.Add(paramRejectBy);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["id"]);

            }
            return id;
        }

        public int ChangePassword(int pID, string pOldPassword, string pNewPassword)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec edit_password @pUserID, @pOldPassword, @pNewPassword");

            SqlParameter paramID = new SqlParameter(@"pUserID", SqlDbType.Int);
            paramID.Direction = ParameterDirection.Input;
            paramID.Value = pID;

            SqlParameter paramOldPassword = new SqlParameter(@"pOldPassword", SqlDbType.VarChar, 255);
            paramOldPassword.Direction = ParameterDirection.Input;
            paramOldPassword.Value = pOldPassword;

            SqlParameter paramNewPassword = new SqlParameter(@"pNewPassword", SqlDbType.VarChar, 255);
            paramNewPassword.Direction = ParameterDirection.Input;
            paramNewPassword.Value = pNewPassword;

            sql.Parameters.Add(paramID);
            sql.Parameters.Add(paramOldPassword);
            sql.Parameters.Add(paramNewPassword);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["id"]);
            }
            return id;
        }

        public DataTable SearchCompany(string pTextSearch, int pPage, int pPerPage)
        {
            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_search_shareholder @pTextSearch, @pPage, @pPerPage");

            SqlParameter paramTextSearch = new SqlParameter(@"pTextSearch", SqlDbType.VarChar, 20);
            paramTextSearch.Direction = ParameterDirection.Input;
            paramTextSearch.Value = pTextSearch;

            SqlParameter paramPage = new SqlParameter(@"pPage", SqlDbType.Int);
            paramPage.Direction = ParameterDirection.Input;
            paramPage.Value = pPage;

            SqlParameter paramPerPage = new SqlParameter(@"pPerPage", SqlDbType.Int);
            paramPerPage.Direction = ParameterDirection.Input;
            paramPerPage.Value = pPerPage;

            sql.Parameters.Add(paramTextSearch);
            sql.Parameters.Add(paramPage);
            sql.Parameters.Add(paramPerPage);

            table = sql.executeQueryWithReturnTable();

            return table;
        }

        public int SearcCompanyPaging(string pTextSearch)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_total_search_shareholder @pTextSearch");

            SqlParameter paramTextSearch = new SqlParameter(@"pTextSearch", SqlDbType.VarChar, 20);
            paramTextSearch.Direction = ParameterDirection.Input;
            paramTextSearch.Value = pTextSearch;

            sql.Parameters.Add(paramTextSearch);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["total"].ToString());
            }

            return id;
        }

        public int SearcAgentPaging(string pTextSearch, int pShareHolderID, string pAllAgentID)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_total_search_agent @pTextSearch, @pShareHolderID, @pAllAgentID");

            SqlParameter paramTextSearch = new SqlParameter(@"pTextSearch", SqlDbType.VarChar, 20);
            paramTextSearch.Direction = ParameterDirection.Input;
            paramTextSearch.Value = pTextSearch;

            SqlParameter paramShareHolderID = new SqlParameter(@"pShareHolderID", SqlDbType.Int);
            paramShareHolderID.Direction = ParameterDirection.Input;
            paramShareHolderID.Value = pShareHolderID;


            SqlParameter paramAllAgentID = new SqlParameter(@"pAllAgentID", SqlDbType.VarChar, 8000);
            paramAllAgentID.Direction = ParameterDirection.Input;
            paramAllAgentID.Value = pAllAgentID;

            sql.Parameters.Add(paramTextSearch);
            sql.Parameters.Add(paramShareHolderID);
            sql.Parameters.Add(paramAllAgentID);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["total"].ToString());
            }

            return id;
        }

        public DataTable SearchAgent(string pTextSearch, int pShareHolderID, int pPage, int pPerPage, string pAllAgentID)
        {
            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_search_agent @pTextSearch, @pShareHolderID, @pPage, @pPerPage, @pAllAgentID");

            SqlParameter paramTextSearch = new SqlParameter(@"pTextSearch", SqlDbType.VarChar, 20);
            paramTextSearch.Direction = ParameterDirection.Input;
            paramTextSearch.Value = pTextSearch;

            SqlParameter paramShareHolderID = new SqlParameter(@"pShareHolderID", SqlDbType.Int);
            paramShareHolderID.Direction = ParameterDirection.Input;
            paramShareHolderID.Value = pShareHolderID;

            SqlParameter paramPage = new SqlParameter(@"pPage", SqlDbType.Int);
            paramPage.Direction = ParameterDirection.Input;
            paramPage.Value = pPage;

            SqlParameter paramPerPage = new SqlParameter(@"pPerPage", SqlDbType.Int);
            paramPerPage.Direction = ParameterDirection.Input;
            paramPerPage.Value = pPerPage;

            SqlParameter paramAllAgentID = new SqlParameter(@"pAllAgentID", SqlDbType.VarChar, 8000);
            paramAllAgentID.Direction = ParameterDirection.Input;
            paramAllAgentID.Value = pAllAgentID;

            sql.Parameters.Add(paramTextSearch);
            sql.Parameters.Add(paramShareHolderID);
            sql.Parameters.Add(paramPage);
            sql.Parameters.Add(paramPerPage);
            sql.Parameters.Add(paramAllAgentID);

            table = sql.executeQueryWithReturnTable();

            return table;
        }

        public DataTable SearchLineToken(string pTextSearch, int pPage, int pPerPage)
        {
            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_search_line_token @pTextSearch, @pPage, @pPerPage");

            SqlParameter paramTextSearch = new SqlParameter(@"pTextSearch", SqlDbType.VarChar, 100);
            paramTextSearch.Direction = ParameterDirection.Input;
            paramTextSearch.Value = pTextSearch;

            SqlParameter paramPage = new SqlParameter(@"pPage", SqlDbType.Int);
            paramPage.Direction = ParameterDirection.Input;
            paramPage.Value = pPage;

            SqlParameter paramPerPage = new SqlParameter(@"pPerPage", SqlDbType.Int);
            paramPerPage.Direction = ParameterDirection.Input;
            paramPerPage.Value = pPerPage;

            sql.Parameters.Add(paramTextSearch);
            sql.Parameters.Add(paramPage);
            sql.Parameters.Add(paramPerPage);

            table = sql.executeQueryWithReturnTable();

            return table;
        }

        public int AddLineToken(string pNameGroup, string pToken, int pCreateBy)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec insert_line_token @pNameGroup, @pToken, @pCreateBy");

            SqlParameter paramNameGroup = new SqlParameter(@"pNameGroup", SqlDbType.VarChar, 255);
            paramNameGroup.Direction = ParameterDirection.Input;
            paramNameGroup.Value = pNameGroup;

            SqlParameter paramToken = new SqlParameter(@"pToken", SqlDbType.VarChar, 100);
            paramToken.Direction = ParameterDirection.Input;
            paramToken.Value = pToken;

            SqlParameter paramCreateBy = new SqlParameter(@"pCreateBy", SqlDbType.Int);
            paramCreateBy.Direction = ParameterDirection.Input;
            paramCreateBy.Value = pCreateBy;

            sql.Parameters.Add(paramNameGroup);
            sql.Parameters.Add(paramToken);
            sql.Parameters.Add(paramCreateBy);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["id"]);

            }
            return id;
        }

        public int CheckLineToken(string pNameGroup, int pID)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec check_linetoken @pNameGroup, @pID");

            SqlParameter paramNameGroup = new SqlParameter(@"pNameGroup", SqlDbType.VarChar, 100);
            paramNameGroup.Direction = ParameterDirection.Input;
            paramNameGroup.Value = pNameGroup;

            SqlParameter paramID = new SqlParameter(@"pID", SqlDbType.Int);
            paramID.Direction = ParameterDirection.Input;
            paramID.Value = pID;

            sql.Parameters.Add(paramNameGroup);
            sql.Parameters.Add(paramID);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["count_id"]);

            }
            return id;
        }

        public int EditLineToken(int pID, string pNameGroup, string pToken, int pUpdateBy)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec update_linetoken @pID, @pNameGroup, @pToken, @pUpdateBy");

            SqlParameter paramID = new SqlParameter(@"pID", SqlDbType.Int);
            paramID.Direction = ParameterDirection.Input;
            paramID.Value = pID;

            SqlParameter paramNameGroup = new SqlParameter(@"pNameGroup", SqlDbType.VarChar, 255);
            paramNameGroup.Direction = ParameterDirection.Input;
            paramNameGroup.Value = pNameGroup;

            SqlParameter paramToken = new SqlParameter(@"pToken", SqlDbType.VarChar, 100);
            paramToken.Direction = ParameterDirection.Input;
            paramToken.Value = pToken;

            SqlParameter paramUpdateBy = new SqlParameter(@"pUpdateBy", SqlDbType.Int);
            paramUpdateBy.Direction = ParameterDirection.Input;
            paramUpdateBy.Value = pUpdateBy;

            sql.Parameters.Add(paramID);
            sql.Parameters.Add(paramNameGroup);
            sql.Parameters.Add(paramToken);
            sql.Parameters.Add(paramUpdateBy);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["id"]);

            }
            return id;
        }

        public int DeleteLineToken(int pID, int pCancelBy)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec cancel_linetoken @pID, @pCancelBy");

            SqlParameter paramID = new SqlParameter(@"pID", SqlDbType.Int);
            paramID.Direction = ParameterDirection.Input;
            paramID.Value = pID;

            SqlParameter paramCancelBy = new SqlParameter(@"pCancelBy", SqlDbType.Int);
            paramCancelBy.Direction = ParameterDirection.Input;
            paramCancelBy.Value = pCancelBy;

            sql.Parameters.Add(paramID);
            sql.Parameters.Add(paramCancelBy);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["id"]);

            }
            return id;
        }

        public int SearcLineTokenPaging(string pTextSearch)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_total_search_linetoken @pTextSearch");

            SqlParameter paramTextSearch = new SqlParameter(@"pTextSearch", SqlDbType.VarChar, 100);
            paramTextSearch.Direction = ParameterDirection.Input;
            paramTextSearch.Value = pTextSearch;

            sql.Parameters.Add(paramTextSearch);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["total"].ToString());
            }

            return id;
        }

        public DataTable getAllLineToken()
        {
            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_all_linetoken");

            table = sql.executeQueryWithReturnTable();

            //if (table != null && table.Rows.Count > 0)
            //{
            //    DataRow dr = table.Rows[0];
            //    id = Convert.ToInt32(dr["id"]);

            //}
            return table;
        }

        public string CheckGUIDLogin(int pUserID)
        {
            string id = "";

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec check_guid @pUserID");

            SqlParameter paramUserID = new SqlParameter(@"pUserID", SqlDbType.Int);
            paramUserID.Direction = ParameterDirection.Input;
            paramUserID.Value = pUserID;

            sql.Parameters.Add(paramUserID);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = dr["guid"].ToString();
            }

            return id.ToString();
        }

        public int AddGUIDLogin(int pUserID, string pGuID)
        {
            int id = 0;

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec insert_guid @pUserID, @pGuID");

            SqlParameter paramUserID = new SqlParameter(@"pUserID", SqlDbType.Int);
            paramUserID.Direction = ParameterDirection.Input;
            paramUserID.Value = pUserID;

            SqlParameter paramGuID = new SqlParameter(@"pGuID", SqlDbType.VarChar, 50);
            paramGuID.Direction = ParameterDirection.Input;
            paramGuID.Value = pGuID;

            sql.Parameters.Add(paramUserID);
            sql.Parameters.Add(paramGuID);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = Convert.ToInt32(dr["id"]);

            }
            return id;
        }

        public string UsedCodeGUID(int pUserID)
        {
            string id = "";

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec used_code_guid @pUserID");

            SqlParameter paramUserID = new SqlParameter(@"pUserID", SqlDbType.Int);
            paramUserID.Direction = ParameterDirection.Input;
            paramUserID.Value = pUserID;

            sql.Parameters.Add(paramUserID);

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                id = dr["id"].ToString();
            }

            return id.ToString();
        }

        public string GetSystemMaintenance()
        {
            string status = "";

            DataTable table = new DataTable();
            SQLCustomExecute sql = new SQLCustomExecute("exec get_system_maintenance");

            table = sql.executeQueryWithReturnTable();

            if (table != null && table.Rows.Count > 0)
            {
                DataRow dr = table.Rows[0];
                status = dr["is_maintenance"].ToString();
            }

            return status.ToString();
        }
    }

    public class SQLCustomExecute
    {
        public List<SqlParameter> Parameters { get; set; }
        public string sqlCommand { get; set; }


        public SQLCustomExecute(string sqlCommand)
        {
            this.sqlCommand = sqlCommand;
            this.Parameters = new List<SqlParameter>();
        }

        public DataTable executeQueryWithReturnTable()
        {
            //string SAMPLE_KEY = "gCjK+DZ/GCYbKIGiAt1qCA==";
            //string SAMPLE_IV = "47l5QsSe1POo31adQ/u7nQ==";

            Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo("en-US", false);
            DataTable result = null;

            //Aes aes = new Aes(SAMPLE_KEY, SAMPLE_IV);
            //string connectionString = aes.DecryptFromBase64String(WebConfigurationManager.AppSettings["connectionStrings"]);
            string connectionString = WebConfigurationManager.AppSettings["connectionStrings"];

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand();
                command.Connection = connection;
                command.CommandText = this.sqlCommand;

                if (this.Parameters != null)
                    foreach (SqlParameter parameter in this.Parameters)
                        command.Parameters.Add(parameter);

                try
                {
                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        result = new DataTable();
                        if (reader.HasRows)
                        {
                            result.Load(reader);
                        }
                    }
                }
                catch (Exception ex)
                {
                    result = null;
                }
                finally
                {
                    connection.Dispose();
                    connection.Close();
                }
            }

            return result;
        }
    }
}