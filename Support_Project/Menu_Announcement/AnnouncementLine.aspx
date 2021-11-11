<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AnnouncementLine.aspx.cs" Inherits="Support_Project.Menu_Announcement.AnnouncementLine" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .imgShow {
            width: 100%;
            height: 135px;
            margin-bottom: 1rem;
        }

        #overlay2 {
            position: absolute;
            top: 0%;
            left: 19%;
            position: fixed;
            width: 60%;
            height: 100%;
            background: rgba(0,0,0,0.8) none 50% / contain no-repeat;
            cursor: pointer;
            transition: 0.3s;
            visibility: hidden;
            opacity: 0;
        }

            #overlay2.open {
                visibility: visible;
                opacity: 1;
                z-index: 999;
            }

            #overlay2:after { /* X button icon */
                content: "\2715";
                position: absolute;
                color: #fff;
                top: 10px;
                right: 20px;
                font-size: 2em;
            }

        .disabled-link {
            cursor: default;
            pointer-events: none;
            text-decoration: none;
            color: grey !important;
        }

        #wrapper {
            margin: auto;
            float: right;
        }

        #pagination-data-container {
            margin-top: 5px;
        }

            #pagination-data-container ul {
                padding: 0;
                margin: 0;
            }

            #pagination-data-container li {
                margin-bottom: 5px;
                padding: 5px 10px;
                background: #eee;
                color: #666;
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
                background: transparent;
                bottom: 0;
                color: transparent;
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
            left: 123px;
            z-index: 9;
        }

        .iconTime {
            position: absolute;
            top: 12px;
            left: 121px;
            z-index: 9;
        }

        select {
            display: block !important;
        }

        .iconCalendarAdd {
            position: absolute;
            top: 12px;
            left: 105px;
            z-index: 9;
        }

        .iconTimeAdd {
            position: absolute;
            top: 12px;
            left: 241px;
            z-index: 9;
        }

        .imgShowEdit {
            width: 100%;
            height: 135px;
        }

        #overlayEdit {
            position: absolute;
            top: 0%;
            left: 19%;
            position: fixed;
            width: 60%;
            height: 100%;
            background: rgba(0,0,0,0.8) none 50% / contain no-repeat;
            cursor: pointer;
            transition: 0.3s;
            visibility: hidden;
            opacity: 0;
        }

            #overlayEdit.open {
                visibility: visible;
                opacity: 1;
                z-index: 999;
            }

            #overlayEdit:after { /* X button icon */
                content: "\2715";
                position: absolute;
                color: #fff;
                top: 10px;
                right: 20px;
                font-size: 2em;
            }
    </style>
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="" set-lan="text:Announcement"></a></li>
            <li class="breadcrumb-item active txtMem" set-lan="text:Announcement Line"></li>
        </ol>
    </nav>
    <div class="row">
        <div class="col-md-8">
            <h1 set-lan="text:Announcement Line"></h1>
        </div>
    </div>
    <div class="btn-toolbar section-group" role="toolbar" style="padding-left: 1.5rem;">
        <div class="row fieldStart" style="padding-left: 2.5rem;">
            <label for="email" class="col-form-label" set-lan="text:Start date_"></label>
            <div style="padding-left: 1rem;" class="input-wrapper">
                <i class="fas fa-calendar-alt iconCalendar"></i>
                <input type="date" data-date="" id="startdate" class="testDate form-control" data-date-format="DD-MM-YYYY" style="width: 130px;" />
            </div>
        </div>
        <div class="row input-wrapper" style="padding-left: 1.5rem;">
            <i class="fa fa-clock iconTime"></i>
            <input type="time" data-date="" class="testDate form-control" id="starttime" data-date-format="hh:mm A" style="width: 120px;">
        </div>
        <div class="row" style="padding-left: 2.5rem;">
            <label for="email" class="col-form-label" set-lan="text:To date_"></label>
            <div style="padding-left: 1rem;" class="input-wrapper">
                <i class="fas fa-calendar-alt iconCalendar"></i>
                <input type="date" data-date="" id="todate" class="testDate form-control" data-date-format="DD-MM-YYYY" style="width: 130px;" />
            </div>
        </div>
        <div class="row input-wrapper" style="padding-left: 1.5rem;">
            <i class="fa fa-clock iconTime"></i>
            <input type="time" data-date="" class="testDate form-control" id="totime" data-date-format="hh:mm A" style="width: 120px;">
        </div>
        <div class="row" style="padding-left: 2.5rem;">
            <button class="btn btn-yellow font-weight-bold m-0 px-3 py-2 z-depth-0 waves-effect btnMenu" type="button" onclick="Search_Click('')" set-lan="text:Search"></button>
        </div>
    </div>
    <div class="row" style="margin-top: 1rem;">
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
            <div id="wrapper">
                <section>
                    <div class="data-container"></div>
                    <div id="pagination-demo2"></div>
                </section>
            </div>
        </div>
    </div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="Search_click" autopostback="false" Style="display: none;" />
            <div class="table-wrapper" style="margin-top: 1rem; margin-bottom: 1rem;">
                <table class="table table-border" id="tbData">
                    <thead class="rgba-green-slight">
                        <tr>
                            <th style="width: 5%;" set-lan="text:No"></th>
                            <th style="width: 20%;" set-lan="text:Description"></th>
                            <th style="width: 10%;" set-lan="text:Image"></th>
                            <th style="width: 10%;" set-lan="text:Create date"></th>
                            <th style="width: 10%;" set-lan="text:Create by"></th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Literal ID="LiteralData" runat="server"></asp:Literal>
                    </tbody>
                    <tfoot class="rgba-yellow-slight">
                        <tr class="total">
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                    </tfoot>
                </table>
            </div>
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
    <div class="modal fade" id="modalImage" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold" set-lan="text:Image"></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-3 text-center">
                    <div id="overlay2"></div>
                    <div class="row" id="imgShow">
                    </div>
                </div>
            </div>
        </div>
    </div>
    <asp:HiddenField ID="AnnouncementStartDateAdd" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="AnnouncementToDateAdd" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="AnnouncementAgentAdd" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="AgentSearch" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="CompanySearch" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="AgentAdd" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="CompanyAdd" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="CompanyEdit" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="AgentEdit" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="StatusEdit" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="IDDelete" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="IDEdit" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="IDRole" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="IDAgent" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="IDCompany" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="CompanyView" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="thisPage" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="totalDocs" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="eventPaging" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="ShareIDLogin" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="AgentID" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="searchDateStart" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="searchDateTo" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="IDEditImage" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="NameDeleteImage" runat="Server"></asp:HiddenField>
     <asp:HiddenField ID="NameImage" runat="Server"></asp:HiddenField>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainScript" runat="server">
    <script src="../js/moment.min.js"></script>
    <script src="../js/pagination.js"></script>
    <script>
        var token = "";
        var typeTime = "Day";
        var startDateSearch = "";
        var endDateSearch = "";
        $(document).ready(function () {
            $("#myModalLoad").modal();
            $("#menuAnnouncement , #menuAnnouncement > a , #AnnouncementLine > a").addClass("active");
            $("#menuAnnouncement > div").css("display", "block");

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

            SetLan(localStorage.getItem('Language'));
            GetData("");
        });

        function maxLengthfield(field, maxChars) {
            if (field.value.length >= maxChars) {
                event.returnValue = false;
                //alert("more than " + maxChars + " chars");
                //field.value = field.value.substring(0, maxChars);
                return false;
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

            startDateSearch = start;
            endDateSearch = end;
            Search_Click('');
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

            startDateSearch = start;
            endDateSearch = end;
            Search_Click('');
        }

        function getImage(name) {
            $("#overlay2").removeClass("open");
            $("#imgShow").html("");
            var htmlFile = "";
            var arrFile = name.split(',');;
            for (var i = 0; i < arrFile.length; i++) {
                if (name != "") {
                    if (arrFile[i].split('.')[1] == "mp4" || arrFile[i].split('.')[1] == "mov" || arrFile[i].split('.')[1] == "wmv" || arrFile[i].split('.')[1] == "avi") {
                        htmlFile += "<video class='col-4 vdo' style='width: 100%; height: 135px; margin-bottom: 1rem;' controls>";
                        htmlFile += "<source src='../FileAttach/" + arrFile[i] + "'>";
                        htmlFile += "</video>";
                    }
                    else {
                        htmlFile += "<img class='col-4 imgShow' src='../FileAttach/" + arrFile[i] + "' />";
                    }
                }
            }

            if (name == "") {
                htmlFile += "<img src='../img/noImage.jpg' style='max-width: 100%; height: auto !important;' />";
            }

            $("#imgShow").append(htmlFile);
            $("#modalImage").modal();

            $('img.imgShow').on('click', function () {
                $('#overlay2')
                  .css({ backgroundImage: `url(${this.src})` })
                  .addClass('open')
                  .one('click', function () { $(this).removeClass('open'); });
            });

            var vid = document.getElementsByClassName("vdo");
            vid.onplay = function () {
            };
        }

        function GetData(count) {
            if ($("[id $= thisPage]").val() == null || $("[id $= thisPage]").val() == "") {
                NumPage = 1;
            }

            if (count == "") {
                TotalData = parseInt($("[id $= totalDocs]").val());
            }
            else {
                TotalData = parseInt(count);
            }

            GetNumPage(NumPage);
        }

        function GetNumPage(NumPage) {
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
                            $("#<%=thisPage.ClientID%>").val(NumPage);
                            Search_Click("paging");
                        }
                    });
                })('demo2');
            });
        }

        function Search_Click(event) {
            if (startDateSearch == "" && endDateSearch == "") {
                var txt1 = $("#startdate").val() + " " + $('#starttime').val() + ":00";
                var txt2 = $("#todate").val() + " " + $('#totime').val() + ":00";
                $("#<%=searchDateStart.ClientID%>").val(txt1);
                $("#<%=searchDateTo.ClientID%>").val(txt2);
            }
            else {
                var txt1 = startDateSearch + " " + $('#starttime').val() + ":00";
                var txt2 = endDateSearch + " " + $('#totime').val() + ":00";
                $("#<%=searchDateStart.ClientID%>").val(txt1);
                $("#<%=searchDateTo.ClientID%>").val(txt2);
                startDateSearch = "";
                endDateSearch = "";
            }

            $("#<%=eventPaging.ClientID%>").val(event);
            if (event != "paging") {
                $("#myModalLoad").modal();
            }

            var dateOne = $("#startdate").val() + " " + $("#starttime").val() + ":00";
            var dateTwo = $("#todate").val() + " " + $("#totime").val() + ":00";
            var date1 = Date.parse(dateOne);
            var date2 = Date.parse(dateTwo);
            if (date1 > date2) {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:Field 'To Date' should be greater than 'Start Date'.");
                SetLan(localStorage.getItem("Language"));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else {
                $("#<%=btnSearch.ClientID%>").click();
            }
            SetLan(localStorage.getItem('Language'));
        }

        function setDataLanguage() {
            SetLan(localStorage.getItem('Language'));
            $('#myModalLoad').modal('hide');
        }

        var validFiles = ["bmp", "gif", "png", "jpg", "jpeg", "mp4", "mov", "wmv", "avi"];
        function CheckExt(obj) {
            var source = obj.value;
            var ext = source.substring(source.lastIndexOf(".") + 1, source.length).toLowerCase();
            for (var i = 0; i < validFiles.length; i++) {
                if (validFiles[i] == ext)
                    break;
            }
            if (i >= validFiles.length) {
                alert("Please load an image with an extention of one of the following:\n\n" + validFiles.join(", "));
                $("#" + obj.id + "").val("");
            }
        }
    </script>
</asp:Content>

