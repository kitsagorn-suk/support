<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Timeline_Add.aspx.cs" Inherits="Support_Project.Menu_TaskCalendar.Timeline_Add" %>

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
            <li class="breadcrumb-item active txtMem" set-lan="text:Add Leave"></li>
        </ol>
    </nav>
    <div class="row">
        <div class="col-md-8">
            <h1 set-lan="text:Add Leave"></h1>
        </div>
    </div>
    <div class="section-group mb-4 col-6">
        <div class="form-row">
            <div class="form-group col-12">
                <div class="form-group row">
                    <label for="username" class="col-3 col-form-label" style="text-align: right;" set-lan="html:Start Date__"></label>
                    <div class="col-9" style="display: inline-flex;">
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
                    <label for="username" class="col-3 col-form-label" style="text-align: right;" set-lan="html:To Date__"></label>
                    <div class="col-9" style="display: inline-flex;">
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
                    <label for="username" class="col-3 col-form-label" style="text-align: right;" set-lan="html:Type__"></label>
                    <div class="col-9">
                        <asp:DropDownList ID="ddlLeaveTypeAdd" runat="server" class="form-control" DataValueField="id" DataTextField="name" AutoPostBack="false">
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="username" class="col-3 col-form-label" style="text-align: right;" set-lan="html:Description__"></label>
                    <div class="col-9">
                        <asp:TextBox runat="server" ID="Description" TextMode="MultiLine" Rows="5" class="form-control" autocomplete="off" MaxLength="200" onkeypress="return maxLengthfield(this,200);" />
                    </div>
                </div>
            </div>
        </div>
        <div class="form-row">
            <div class="col-12" style="text-align: center;">
                <button id="bAdd" class="btn btn-yellow font-weight-bold waves-effect waves-light" onclick="SaveLeave()" type="button" set-lan="text:Add Leave"></button>
            </div>
        </div>
    </div>
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
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
            $("#menuTaskCalendar , #menuTaskCalendar > a , #menuTaskCalendarTimeline > a").addClass("active");
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
        });

        function maxLengthfield(field, maxChars) {
            if (field.value.length >= maxChars) {
                event.returnValue = false;
                //alert("more than " + maxChars + " chars");
                //field.value = field.value.substring(0, maxChars);
                return false;
            }
        }

        function alertModal(txtAlert) {
            document.getElementById("lbAlert").setAttribute("set-lan", "text:" + txtAlert + "");
            SetLan(localStorage.getItem('Language'));
            $('#modalAlert').modal('show');
            $("#myModalLoad").modal('hide');

            if (txtAlert == "Add new leave success.") {
                setTimeout(function () { window.location.href = "../Menu_TaskCalendar/Timeline.aspx"; }, 1500);
            }
            else {
                setTimeout(function () { $('#modalAlert').modal('hide') }, 2000);
            }
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
            SetLan(localStorage.getItem('Language'));
}
    </script>
</asp:Content>
