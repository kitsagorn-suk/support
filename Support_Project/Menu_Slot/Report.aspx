<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Report.aspx.cs" Inherits="Support_Project.Menu_Slot.Report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
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
    <div class="row">
        <div class="col-md-8">
            <h1 set-lan="text:Slot"></h1>
        </div>
    </div>
    <div class="btn-toolbar section-group" role="toolbar" style="padding-left: 2.5rem;">
        <div class="col-md-12 row">
            <div class="row">
                <label for="email" class="col-form-label" set-lan="text:Bet ID_"></label>
                <div style="padding-left: 1rem;">
                    <input type="text" class="form-control" id="searchBetID" set-lan="placeholder:Bet ID" onkeyup="inputKeyUp(event)" />
                </div>
            </div>
            <div class="row" style="margin-left: 2.5rem;">
                <label for="email" class="col-form-label" set-lan="text:Username_"></label>
                <div style="padding-left: 1rem;">
                    <input type="text" class="form-control" id="searchUsername" set-lan="placeholder:Username" onkeyup="inputKeyUp(event)" />
                </div>
            </div>
            <div class="row" style="padding-left: 2.5rem;">
                <label for="email" class="col-form-label alignright" set-lan="html:Agent__"></label>
                <div style="padding-left: 1rem;" class="select-outline">
                    <select name="" id="ddlAgent" class="mdb-select" data-live-search="true" searchable="Search here..">
                       <asp:Literal ID="LiteralDataDropdown" runat="server"></asp:Literal>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-md-12 row" style="margin-top: .5rem;">
            <div class="row fieldStart" style="">
                <label for="email" class="col-form-label" set-lan="text:Start date_"></label>
                <div style="padding-left: 1rem;" class="input-wrapper">
                    <i class="fas fa-calendar-alt iconCalendar"></i>
                    <input type="date" data-date="" id="startdate" class="testDate form-control" data-date-format="DD-MM-YYYY" style="width: 130px;" />
                </div>
            </div>
            <div class="row input-wrapper" style="padding-left: 2rem;">
                <i class="fa fa-clock iconTime"></i>
                <input type="time" data-date="" class="testDate form-control" id="starttime" data-date-format="hh:mm A" style="width: 120px;">
            </div>
            <div class="row" style="padding-left: 3.9rem;">
                <label for="email" class="col-form-label" set-lan="text:To date_"></label>
                <div style="padding-left: 1rem;" class="input-wrapper">
                    <i class="fas fa-calendar-alt iconCalendar"></i>
                    <input type="date" data-date="" id="todate" class="testDate form-control" data-date-format="DD-MM-YYYY" style="width: 130px;" />
                </div>
            </div>
            <div class="row input-wrapper" style="padding-left: 2rem;">
                <i class="fa fa-clock iconTime"></i>
                <input type="time" data-date="" class="testDate form-control" id="totime" data-date-format="hh:mm A" style="width: 120px;">
            </div>
            <div class="row" style="padding-left: 2.5rem;">
                <button class="btn btn-yellow font-weight-bold m-0 px-3 py-2 z-depth-0 waves-effect btnMenu" type="button" onclick="Search_Click('','')" set-lan="text:Search"></button>
            </div>
        </div>
    </div>
    <div id="zonePlsSearch" class="btn-toolbar section-group" role="toolbar" style="margin-top: 1rem; padding-top: 2rem; font-weight: bold; background-color: #dee2e6;">
        <p class="col-12" style="text-align: center; color: #333;" set-lan="text:Please enter search."></p>
    </div>
    <div class="table-wrapper" style="margin-top: 1rem; margin-bottom: 1rem; display: none;" id="zoneSearch">
        <div class="row" style="margin-bottom: 1rem; margin-top: 1rem;">
            <div class="col-8">
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
            <div class="col-4">
                <div id="wrapper" style="float: right;">
                    <section>
                        <div class="data-container"></div>
                        <div id="pagination-demo2"></div>
                    </section>
                </div>
            </div>
        </div>
        <table class="table table-border" id="tbDataSportbook">
            <thead class="rgba-green-slight">
                <tr>
                    <th set-lan="text:Bet ID"></th>
                    <th set-lan="text:Username"></th>
                    <th set-lan="text:Game Type"></th>
                    <th set-lan="text:Status"></th>
                    <th set-lan="text:Game"></th>
                    <th set-lan="text:Source"></th>
                    <th set-lan="text:Create date"></th>
                    <th set-lan="text:Game Date"></th>
                    <th set-lan="text:Amount"></th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td colspan="9" style="text-align: center;" set-lan="text:No Data."></td>
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
        var NumPage = 1;
        var token = "";
        var agent = "";
        var typeTime = "Day";
        $(document).ready(function () {
            $("#menuSlot > a").addClass("active");

            var date = new Date();
            var dateSet = date.getFullYear() + "-" + ("0" + (date.getMonth() + 1)).slice(-2) + "-" + ("0" + date.getDate()).slice(-2);
            $("#startdate").val(dateSet);
            $("#todate").val(dateSet);

            $('#starttime').val('00:00');
            var currenttime = ("0" + date.getHours()).slice(-2) + ":" + ("0" + date.getMinutes()).slice(-2);
            $('#totime').val(currenttime);

            $("input[type=date]").on("change", function () {
                this.setAttribute(
                    "data-date",
                    moment(this.value, "YYYY-MM-DD")
                    .format(this.getAttribute("data-date-format"))
                )
            }).trigger("change")

            $("input[type=time]").on("change", function () {
                this.setAttribute(
                    "data-date",
                    moment(this.value, "hh:mm A")
                    .format(this.getAttribute("data-date-format"))
                )
            }).trigger("change")

            $('.header').click(function () {
                $(this).nextUntil('tr.header').slideToggle(100, function () {
                });
            });

            var htmlCurAll = "<option value='' selected disabled set-lan='text:Select agent'></option>";
            $(htmlCurAll).insertBefore("#ddlAgent option:first");
            SetLan(localStorage.getItem("Language"));
        });

        function inputKeyUp(e) {
            e.which = e.which || e.keyCode;
            if (e.which == 13) {
                Search_Click('','');
            }
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

        function Search_Click(start, end) {
            $("#myModalLoad").modal();

            var dateOne = "";
            var dateTwo = "";

            if (start == "" && end == "") {
                dateOne = $("#startdate").val() + " " + $("#starttime").val() + ":00";
                dateTwo = $("#todate").val() + " " + $("#totime").val() + ":00";
            }
            else {
                dateOne = start + " " + $("#starttime").val() + ":00";
                dateTwo = end + " " + $("#totime").val() + ":00";
            }

            var date1 = Date.parse(dateOne);
            var date2 = Date.parse(dateTwo);
            if (date1 > date2) {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:Field 'To Date' should be greater than 'Start Date'.");
                SetLan(localStorage.getItem("Language"));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else if ($("#ddlAgent").val() == "" || $("#ddlAgent").val() == null) {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:Please select agent.");
                SetLan(localStorage.getItem("Language"));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else {
                GetData();
            }
        }

        function GetData() {
            agent = $("#ddlAgent").val();
            $("#tbDataSportbook > tbody").html("");

            var dataAdd = new Object();
            if ($("#searchBetID").val() != "" && $("#searchBetID").val() != null) {
                dataAdd.betId = $("#searchBetID").val();
            }
            if ($("#searchUsername").val() != "" && $("#searchUsername").val() != null) {
                dataAdd.username = $("#searchUsername").val();
            }
            var txtDateStart = $('#startdate').val();
            var txtDateEnd = $('#todate').val();
            dataAdd.dateForm = txtDateStart.split('-')[2] + "/" + txtDateStart.split('-')[1] + "/" + txtDateStart.split('-')[0];
            dataAdd.dateTo = txtDateEnd.split('-')[2] + "/" + txtDateEnd.split('-')[1] + "/" + txtDateEnd.split('-')[0];
            dataAdd.agent = agent;
            dataAdd.page = NumPage.toString();
            dataAdd.limit = "100";
            $.ajax({
                url: "https://support-sportbook-api.secure-restapi.com/support-api/slot/findTicketRunningByBet",
                type: 'POST',
                dataType: 'json',
                data: JSON.stringify(dataAdd),
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    if (data.code == 0 || data.code == null) {
                        if (data.result.code > 0) {
                            document.getElementById('lbAlert').innerHTML = data.result.message;
                            $("#myModalLoad").modal('hide');
                            $('#modalAlert').modal('show');
                        }
                        else {
                            $("#zonePlsSearch").css("display", "none");
                            $("#zoneSearch").css("display", "initial");
                            var result = data.result.result.total;
                            GetNumPage(result);
                        }
                        //console.log(result);
                    }
                    else {
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

        function GetNumPage(TotalData) {
            $(function () {
                (function (name) {
                    var container = $('#pagination-' + name);
                    container.pagination({
                        totalNumber: TotalData,
                        pageNumber: NumPage,
                        pageSize: 100,
                        dataSource: 'https://api.flickr.com/services/feeds/photos_public.gne?tags=cat&tagmode=any&format=json&jsoncallback=?',
                        locator: 'items',
                        callback: function (response, pagination) {
                            NumPage = container.pagination('getSelectedPageNum');
                            getSportbook(TotalData, NumPage);
                        }
                    });
                })('demo2');
            });
        }

        function getSportbook(TotalData, numPage) {
            agent = $("#ddlAgent").val();
            $("#tbDataSportbook > tbody").html("");

            var dataAdd = new Object();
            if ($("#searchBetID").val() != "" && $("#searchBetID").val() != null) {
                dataAdd.betId = $("#searchBetID").val();
            }
            if ($("#searchUsername").val() != "" && $("#searchUsername").val() != null) {
                dataAdd.username = $("#searchUsername").val();
            }
            var txtDateStart = $('#startdate').val();
            var txtDateEnd = $('#todate').val();
            dataAdd.dateForm = txtDateStart.split('-')[2] + "/" + txtDateStart.split('-')[1] + "/" + txtDateStart.split('-')[0];
            dataAdd.dateTo = txtDateEnd.split('-')[2] + "/" + txtDateEnd.split('-')[1] + "/" + txtDateEnd.split('-')[0];
            dataAdd.agent = agent;
            dataAdd.page = numPage.toString();
            dataAdd.limit = "100";
            $.ajax({
                url: "https://support-sportbook-api.secure-restapi.com/support-api/slot/findTicketRunningByBet",
                type: 'POST',
                dataType: 'json',
                data: JSON.stringify(dataAdd),
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    if (data.code == 0 || data.code == null) {
                        if (data.result.code == 0) {
                            var dataTotal = data.result.result.betList;
                            var htmlData = "";
                            if (dataTotal.length > 0 && dataTotal != "") {
                                for (var i = 0; i < dataTotal.length; i++) {
                                    var obj = dataTotal[i];
                                    //htmlData += "<tr class='header'>";
                                    htmlData += "<tr>";
                                    htmlData += "<td class='aligncenter' style='font-weight: bold; text-decoration: underline; cursor: pointer;'>" + obj.betId + "</td>";
                                    htmlData += "<td><p class='overflowTable ellipsis' title='" + obj.memberUsername + "'>" + obj.memberUsername + "</p></td>";
                                    htmlData += "<td class='aligncenter'>" + obj.gameType + "</td>";
                                    htmlData += "<td class='aligncenter'>" + obj.status + "</td>";

                                    htmlData += "<td class='alignright'>" + obj.game + "</td>";
                                    htmlData += "<td class='alignright'>" + obj.source + "</td>";

                                    var createDate = new Date(obj.createdDate);
                                    var txtcreateDate = ("0" + createDate.getDate()).slice(-2) + "-" + ("0" + (createDate.getMonth() + 1)).slice(-2) + "-" + ("0" + createDate.getFullYear()).slice(-2) + " " + ("0" + createDate.getHours()).slice(-2) + ":" + ("0" + createDate.getMinutes()).slice(-2) + ":" + ("0" + createDate.getSeconds()).slice(-2);
                                    htmlData += "<td class='aligncenter'>" + txtcreateDate + "</td>";

                                    var gameDate = new Date(obj.gameDate);
                                    var txtgameDate = ("0" + gameDate.getDate()).slice(-2) + "-" + ("0" + (gameDate.getMonth() + 1)).slice(-2) + "-" + ("0" + gameDate.getFullYear()).slice(-2) + " " + ("0" + gameDate.getHours()).slice(-2) + ":" + ("0" + gameDate.getMinutes()).slice(-2) + ":" + ("0" + gameDate.getSeconds()).slice(-2);
                                    htmlData += "<td class='aligncenter'>" + txtgameDate + "</td>";

                                    var betAmount = parseFloat(obj.amount).toFixed(2);
                                    htmlData += "<td class='alignright'>" + betAmount + "</td>";

                                    htmlData += "</tr>";


                                    //htmlData += "<tr style='display: none;'>";
                                    //htmlData += "<td colspan='5'>";
                                    //htmlData += "<table class='table table-border'>";
                                    //htmlData += "<thead class='rgba-green-slight'>";
                                    //htmlData += "<tr>";
                                    //htmlData += "<th style='background-color: #007bff !important;'>Game Code</th>";
                                    //htmlData += "<th style='background-color: #007bff !important;'>Round ID</th>";
                                    //htmlData += "<th style='background-color: #007bff !important;'>TXID</th>";
                                    //htmlData += "<th style='background-color: #007bff !important;'>Description</th>";
                                    //htmlData += "<th style='background-color: #007bff !important;'>Game Name</th>";
                                    //htmlData += "</tr>";
                                    //htmlData += "</thead>";
                                    //htmlData += "<tbody>";
                                    //var arrDetail = obj.detailTicket;
                                    //htmlData += "<tr style='background-color: #e2e2e2;'>";
                                    //htmlData += "<td>" + arrDetail.gameCode + "</td>";
                                    //htmlData += "<td>" + arrDetail.roundId + "</td>";
                                    //htmlData += "<td>" + arrDetail.txns.txId + "</td>";
                                    //htmlData += "<td>" + arrDetail.description + "</td>";
                                    //htmlData += "<td>" + arrDetail.gameName + "</td>";
                                    //htmlData += "</tr>";
                                    //htmlData += "</tbody>";
                                    //htmlData += "</table>";
                                    //htmlData += "</td>";
                                    //htmlData += "</tr>";
                                }
                                //}
                            }
                            else {
                                htmlData += "<tr><td colspan='9' style='text-align: center;' set-lan='text:No Data.'></td></tr>";
                            }

                            $("#tbDataSportbook > tbody").append(htmlData);
                            SetLan(localStorage.getItem("Language"));
                            $("#myModalLoad").modal('hide');

                            $('.header').click(function () {
                                $(this).nextUntil('tr.header').slideToggle(100, function () {
                                });
                            });
                        }
                        else {
                            document.getElementById('lbAlert').innerHTML = data.result.message;
                            var htmlData = "";
                            htmlData += "<tr><td colspan='9' style='text-align: center;' set-lan='text:No Data.'></td></tr>";
                            $("#tbDataSportbook > tbody").append(htmlData);
                            SetLan(localStorage.getItem("Language"));
                            $("#myModalLoad").modal('hide');
                            $('#modalAlert').modal('show');
                        }
                    }
                    else {
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
