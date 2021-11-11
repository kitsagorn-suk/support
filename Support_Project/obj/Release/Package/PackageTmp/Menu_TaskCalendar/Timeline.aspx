 <%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Timeline.aspx.cs" Inherits="Support_Project.Menu_TaskCalendar.Timeline" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .disabled-link {
            cursor: default;
            pointer-events: none;
            text-decoration: none;
            color: grey !important;
        }

        select {
            display: block !important;
        }

        .checkbox-inline {
            font-size: .8rem;
        }

        .chk[type=checkbox]:checked, .chk[type=checkbox]:not(:checked) {
            position: initial !important;
            opacity: initial !important;
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
            width: 10em;
            white-space: nowrap;
            overflow: hidden;
            font-size: 0.8rem;
        }

        .soverflowTable {
            margin: 0px !important;
            width: 8em;
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

        .iconTime {
            position: absolute;
            top: 12px;
            left: 121px;
            z-index: 9;
        }
    </style>
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="" set-lan="text:Report"></a></li>
            <li class="breadcrumb-item active txtMem" set-lan="text:Leave"></li>
        </ol>
    </nav>
    <div class="row">
        <div class="col-md-8">
            <h1 set-lan="text:Leave"></h1>
        </div>
        <div class="col-md-4" style="text-align: right; display: none;">
            <a class="btn btn-primary" onclick="addLeave()" style="color: #2F80ED !important;" set-lan="html:Add"></a>
        </div>
    </div>
    <div class="btn-toolbar section-group" role="toolbar" style="padding-left: 1.5rem;">
        <div class="row">
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
        <div class="row" style="padding-left: 2.5rem;">
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
            <label for="email" class="col-form-label alignright" set-lan="text:Leave type_">Leave type :</label>
            <div style="padding-left: 1rem;" class="select-outline">
                <asp:DropDownList ID="ddlLeaveTypeSearch" runat="server" class="form-control" DataValueField="id" DataTextField="name">
                </asp:DropDownList>
            </div>
        </div>
        <div class="row" style="padding-left: 2.5rem;">
            <button class="btn btn-yellow font-weight-bold m-0 px-3 py-2 z-depth-0 waves-effect btnMenu" type="button" onclick="Search_Click()" set-lan="text:Search"></button>
        </div>
    </div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="Search_click" autopostback="false" Style="display: none;" CausesValidation="false" />
            <div class="table-wrapper" style="margin-top: 1rem; margin-bottom: 1rem;">
                <table class="table table-border" id="tbData">
                    <thead class="rgba-green-slight">
                        <tr>
                            <th style="width: 12%;" set-lan="text:Username"></th>
                            <th style="width: 20%;" set-lan="text:Leave date"></th>
                            <th style="width: 8%;" set-lan="text:Leave type"></th>
                            <th style="width: 10%;" set-lan="text:Description"></th>
                            <th style="width: 10%;" set-lan="text:Create date"></th>
                            <th style="width: 10%;" set-lan="text:Approve date"></th>
                            <th style="width: 12%;" set-lan="text:Approve by"></th>
                            <th style="width: 5%;" set-lan="text:Status"></th>
                            <th style="width: 7%;" set-lan="text:Total day"></th>
                            <th style="width: 10%;" set-lan="text:Actions"></th>
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
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                    </tfoot>
                </table>
            </div>
            <asp:Button ID="btnApproveLeave" class="btn btn-lg btn-yellow font-weight-bold btn-block" OnClick="ApproveLeave_click" runat="server" Text="Add" Style="display: none;" />
            <asp:Button ID="btnRejectLeave" class="btn btn-lg btn-yellow font-weight-bold btn-block" OnClick="RejectLeave_click" runat="server" Text="Add" Style="display: none;" />
            <asp:Button ID="btnAddLeave" class="btn btn-lg btn-yellow font-weight-bold btn-block" OnClick="AddLeave_click" runat="server" Text="Add" Style="display: none;" />
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
    <div class="modal fade" id="modalAddLeave" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold" id="txtModal">Add Leave</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-3 text-center">
                    <div class="form-group row">
                        <label for="username" class="col-4 col-form-label" style="text-align: right;">
                            <label style='color: red;'>*</label>Start Date :</label>
                        <div class="col-8" style="display: inline-flex;">
                            <div class="fieldStart" style="">
                                <i class="fas fa-calendar-alt iconCalendarAdd"></i>
                                <input type="date" data-date="" id="LeaveStartDate" class="testDate form-control" data-date-format="DD-MM-YYYY" style="width: 120px;" />
                            </div>
                            <div class="fieldStart" style="margin-left: 1rem;">
                                <i class="fa fa-clock iconTimeAdd"></i>
                                <input type="time" data-date="" class="testDate form-control" id="LeaveStartTime" data-date-format="hh:mm A" style="width: 120px;">
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="username" class="col-4 col-form-label" style="text-align: right;">
                            <label style='color: red;'>*</label>To Date :</label>
                        <div class="col-8" style="display: inline-flex;">
                            <div class="fieldStart" style="">
                                <i class="fas fa-calendar-alt iconCalendarAdd"></i>
                                <input type="date" data-date="" id="LeaveToDate" class="testDate form-control" data-date-format="DD-MM-YYYY" style="width: 120px;" />
                            </div>
                            <div class="fieldStart" style="margin-left: 1rem;">
                                <i class="fa fa-clock iconTimeAdd"></i>
                                <input type="time" data-date="" class="testDate form-control" id="LeaveToTime" data-date-format="hh:mm A" style="width: 120px;">
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="username" class="col-4 col-form-label" style="text-align: right;">
                            <label style='color: red;'>*</label>Type :</label>
                        <div class="col-8">
                            <asp:DropDownList ID="ddlLeaveTypeAdd" runat="server" class="form-control" DataValueField="id" DataTextField="name" AutoPostBack="false">
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="username" class="col-4 col-form-label" style="text-align: right;">
                            <label style='color: red;'>*</label>Description :</label>
                        <div class="col-8">
                            <asp:TextBox runat="server" ID="Description" TextMode="MultiLine" Rows="5" class="form-control" autocomplete="off" MaxLength="200" onkeypress="return maxLengthfield(this,200);" />
                        </div>
                    </div>
                </div>
                <div class="modal-footer d-flex justify-content-center">
                    <button class="btn btn-yellow font-weight-bold" onclick="SaveLeave()" type="button" set-lan="text:Save"></button>
                    <button type="button" class="btn btn-yellow font-weight-bold" data-dismiss="modal" aria-label="Close" set-lan="text:Close"></button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="modalAlertApprove" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-3 text-center">
                    <label set-lan="text:Confirm approve this leave ?"></label>
                </div>
                <div class="modal-footer d-flex justify-content-center">
                    <button class="btn btn-yellow font-weight-bold" onclick="SaveApproveLeave()" type="button" set-lan="text:OK"></button>
                    <button type="button" class="btn btn-yellow font-weight-bold" data-dismiss="modal" aria-label="Close" set-lan="text:Close"></button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="modalAlertReject" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-3 text-center">
                    <label set-lan="text:Confirm reject this leave ?"></label>
                </div>
                <div class="modal-footer d-flex justify-content-center">
                    <button class="btn btn-yellow font-weight-bold" onclick="SaveRejectLeave()" type="button" set-lan="text:OK"></button>
                    <button type="button" class="btn btn-yellow font-weight-bold" data-dismiss="modal" aria-label="Close" set-lan="text:Close"></button>
                </div>
            </div>
        </div>
    </div>
    <asp:HiddenField ID="LeaveTypeSearch" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="LeaveTypeAdd" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="LeaveStartDateAdd" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="LeaveToDateAdd" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="LeaveStartDateSearch" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="LeaveToDateSearch" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="ApproveID" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="RejectID" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="IDRole" runat="Server"></asp:HiddenField>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainScript" runat="server">
    <script src="../js/moment.min.js"></script>
    <script>
        var token = "";
        $(document).ready(function () {
            $("#menuTaskCalendar , #menuTaskCalendar > a , #menuTaskCalendarTimelineAll > a").addClass("active");
            $("#menuTaskCalendar > div").css("display", "block");
            $("option[value='']").attr("disabled", "disabled");

            var date = new Date();
            var dateSet = date.getFullYear() + "-" + ("0" + (date.getMonth() + 1)).slice(-2) + "-" + ("0" + date.getDate()).slice(-2);
            $("#startdate").val(dateSet);
            $("#todate").val(dateSet);
            $("#LeaveStartDate").val(dateSet);
            $("#LeaveToDate").val(dateSet);

            $('#starttime, #LeaveStartTime').val('00:00');
            var currenttime = ("0" + date.getHours()).slice(-2) + ":" + ("0" + date.getMinutes()).slice(-2);
            $('#totime, #LeaveToTime').val(currenttime);

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

            if ($('#<%=IDRole.ClientID%>').val() != "Master" && $('#<%=IDRole.ClientID%>').val() != "Super User") {
                $("#tbData > thead > tr > th:nth-child(10), #tbData > tbody > tr > td:nth-child(10), #tbData > tfoot > tr > td:nth-child(9)").remove();
            }
        });

        function maxLengthfield(field, maxChars) {
            if (field.value.length >= maxChars) {
                event.returnValue = false;
                //alert("more than " + maxChars + " chars");
                //field.value = field.value.substring(0, maxChars);
                return false;
            }
        }

        function addLeave() {
            var date = new Date();
            var dateSet = date.getFullYear() + "-" + ("0" + (date.getMonth() + 1)).slice(-2) + "-" + ("0" + date.getDate()).slice(-2);
            $("#LeaveStartDate").val(dateSet);
            $("#LeaveToDate").val(dateSet);

            $('#LeaveStartTime').val('00:00');
            var currenttime = ("0" + date.getHours()).slice(-2) + ":" + ("0" + date.getMinutes()).slice(-2);
            $('#LeaveToTime').val(currenttime);

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

            $('#<%=ddlLeaveTypeAdd.ClientID%>').prop("selectedIndex", 0);
            $('#<%=Description.ClientID%>').val("");
            $('#modalAddLeave').modal();
        }

        function alertModal(txtAlert) {
            document.getElementById("lbAlert").setAttribute("set-lan", "text:" + txtAlert + "");
            SetLan(localStorage.getItem('Language'));
            $('#modalAlert').modal('show');
            $("#myModalLoad, #modalAlertApprove, #modalAlertReject, #modalAddLeave").modal('hide');
            setTimeout(function () { $('#modalAlert').modal('hide') }, 2000);
        }

        function Search_Click() {
            $("#<%=LeaveTypeSearch.ClientID%>").val(document.getElementById("<%=ddlLeaveTypeSearch.ClientID%>").value);
            var txt1 = $("#startdate").val() + " " + $('#LeaveStartTime').val() + ":00";
            var txt2 = $("#todate").val() + " " + $('#LeaveToTime').val() + ":00";
            $("#<%=LeaveStartDateSearch.ClientID%>").val(txt1);
            $("#<%=LeaveToDateSearch.ClientID%>").val(txt2);

            $("#myModalLoad").modal();

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

        function getApprove(id) {
            $("#<%=ApproveID.ClientID%>").val(id);
            $("#modalAlertApprove").modal();
        }

        function getReject(id) {
            $("#<%=RejectID.ClientID%>").val(id);
            $("#modalAlertReject").modal();
        }

        function SaveApproveLeave() {
            $("#myModalLoad").modal();
            $("#<%=btnApproveLeave.ClientID%>").click();
        }

        function SaveRejectLeave() {
            $("#myModalLoad").modal();
            $("#<%=btnRejectLeave.ClientID%>").click();
        }

        function SaveLeave() {
            $("#myModalLoad").modal();
            var dateOne = $("#LeaveStartDate").val() + " " + $("#LeaveStartTime").val() + ":00";
            var dateTwo = $("#LeaveToDate").val() + " " + $("#LeaveToTime").val() + ":00";
            var date1 = Date.parse(dateOne);
            var date2 = Date.parse(dateTwo);
            if (date1 > date2) {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:Field 'To Date' should be greater than 'Start Date'.");
                SetLan(localStorage.getItem("Language"));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else if ($('#LeaveStartDate').val() == "") {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:missing 'Start date' field");
                SetLan(localStorage.getItem("Language"));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else if ($('#LeaveToDate').val() == "") {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:missing 'To date' field");
                SetLan(localStorage.getItem("Language"));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else if (document.getElementById("<%=ddlLeaveTypeAdd.ClientID%>").value == "") {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:missing 'Type' field");
                SetLan(localStorage.getItem('Language'));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else if ($('#<%=Description.ClientID%>').val() == "") {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:missing 'Description' field");
                SetLan(localStorage.getItem('Language'));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else {
                var dateStart = $("#LeaveStartDate").val();
                var dateStartTime = $("#LeaveStartTime").val();
                var totalDateStart = dateStart + " " + dateStartTime + ":00";
                $("#<%=LeaveStartDateAdd.ClientID%>").val(totalDateStart);

                var dateEnd = $("#LeaveToDate").val();
                var dateEndTime = $("#LeaveToTime").val();
                var totalDateEnd = dateEnd + " " + dateEndTime + ":00";
                $("#<%=LeaveToDateAdd.ClientID%>").val(totalDateEnd);

                $("#<%=LeaveTypeAdd.ClientID%>").val(document.getElementById("<%=ddlLeaveTypeAdd.ClientID%>").value);
                $("#<%=btnAddLeave.ClientID%>").click();
            }
        }

        function setDataLanguage() {
            SetLan(localStorage.getItem('Language'));
            $('#myModalLoad').modal('hide');
        }
    </script>
</asp:Content>
