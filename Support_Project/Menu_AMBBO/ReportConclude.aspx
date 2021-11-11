<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ReportConclude.aspx.cs" Inherits="Support_Project.Menu_AMBBO.ReportConclude" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .disabled-link {
            cursor: default;
            pointer-events: none;
            text-decoration: none;
            color: grey !important;
        }

        .linkCancel {
            color: #CFA137 !important;
            text-decoration: underline !important;
        }

        .linkClick {
            text-decoration: underline;
        }

        .overflowTable {
            margin: 0px !important;
            width: 10.5em;
            white-space: nowrap;
            overflow: hidden;
            font-size: 0.8rem;
        }

        .testDate {
            position: relative;
            color: white;
        }

            .testDate:before {
                position: absolute;
                content: attr(data-date);
                display: inline-block;
                color: black;
            }

            .testDate::-webkit-datetime-edit, .testDate::-webkit-inner-spin-button, .testDate::-webkit-clear-button {
                display: none;
            }

            .testDate::-webkit-calendar-picker-indicator {
                /*position: absolute;
                top: 9px;
                right: 10px;
                color: black;
                opacity: 1;*/
                background: transparent;
                bottom: 0;
                color: transparent;
                /*cursor: pointer;*/
                height: auto;
                left: 0;
                position: absolute;
                right: 0;
                top: 0;
                width: auto;
                z-index: 999;
            }

        .input-wrapper {
            position: relative;
        }

        .iconCalendar {
            position: absolute;
            top: 12px;
            left: 121px;
            z-index: 9;
        }

        .iconTime {
            position: absolute;
            top: 12px;
            left: 121px;
            z-index: 9;
        }
    </style>
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="" set-lan="text:Ambbo"></a></li>
            <li class="breadcrumb-item active txtMem" set-lan="text:Report Conclude"></li>
        </ol>
    </nav>
    <div class="row">
        <div class="col-md-8">
            <h1 set-lan="text:Report Conclude"></h1>
        </div>
    </div>
    <div class="btn-toolbar section-group" role="toolbar" style="padding-left: 2.5rem;">
        <div class="col-md-12 row" style="margin-left: 1rem;">
            <div class="row">
                <label for="email" class="col-form-label" set-lan="html:Prefix__"></label>
                <div style="padding-left: 1rem;">
                    <input type="text" class="form-control" id="searchPrefix" onkeyup="inputKeyUp(event)" />
                </div>
            </div>
            <div class="row" style="padding-left: 2.5rem;">
                <label for="email" class="col-form-label" set-lan="text:Username_"></label>
                <div style="padding-left: 1rem;">
                    <input type="text" class="form-control" id="searchUsername" onkeyup="inputKeyUp(event)" />
                </div>
            </div>
            <div class="row" style="padding-left: 2.5rem;">
                <label for="email" class="col-form-label alignright" set-lan="text:Type_"></label>
                <div style="padding-left: 1rem;" class="select-outline">
                    <select name="" id="ddlType" class="mdb-select" data-live-search="true" searchable="Search here.." onchange="GetDDLCate();">
                        <option value="" selected disabled set-lan="text:Select type"></option>
                        <option value="BALANCE" set-lan="text:Balance"></option>
                        <option value="USER" set-lan="text:User"></option>
                        <option value="PROMOTION" set-lan="text:Promotion"></option>
                        <option value="HIDE" set-lan="text:Hide"></option>
                    </select>
                </div>
            </div>
            <div class="row ddlCate" style="padding-left: 2.5rem; display: none;">
                <label for="email" class="col-form-label alignright" set-lan="text:Category_"></label>
                <div style="padding-left: 1rem;" class="select-outline">
                    <select name="" id="ddlCategory" class="mdb-select" data-live-search="true" searchable="Search here..">
                        <option value="" selected disabled set-lan="text:Select type"></option>
                        <option value="AUTO">Auto</option>
                        <option value="EXPAY">Expay</option>
                        <option value="MANUAL">Manual</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-md-12 row" style="margin-top: .5rem;">
            <div class="row fieldStart" style="margin-left: -4px;">
                <label for="email" class="col-form-label" set-lan="text:Start date_"></label>
                <div style="padding-left: 1rem;" class="input-wrapper">
                    <i class="fas fa-calendar-alt iconCalendar"></i>
                    <input type="date" data-date="" id="startdate" class="testDate form-control" data-date-format="DD-MM-YYYY" style="width: 130px;" />
                </div>
            </div>
            <div class="row" style="padding-left: 2rem;">
                <label for="email" class="col-form-label" set-lan="text:To date_"></label>
                <div style="padding-left: 1rem;" class="input-wrapper">
                    <i class="fas fa-calendar-alt iconCalendar"></i>
                    <input type="date" data-date="" id="todate" class="testDate form-control" data-date-format="DD-MM-YYYY" style="width: 130px;" />
                </div>
            </div>
            <div class="row" style="padding-left: 2.5rem;">
                <button class="btn btn-yellow font-weight-bold m-0 px-3 py-2 z-depth-0 waves-effect btnMenu" type="button" onclick="Search_Click()" set-lan="text:Search"></button>
            </div>
        </div>
    </div>
    <div id="zonePlsSearch" class="btn-toolbar section-group" role="toolbar" style="margin-top: 1rem; padding-top: 2rem; font-weight: bold; background-color: #dee2e6;">
        <p class="col-12" style="text-align: center; color: #333;" set-lan="text:Please enter search."></p>
    </div>
    <div class="table-wrapper" style="margin-top: 1rem; margin-bottom: 1rem;">
        <div class="row btnPrevious" style="margin-top: 1rem; margin-bottom: 1rem; display: none;">
            <div class="col-12">
                <div class="btn-group mr-auto">
                    <div class="btn-group btn-group-green mr-3" data-toggle="buttons">
                        <label class="btn btn-white border border-success z-depth-0 form-check-label" onclick="btnTimePN('Previous');">
                            <input class="form-check-input" type="radio" name="options" id="option1" autocomplete="off" checked>
                            <span set-lan="text:Previous"></span>
                        </label>
                        <label class="btn btn-white border border-success z-depth-0 form-check-label active" onclick="btnTime('Today');">
                            <input class="form-check-input" type="radio" name="options" id="option2" autocomplete="off" checked>
                            <span set-lan="text:Today"></span>
                        </label>
                        <label class="btn btn-white border border-success z-depth-0 form-check-label" onclick="btnTime('Yesterday');">
                            <input class="form-check-input" type="radio" name="options" id="option3" autocomplete="off">
                            <span set-lan="text:Yesterday"></span>
                        </label>
                        <label class="btn btn-white border border-success z-depth-0 form-check-label" onclick="btnTime('This week');">
                            <input class="form-check-input" type="radio" name="options" id="option4" autocomplete="off">
                            <span set-lan="text:This week"></span>
                        </label>
                        <label class="btn btn-white border border-success z-depth-0 form-check-label" onclick="btnTime('Last week');">
                            <input class="form-check-input" type="radio" name="options" id="option5" autocomplete="off">
                            <span set-lan="text:Last week"></span>
                        </label>
                        <label class="btn btn-white border border-success z-depth-0 form-check-label" onclick="btnTime('This month');">
                            <input class="form-check-input" type="radio" name="options" id="option6" autocomplete="off">
                            <span set-lan="text:This month"></span>
                        </label>
                        <label class="btn btn-white border border-success z-depth-0 form-check-label" onclick="btnTime('Last month');">
                            <input class="form-check-input" type="radio" name="options" id="option7" autocomplete="off">
                            <span set-lan="text:Last month"></span>
                        </label>
                        <label class="btn btn-white border border-success z-depth-0 form-check-label" onclick="btnTimePN('Next');">
                            <input class="form-check-input" type="radio" name="options" id="option8" autocomplete="off" checked>
                            <span set-lan="text:Next"></span>
                        </label>
                    </div>
                </div>
            </div>
        </div>
        <table class="table table-border" id="tbDataPromotion" style="display: none;">
            <thead class="rgba-green-slight">
                <tr>
                    <th style="width: 10%;">No</th>
                    <th style="width: 50%; text-align: left; padding-left: 5px;" set-lan="text:Promotion Name"></th>
                    <th style="width: 20%; text-align: right; padding-right: 5px;" set-lan="text:Count"></th>
                    <th style="width: 20%; text-align: right; padding-right: 5px;" set-lan="text:Total"></th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td colspan="4" style="text-align: center;" set-lan="text:No Data."></td>
                </tr>
            </tbody>
            <tfoot class="rgba-yellow-slight">
                <tr class="total">
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
            </tfoot>
        </table>
        <table class="table table-border" id="tbDataUser" style="display: none;">
            <thead class="rgba-green-slight">
                <tr>
                    <th style="width: 5%;" set-lan="text:No"></th>
                    <th style="width: 10%; text-align: left; padding-left: 5px;" set-lan="text:Username"></th>
                    <th style="width: 10%; text-align: right; padding-right: 5px;" set-lan="text:Count Deposit"></th>
                    <th style="width: 10%; text-align: right; padding-right: 5px;" set-lan="text:Sum Deposit"></th>
                    <th style="width: 10%; text-align: right; padding-right: 5px;" set-lan="text:Count Withdraw"></th>
                    <th style="width: 10%; text-align: right; padding-right: 5px;" set-lan="text:Sum Withdraw"></th>
                    <th style="width: 10%; text-align: right; padding-right: 5px;" set-lan="text:Sum Read Withdraw"></th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td colspan="7" style="text-align: center;" set-lan="text:No Data."></td>
                </tr>
            </tbody>
            <tfoot class="rgba-yellow-slight">
                <tr class="total">
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
            </tfoot>
        </table>
        <table class="table table-border" id="tbDataBalance" style="display: none;">
            <thead class="rgba-green-slight">
                <tr>
                    <th style="width: 5%;">No</th>
                    <th style="width: 10%; text-align: right; padding-right: 5px;" set-lan="text:Topup"></th>
                    <th style="width: 10%; text-align: right; padding-right: 5px;" set-lan="text:Bonus"></th>
                    <th style="width: 15%; text-align: right; padding-right: 5px;" set-lan="text:Topup + Bonus"></th>
                    <th style="width: 10%; text-align: right; padding-right: 5px;" set-lan="text:Withdraw"></th>
                    <th style="width: 10%; text-align: right; padding-right: 5px;" set-lan="text:Company"></th>
                    <th style="width: 10%; text-align: right; padding-right: 5px;" set-lan="text:Profit Lost"></th>
                    <th style="width: 15%; text-align: right; padding-right: 5px;" set-lan="text:Profit Lost + Company"></th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td colspan="8" style="text-align: center;" set-lan="text:No Data."></td>
                </tr>
            </tbody>
            <tfoot class="rgba-yellow-slight">
                <tr class="total">
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
            </tfoot>
        </table>
        <table class="table table-border" id="tbDataHide" style="display: none;">
            <thead class="rgba-green-slight">
                <tr>
                    <th style="width: 5%;" set-lan="text:No"></th>
                    <th style="width: 10%;" set-lan="text:Bank Name"></th>
                    <th style="width: 10%;" set-lan="text:Channel Transfer"></th>
                    <th style="width: 13%;" set-lan="text:Detail"></th>
                    <th style="width: 10%; text-align: right; padding-right: 5px;" set-lan="text:Amount"></th>
                    <th style="width: 12%;" set-lan="text:Create date"></th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td colspan="6" style="text-align: center;" set-lan="text:No Data."></td>
                </tr>
            </tbody>
            <tfoot class="rgba-yellow-slight">
                <tr class="total">
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
            </tfoot>
        </table>
    </div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Button ID="btnTest" class="btn btn-lg btn-yellow font-weight-bold btn-block" OnClick="Test_click" runat="server" Text="Add" Style="display: none;" />
        </ContentTemplate>
    </asp:UpdatePanel>
    <!-- Modal -->
    <div class="modal fade" id="modalAlert" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-3 text-center">
                    <label id="lbAlert"></label>
                </div>
                <div class="modal-footer d-flex justify-content-center">
                    <button type="button" class="btn btn-yellow font-weight-bold" data-dismiss="modal" aria-label="Close" set-lan="text:Close"></button>
                </div>
            </div>
        </div>
    </div>
    <asp:HiddenField ID="IDRole" runat="Server"></asp:HiddenField>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainScript" runat="server">
    <script src="../js/moment.min.js"></script>
    <script src="../js/pagination.js"></script>
    <script>
        var typeTime = "Day";
        $(document).ready(function () {
            $("#menuAmbbo , #menuAmbbo > a , #menuAmbboReportConclude > a").addClass("active");
            $("#menuAmbbo > div").css("display", "block");

            var date = new Date();
            var dateSet = date.getFullYear() + "-" + ("0" + (date.getMonth() + 1)).slice(-2) + "-" + ("0" + date.getDate()).slice(-2);
            $("#startdate").val(dateSet);
            $("#todate").val(dateSet);

            $("input[type=date]").on("change", function () {
                this.setAttribute(
                    "data-date",
                    moment(this.value, "YYYY-MM-DD")
                    .format(this.getAttribute("data-date-format"))
                )
            }).trigger("change")
        });

        function GetDDLCate() {
            if ($("#ddlType").val() == "HIDE") {
                $(".ddlCate").css("display", "inline-flex");
            }
            else {
                $(".ddlCate").css("display", "none");
            }
            $('#ddlCategory').prop("selectedIndex", 0);
        }

        function btnTime(type) {
            var start = "";
            var end = "";
            var date = new Date();

            if (type == "Today") {
                date = date.getFullYear() + "-" + ("0" + (date.getMonth() + 1)).slice(-2) + "-" + ("0" + date.getDate()).slice(-2);
                $("#startdate").val(date);
                $("#todate").val(date);
                start = date;
                end = date;
                typeTime = "Day";
            }
            else if (type == "Yesterday") {
                var todayTimeStamp = +new Date;
                var oneDayTimeStamp = 1000 * 60 * 60 * 24;
                var diff = todayTimeStamp - oneDayTimeStamp;
                var yesterdayDate = new Date(diff);
                var yesterdayString = yesterdayDate.getFullYear() + "-" + ("0" + (yesterdayDate.getMonth() + 1)).slice(-2) + "-" + ("0" + yesterdayDate.getDate()).slice(-2);
                $("#startdate").val(yesterdayString);
                $("#todate").val(yesterdayString);
                start = yesterdayString;
                end = yesterdayString;
                typeTime = "Day";
            }
            else if (type == "This week") {
                var firstday = date.getDate() - date.getDay();
                var lastday = firstday + 6;
                var date1 = new Date(date.setDate(firstday));
                var date2 = new Date(date.setDate(lastday));
                var startDate = date1.getFullYear() + "-" + ("0" + (date1.getMonth() + 1)).slice(-2) + "-" + ("0" + date1.getDate()).slice(-2);
                var endDate = date2.getFullYear() + "-" + ("0" + (date2.getMonth() + 1)).slice(-2) + "-" + ("0" + date2.getDate()).slice(-2);
                $("#startdate").val(startDate);
                $("#todate").val(endDate);
                start = startDate;
                end = endDate;
                typeTime = "Week";
            }
            else if (type == "Last week") {
                var firstday = (date.getDate() - date.getDay()) - 7;
                var lastday = firstday + 6;
                var date1 = new Date(date.setDate(firstday));
                var date2 = new Date(date.setDate(lastday));
                var startDate = date1.getFullYear() + "-" + ("0" + (date1.getMonth() + 1)).slice(-2) + "-" + ("0" + date1.getDate()).slice(-2);
                var endDate = date2.getFullYear() + "-" + ("0" + (date2.getMonth() + 1)).slice(-2) + "-" + ("0" + date2.getDate()).slice(-2);
                $("#startdate").val(startDate);
                $("#todate").val(endDate);
                start = startDate;
                end = endDate;
                typeTime = "Week";
            }
            else if (type == "This month") {
                var date1 = new Date(date.getFullYear(), date.getMonth(), 1);
                var date2 = new Date(date.getFullYear(), date.getMonth() + 1, 0);
                var startDate = date1.getFullYear() + "-" + ("0" + (date1.getMonth() + 1)).slice(-2) + "-" + ("0" + date1.getDate()).slice(-2);
                var endDate = date2.getFullYear() + "-" + ("0" + (date2.getMonth() + 1)).slice(-2) + "-" + ("0" + date2.getDate()).slice(-2);;
                $("#startdate").val(startDate);
                $("#todate").val(endDate);
                start = startDate;
                end = endDate;
                typeTime = "Month";
            }
            else if (type == "Last month") {
                var date1 = new Date(date.getFullYear(), date.getMonth() - 1, 1);
                var date2 = new Date(date.getFullYear(), date.getMonth(), 0);
                var startDate = date1.getFullYear() + "-" + ("0" + (date1.getMonth() + 1)).slice(-2) + "-" + ("0" + date1.getDate()).slice(-2);
                var endDate = date2.getFullYear() + "-" + ("0" + (date2.getMonth() + 1)).slice(-2) + "-" + ("0" + date2.getDate()).slice(-2);
                $("#startdate").val(startDate);
                $("#todate").val(endDate);
                start = startDate;
                end = endDate;
                typeTime = "Month";
            }

            $("input[type=date]").on("change", function () {
                this.setAttribute(
                    "data-date",
                    moment(this.value, "YYYY-MM-DD")
                    .format(this.getAttribute("data-date-format"))
                )
            }).trigger("change")

            Search_Click(start, end);
        }

        function btnTimePN(type) {
            var startVal = new Date($('#startdate').val());
            var toVal = new Date($('#todate').val());
            var start = "";
            var end = "";

            if (typeTime == "Day") {
                if (type == "Previous") {
                    var todayTimeStamp = startVal;
                    var oneDayTimeStamp = 1000 * 60 * 60 * 24;
                    var diff = todayTimeStamp - oneDayTimeStamp;
                    var yesterdayDate = new Date(diff);
                    var yesterdayString = yesterdayDate.getFullYear() + "-" + ("0" + (yesterdayDate.getMonth() + 1)).slice(-2) + "-" + ("0" + yesterdayDate.getDate()).slice(-2);
                    $("#startdate").val(yesterdayString);
                    $("#todate").val(yesterdayString);
                    start = yesterdayString;
                    end = yesterdayString;
                }
                else if (type == "Next") {
                    var Val = new Date(startVal.setDate(startVal.getDate() + 1));
                    var tomorrowString = Val.getFullYear() + "-" + ("0" + (Val.getMonth() + 1)).slice(-2) + "-" + ("0" + Val.getDate()).slice(-2);
                    $("#startdate").val(tomorrowString);
                    $("#todate").val(tomorrowString);
                    start = tomorrowString;
                    end = tomorrowString;
                }
            }
            else if (typeTime == "Week") {
                if (type == "Previous") {
                    var firstday = (startVal.getDate() - startVal.getDay()) - 7;
                    var lastday = firstday + 6;
                    var date1 = new Date(startVal.setDate(firstday));
                    var date2 = new Date(startVal.setDate(lastday));
                    var startDate = date1.getFullYear() + "-" + ("0" + (date1.getMonth() + 1)).slice(-2) + "-" + ("0" + date1.getDate()).slice(-2);
                    var endDate;
                    if (date1.getDate() > date2.getDate()) {
                        endDate = date2.getFullYear() + "-" + ("0" + (date2.getMonth() + 2)).slice(-2) + "-" + ("0" + date2.getDate()).slice(-2);
                    }
                    else {
                        endDate = date2.getFullYear() + "-" + ("0" + (date2.getMonth() + 1)).slice(-2) + "-" + ("0" + date2.getDate()).slice(-2);
                    }
                    $("#startdate").val(startDate);
                    $("#todate").val(endDate);
                    start = startDate;
                    end = endDate;
                }
                else if (type == "Next") {
                    var firstday = (startVal.getDate() - startVal.getDay()) + 7;
                    var date1 = new Date(startVal.setDate(firstday));
                    var startDate = date1.getFullYear() + "-" + ("0" + (date1.getMonth() + 1)).slice(-2) + "-" + ("0" + date1.getDate()).slice(-2);
                    var date2 = new Date(date1.setTime(date1.getTime() + (6 * 24 * 60 * 60 * 1000)));
                    var endDate = date2.getFullYear() + "-" + ("0" + (date2.getMonth() + 1)).slice(-2) + "-" + ("0" + date2.getDate()).slice(-2);
                    $("#startdate").val(startDate);
                    $("#todate").val(endDate);
                    start = startDate;
                    end = endDate;
                }
            }
            else if (typeTime == "Month") {
                if (type == "Previous") {
                    var current = new Date(startVal.getFullYear(), startVal.getMonth() - 1, 1);
                    var tomorrowString = current.getFullYear() + "-" + ("0" + (current.getMonth() + 1)).slice(-2) + "-" + ("0" + current.getDate()).slice(-2);
                    $("#startdate").val(tomorrowString);
                    var current2 = new Date(startVal.getFullYear(), startVal.getMonth(), 0);
                    var tomorrowString2 = current2.getFullYear() + "-" + ("0" + (current2.getMonth() + 1)).slice(-2) + "-" + ("0" + current2.getDate()).slice(-2);
                    $("#todate").val(tomorrowString2);
                    start = tomorrowString;
                    end = tomorrowString2;
                }
                else if (type == "Next") {
                    var current = new Date(startVal.getFullYear(), startVal.getMonth() + 1, 1);
                    var tomorrowString = current.getFullYear() + "-" + ("0" + (current.getMonth() + 1)).slice(-2) + "-" + ("0" + current.getDate()).slice(-2);
                    $("#startdate").val(tomorrowString);
                    var current2 = new Date(startVal.getFullYear(), startVal.getMonth() + 2, 0);
                    var tomorrowString2 = current2.getFullYear() + "-" + ("0" + (current2.getMonth() + 1)).slice(-2) + "-" + ("0" + current2.getDate()).slice(-2);
                    $("#todate").val(tomorrowString2);
                    start = tomorrowString;
                    end = tomorrowString2;
                }
            }

            $("input[type=date]").on("change", function () {
                this.setAttribute(
                    "data-date",
                    moment(this.value, "YYYY-MM-DD")
                    .format(this.getAttribute("data-date-format"))
                )
            }).trigger("change")

            Search_Click(start, end);
        }

        function inputKeyUp(e) {
            e.which = e.which || e.keyCode;
            if (e.which == 13) {
                Search_Click('', '');
            }
        }

        function Search_Click(start, end) {
            $("#myModalLoad").modal();

            var dateOne = "";
            var dateTwo = "";

            if (start == "" && end == "") {
                dateOne = $("#startdate").val();
                dateTwo = $("#todate").val();
            }
            else {
                dateOne = start;
                dateTwo = end;
            }

            var date1 = Date.parse(dateOne);
            var date2 = Date.parse(dateTwo);
            if (date1 > date2) {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:Field 'To Date' should be greater than 'Start Date'.");
                SetLan(localStorage.getItem("Language"));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else if ($("#searchPrefix").val() == "" || $("#searchPrefix").val() == null) {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:missing 'Prefix' field");
                SetLan(localStorage.getItem("Language"));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else if ($("#ddlType").val() == "" || $("#ddlType").val() == null) {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:missing 'Type' field");
                SetLan(localStorage.getItem("Language"));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else if ($("#ddlType").val() == "HIDE") {
                if ($("#ddlCategory").val() == "" || $("#ddlCategory").val() == null) {
                    document.getElementById("lbAlert").setAttribute("set-lan", "text:missing 'Category' field");
                    SetLan(localStorage.getItem("Language"));
                    $('#modalAlert').modal('show');
                    $("#myModalLoad").modal('hide');
                }
                else {
                    $("#zonePlsSearch").css("display", "none");
                    GetData();
                }
            }
            else {
                $("#zonePlsSearch").css("display", "none");
                GetData();
            }
        }

        function GetData() {
            $("#tbDataPromotion > tbody, #tbDataPromotion > tfoot").html("");
            $("#tbDataUser > tbody, #tbDataUser > tfoot").html("");
            $("#tbDataBalance > tbody, #tbDataBalance > tfoot").html("");
            $("#tbDataHide > tbody, #tbDataHide > tfoot").html("");
            $("#tbDataPromotion, #tbDataUser, #tbDataBalance, #tbDataHide, .btnPrevious").css("display", "none");
            var dataAdd = new Object();
            dataAdd.prefix = $("#searchPrefix").val();
            if ($("#ddlType").val() == "HIDE") {
                dataAdd.startDate = $("#startdate").val() + "T00:00:00.000Z";
                dataAdd.endDate = $("#todate").val() + "T23:59:00.000Z";
            }
            else {
                dataAdd.startDate = $("#startdate").val();
                dataAdd.endDate = $("#todate").val();
            }
            dataAdd.type = $("#ddlType").val();
            if ($("#ddlType").val() == "HIDE") {
                dataAdd.category = $("#ddlCategory").val();
            }
            else {
                dataAdd.category = "";
            }
            dataAdd.username = $("#searchUsername").val();
            $.ajax({
                url: "https://ambbo-test-support.prettygaming.asia/external/support/report-conclude",
                type: 'POST',
                dataType: 'json',
                data: JSON.stringify(dataAdd),
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    if (data.code == 0 || data.code == null) {
                        var dataTotal = data.result.list;
                        var htmlData = "";
                        var htmlFooter = "";
                        var no = 1;

                        if ($("#ddlType").val() == "PROMOTION") {
                            if (data.result != "") {
                                if (dataTotal.length > 0) {
                                    for (var i = 0; i < dataTotal.length; i++) {
                                        var obj = dataTotal[i];
                                        htmlData += "<tr>";
                                        htmlData += "<td style='text-align: center;'>" + no + "</td>";
                                        htmlData += "<td>" + obj.promotionName + "</td>";

                                        htmlData += "<td style='text-align: right;'>" + obj.count.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";

                                        var total = parseFloat(obj.total).toFixed(2);

                                        if (total < 0 || total.toString() == "-0.00") {
                                            htmlData += "<td style='text-align: right; color: red;'>" + total.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                        }
                                        else {
                                            htmlData += "<td style='text-align: right;'>" + total.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                        }
                                        htmlData += "</tr>";
                                        no++;
                                    }

                                    htmlFooter += "<tr><td></td><td></td><td style='text-align: right; padding-right: 1px;'><b>Total :</b></td>";

                                    var Counttotal = parseFloat(data.result.summary).toFixed(2);

                                    if (Counttotal < 0 || Counttotal.toString() == "-0.00") {
                                        htmlFooter += "<td style='color: red;'>" + Counttotal.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                    }
                                    else {
                                        htmlFooter += "<td>" + Counttotal.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                    }

                                    htmlFooter += "</tr>";
                                }
                                else {
                                    htmlData += "<tr><td colspan='4' style='text-align: center;' set-lan='text:No Data.'></td></tr>";
                                    htmlFooter += "<tr class='total'><td></td><td></td><td></td><td></td></tr>";
                                }
                            }
                            else {
                                htmlData += "<tr><td colspan='4' style='text-align: center;' set-lan='text:No Data.'></td></tr>";
                                htmlFooter += "<tr class='total'><td></td><td></td><td></td><td></td></tr>";
                            }

                            $("#tbDataPromotion > tbody").append(htmlData);
                            $("#tbDataPromotion > tfoot").append(htmlFooter);
                            $("#tbDataPromotion").css("display", "inline-table");
                            $(".btnPrevious").css("display", "flex");
                        }
                        else if ($("#ddlType").val() == "USER") {
                            if (data.result != "") {
                                if (dataTotal.length > 0) {
                                    for (var i = 0; i < dataTotal.length; i++) {
                                        var obj = dataTotal[i];
                                        htmlData += "<tr>";
                                        htmlData += "<td style='text-align: center;'>" + no + "</td>";
                                        htmlData += "<td>" + obj.username + "</td>";

                                        var countDeposit = parseFloat(obj.countDeposit).toFixed(2);
                                        var sumDeposit = parseFloat(obj.sumDeposit).toFixed(2);
                                        var countWithdraw = parseFloat(obj.countWithdraw).toFixed(2);
                                        var sumWithdraw = parseFloat(obj.sumWithdraw).toFixed(2);
                                        var sumReadWithdraw = parseFloat(obj.sumReadWithdraw).toFixed(2);

                                        if (countDeposit < 0 || countDeposit.toString() == "-0.00") {
                                            htmlData += "<td style='text-align: right; color: red;'>" + countDeposit.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                        }
                                        else {
                                            htmlData += "<td style='text-align: right;'>" + countDeposit.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                        }

                                        if (sumDeposit < 0 || sumDeposit.toString() == "-0.00") {
                                            htmlData += "<td style='text-align: right; color: red;'>" + sumDeposit.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                        }
                                        else {
                                            htmlData += "<td style='text-align: right;'>" + sumDeposit.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                        }

                                        if (countWithdraw < 0 || countWithdraw.toString() == "-0.00") {
                                            htmlData += "<td style='text-align: right; color: red;'>" + countWithdraw.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                        }
                                        else {
                                            htmlData += "<td style='text-align: right;'>" + countWithdraw.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                        }

                                        if (sumWithdraw < 0 || sumWithdraw.toString() == "-0.00") {
                                            htmlData += "<td style='text-align: right; color: red;'>" + sumWithdraw.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                        }
                                        else {
                                            htmlData += "<td style='text-align: right;'>" + sumWithdraw.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                        }

                                        if (sumReadWithdraw < 0 || sumReadWithdraw.toString() == "-0.00") {
                                            htmlData += "<td style='text-align: right; color: red;'>" + sumReadWithdraw.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                        }
                                        else {
                                            htmlData += "<td style='text-align: right;'>" + sumReadWithdraw.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                        }

                                        htmlData += "</tr>";
                                        no++;
                                    }

                                    htmlFooter += "<tr><td></td><td style='text-align: right; padding-right: 1px;'><b>Total :</b></td>";

                                    var totalCountDeposit = parseFloat(data.result.totalCountDeposit).toFixed(2);
                                    var totalCountWithdraw = parseFloat(data.result.totalCountWithdraw).toFixed(2);
                                    var totalReadWithdraw = parseFloat(data.result.totalReadWithdraw).toFixed(2);
                                    var totalSumDeposit = parseFloat(data.result.totalSumDeposit).toFixed(2);
                                    var totalSumWithdraw = parseFloat(data.result.totalSumWithdraw).toFixed(2);

                                    if (totalCountDeposit < 0 || totalCountDeposit.toString() == "-0.00") {
                                        htmlFooter += "<td style='color: red;'>" + totalCountDeposit.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                    }
                                    else {
                                        htmlFooter += "<td>" + totalCountDeposit.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                    }

                                    if (totalSumDeposit < 0 || totalSumDeposit.toString() == "-0.00") {
                                        htmlFooter += "<td style='color: red;'>" + totalSumDeposit.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                    }
                                    else {
                                        htmlFooter += "<td>" + totalSumDeposit.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                    }

                                    if (totalCountWithdraw < 0 || totalCountWithdraw.toString() == "-0.00") {
                                        htmlFooter += "<td style='color: red;'>" + totalCountWithdraw.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                    }
                                    else {
                                        htmlFooter += "<td>" + totalCountWithdraw.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                    }

                                    if (totalSumWithdraw < 0 || totalSumWithdraw.toString() == "-0.00") {
                                        htmlFooter += "<td style='color: red;'>" + totalSumWithdraw.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                    }
                                    else {
                                        htmlFooter += "<td>" + totalSumWithdraw.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                    }

                                    if (totalReadWithdraw < 0 || totalReadWithdraw.toString() == "-0.00") {
                                        htmlFooter += "<td style='color: red;'>" + totalReadWithdraw.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                    }
                                    else {
                                        htmlFooter += "<td>" + totalReadWithdraw.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                    }

                                    htmlFooter += "</tr>";
                                }
                                else {
                                    htmlData += "<tr><td colspan='7' style='text-align: center;' set-lan='text:No Data.'></td></tr>";
                                    htmlFooter += "<tr class='total'><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>";
                                }
                            }
                            else {
                                htmlData += "<tr><td colspan='7' style='text-align: center;' set-lan='text:No Data.'></td></tr>";
                                htmlFooter += "<tr class='total'><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>";
                            }

                            $("#tbDataUser > tbody").append(htmlData);
                            $("#tbDataUser > tfoot").append(htmlFooter);
                            $("#tbDataUser").css("display", "inline-table");
                            $(".btnPrevious").css("display", "flex");
                        }
                        else if ($("#ddlType").val() == "BALANCE") {
                            if (data.result != "") {
                                var obj = data.result;
                                htmlData += "<tr>";
                                htmlData += "<td style='text-align: center;'>" + no + "</td>";

                                var totalTopup = parseFloat(obj.totalTopup).toFixed(2);
                                var totalBonus = parseFloat(obj.totalBonus).toFixed(2);
                                var totalTB = parseFloat(obj.totalTB).toFixed(2);
                                var totalWithdraw = parseFloat(obj.totalWithdraw).toFixed(2);
                                var company = parseFloat(obj.company).toFixed(2);
                                var profitLostNet = parseFloat(obj.profitLostNet).toFixed(2);
                                var profitLostNoNet = parseFloat(obj.profitLostNoNet).toFixed(2);

                                if (totalTopup < 0 || totalTopup.toString() == "-0.00") {
                                    htmlData += "<td style='text-align: right; color: red;'>" + totalTopup.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                }
                                else {
                                    htmlData += "<td style='text-align: right;'>" + totalTopup.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                }

                                if (totalBonus < 0 || totalBonus.toString() == "-0.00") {
                                    htmlData += "<td style='text-align: right; color: red;'>" + totalBonus.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                }
                                else {
                                    htmlData += "<td style='text-align: right;'>" + totalBonus.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                }

                                if (totalTB < 0 || totalTB.toString() == "-0.00") {
                                    htmlData += "<td style='text-align: right; color: red;'>" + totalTB.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                }
                                else {
                                    htmlData += "<td style='text-align: right;'>" + totalTB.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                }

                                if (totalWithdraw < 0 || totalWithdraw.toString() == "-0.00") {
                                    htmlData += "<td style='text-align: right; color: red;'>" + totalWithdraw.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                }
                                else {
                                    htmlData += "<td style='text-align: right;'>" + totalWithdraw.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                }

                                if (company < 0 || company.toString() == "-0.00") {
                                    htmlData += "<td style='text-align: right; color: red;'>" + company.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                }
                                else {
                                    htmlData += "<td style='text-align: right;'>" + company.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                }

                                if (profitLostNet < 0 || profitLostNet.toString() == "-0.00") {
                                    htmlData += "<td style='text-align: right; color: red;'>" + profitLostNet.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                }
                                else {
                                    htmlData += "<td style='text-align: right;'>" + profitLostNet.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                }

                                if (profitLostNoNet < 0 || profitLostNoNet.toString() == "-0.00") {
                                    htmlData += "<td style='text-align: right; color: red;'>" + profitLostNoNet.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                }
                                else {
                                    htmlData += "<td style='text-align: right;'>" + profitLostNoNet.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                }

                                htmlData += "</tr>";
                                no++;

                                htmlFooter += "<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>";
                            }
                            else {
                                htmlData += "<tr><td colspan='8' style='text-align: center;' set-lan='text:No Data.'></td></tr>";
                                htmlFooter += "<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>";
                            }

                            $("#tbDataBalance > tbody").append(htmlData);
                            $("#tbDataBalance > tfoot").append(htmlFooter);
                            $("#tbDataBalance").css("display", "inline-table");
                            $(".btnPrevious").css("display", "flex");
                        }
                        else if ($("#ddlType").val() == "HIDE") {
                            if (data.result != "") {
                                var dataTotals = data.result;
                                if (dataTotals.length > 0) {
                                    for (var i = 0; i < dataTotals.length; i++) {
                                        var obj = dataTotals[i];
                                        htmlData += "<tr>";
                                        htmlData += "<td style='text-align: center;'>" + no + "</td>";
                                        htmlData += "<td style='text-align: center;'>" + obj.bankName + "</td>";
                                        htmlData += "<td style='text-align: center;'>" + obj.channelTransfer + "</td>";
                                        htmlData += "<td>" + obj.detail + "</td>";

                                        var value = parseFloat(obj.value).toFixed(2);
                                        if (value < 0 || value.toString() == "-0.00") {
                                            htmlData += "<td style='text-align: right; color: red;'>" + value.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                        }
                                        else {
                                            htmlData += "<td style='text-align: right;'>" + value.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                        }

                                        var createDate = new Date(obj.createDate);
                                        var txtcreateDate = ("0" + createDate.getDate()).slice(-2) + "-" + ("0" + (createDate.getMonth() + 1)).slice(-2) + "-" + ("0" + createDate.getFullYear()).slice(-2) + " " + ("0" + createDate.getHours()).slice(-2) + ":" + ("0" + createDate.getMinutes()).slice(-2) + ":" + ("0" + createDate.getSeconds()).slice(-2);
                                        htmlData += "<td style='text-align: center;'>" + txtcreateDate + "</td>";
                                        htmlData += "</tr>";
                                        no++;
                                    }

                                    htmlFooter += "<tr><td></td><td></td><td></td><td></td><td></td><td></td></tr>";
                                }
                                else {
                                    htmlData += "<tr><td colspan='6' style='text-align: center;' set-lan='text:No Data.'></td></tr>";
                                    htmlFooter += "<tr class='total'><td></td><td></td><td></td><td></td><td></td><td></td></tr>";
                                }
                            }
                            else {
                                htmlData += "<tr><td colspan='6' style='text-align: center;' set-lan='text:No Data.'></td></tr>";
                                htmlFooter += "<tr class='total'><td></td><td></td><td></td><td></td><td></td><td></td></tr>";
                            }

                            $("#tbDataHide > tbody").append(htmlData);
                            $("#tbDataHide > tfoot").append(htmlFooter);
                            $("#tbDataHide").css("display", "inline-table");
                            $(".btnPrevious").css("display", "flex");
                        }

                        SetLan(localStorage.getItem("Language"));
                        $("#myModalLoad").modal('hide');
                    }
                    else {
                        $("#zonePlsSearch").css("display", "block");
                        document.getElementById('lbAlert').innerHTML = data.message;
                        $("#myModalLoad").modal('hide');
                        $('#modalAlert').modal('show');
                    }
                },
                error: function (xhr, exception) {
                    var msg = '';
                    if (xhr.status === 0) {
                        msg = 'Not connect. Verify Network.';
                    } else if (xhr.status == 404) {
                        msg = 'Requested page not found. [404]';
                    } else if (xhr.status == 500) {
                        msg = 'Internal Server Error [500].';
                    } else if (exception === 'parsererror') {
                        msg = 'Requested JSON parse failed.';
                    } else if (exception === 'timeout') {
                        msg = 'Time out error.';
                    } else if (exception === 'abort') {
                        msg = 'Ajax request aborted.';
                    } else {
                        msg = 'Uncaught Error.\n' + xhr.responseText;
                    }
                    document.getElementById('lbAlert').innerHTML = msg;
                    $("#myModalLoad").modal('hide');
                    $('#modalAlert').modal('show');
                }
            });
        }
    </script>
</asp:Content>

