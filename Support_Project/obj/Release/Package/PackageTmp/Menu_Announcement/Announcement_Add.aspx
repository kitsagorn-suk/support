<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Announcement_Add.aspx.cs" Inherits="Support_Project.Menu_Announcement.Announcement_Add" %>

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
            margin: 20px auto;
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
    </style>
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="" set-lan="text:Announcement"></a></li>
            <li class="breadcrumb-item active txtMem" set-lan="text:Add Announcement"></li>
        </ol>
    </nav>
    <div class="row">
        <div class="col-md-8">
            <h1 set-lan="text:Add Announcement"></h1>
        </div>
    </div>
    <div class="section-group mb-4 col-6">
        <div class="form-row">
            <div class="form-group col-12">
                <div class="form-group row">
                    <label for="username" class="col-3 col-form-label" style="text-align: right;" set-lan="html:Title__"></label>
                    <div class="col-9">
                        <asp:TextBox ID="title" class="form-control" autocomplete="off" runat="server" MaxLength="100" />
                    </div>
                </div>
                <div class="form-group row">
                    <label for="username" class="col-3 col-form-label" style="text-align: right;" set-lan="html:Description__"></label>
                    <div class="col-9">
                        <asp:TextBox runat="server" ID="description" TextMode="MultiLine" Rows="2" class="form-control" autocomplete="off" />
                    </div>
                </div>
                <div class="form-group row zoneAgent">
                    <label for="username" class="col-3 col-form-label" style="text-align: right;" set-lan="html:To Agent__"></label>
                    <div class="col-8 inModal">
                        <asp:DropDownList ID="ddlAgent" runat="server" class="form-control" DataValueField="id" DataTextField="name">
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="username" class="col-3 col-form-label" style="text-align: right;" set-lan="html:Start Date__"></label>
                    <div class="col-9" style="display: inline-flex;">
                        <div class="fieldStart" style="">
                            <i class="fas fa-calendar-alt iconCalendarAdd"></i>
                            <input type="date" data-date="" id="AnnouncementStartDate" class="testDate form-control" data-date-format="DD-MM-YYYY" style="width: 120px;" />
                        </div>
                        <div class="fieldStart" style="margin-left: 1rem;">
                            <i class="fa fa-clock iconTimeAdd"></i>
                            <input type="time" data-date="" class="testDate form-control" id="AnnouncementStartTime" data-date-format="hh:mm A" style="width: 120px;">
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="username" class="col-3 col-form-label" style="text-align: right;" set-lan="html:To Date__"></label>
                    <div class="col-9" style="display: inline-flex;">
                        <div class="fieldStart" style="">
                            <i class="fas fa-calendar-alt iconCalendarAdd"></i>
                            <input type="date" data-date="" id="AnnouncementToDate" class="testDate form-control" data-date-format="DD-MM-YYYY" style="width: 120px;" />
                        </div>
                        <div class="fieldStart" style="margin-left: 1rem;">
                            <i class="fa fa-clock iconTimeAdd"></i>
                            <input type="time" data-date="" class="testDate form-control" id="AnnouncementToTime" data-date-format="hh:mm A" style="width: 120px;">
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="username" class="col-3 col-form-label" style="text-align: right;" set-lan="html:Order__"></label>
                    <div class="col-9">
                        <asp:TextBox runat="server" ID="order" class="form-control" autocomplete="off" oninput="this.value=this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" />
                    </div>
                </div>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" style="margin-bottom: -2rem;">
                    <ContentTemplate>
                        <div class="form-group row">
                            <label for="username" class="col-3 col-form-label" style="text-align: right;" set-lan="text:Attach file_"></label>
                            <div class="col-9" style="display: inline-flex;">
                                <asp:FileUpload ID="AttahcFile1" runat="server" class="form-control" onchange="CheckExt(this)" />
                                <a style="font-size: 1.6rem; padding-left: .5rem;" class="link icon1" onclick="showAttach('2');"><i class="fas fa-plus-square" style="color: #CFA137;"></i></a>
                            </div>
                        </div>
                        <div class="form-group row attach2" style="display: none;">
                            <label for="username" class="col-3 col-form-label" style="text-align: right;" set-lan="text:Attach file_"></label>
                            <div class="col-9" style="display: inline-flex;">
                                <asp:FileUpload ID="AttahcFile2" runat="server" class="form-control" onchange="CheckExt(this)" />
                                <a style="font-size: 1.6rem; padding-left: .5rem;" class="link icon2" onclick="showAttach('3');"><i class="fas fa-plus-square" style="color: #CFA137;"></i></a>
                            </div>
                        </div>
                        <div class="form-group row attach3" style="display: none;">
                            <label for="username" class="col-3 col-form-label" style="text-align: right;" set-lan="text:Attach file_"></label>
                            <div class="col-9" style="display: inline-flex;">
                                <asp:FileUpload ID="AttahcFile3" runat="server" class="form-control" onchange="CheckExt(this)" />
                                <a style="font-size: 1.6rem; padding-left: .5rem;" class="link icon3" onclick="showAttach('4');"><i class="fas fa-plus-square" style="color: #CFA137;"></i></a>
                            </div>
                        </div>
                        <div class="form-group row attach4" style="display: none;">
                            <label for="username" class="col-3 col-form-label" style="text-align: right;" set-lan="text:Attach file_"></label>
                            <div class="col-9" style="display: inline-flex;">
                                <asp:FileUpload ID="AttahcFile4" runat="server" class="form-control" onchange="CheckExt(this)" />
                                <a style="font-size: 1.6rem; padding-left: .5rem;" class="link icon4" onclick="showAttach('5');"><i class="fas fa-plus-square" style="color: #CFA137;"></i></a>
                            </div>
                        </div>
                        <div class="form-group row attach5" style="display: none;">
                            <label for="username" class="col-3 col-form-label" style="text-align: right;" set-lan="text:Attach file_"></label>
                            <div class="col-9">
                                <asp:FileUpload ID="AttahcFile5" runat="server" class="form-control" onchange="CheckExt(this)" />
                            </div>
                        </div>
                        <asp:Button ID="btnAddAnnouncement" class="btn btn-lg btn-yellow font-weight-bold btn-block" OnClick="AddAnnouncement_click" runat="server" Text="Add" Style="display: none;" autoPostBack="false" />
                    </ContentTemplate>
                    <Triggers>
                        <asp:PostBackTrigger ControlID="btnAddAnnouncement" />
                    </Triggers>
                </asp:UpdatePanel>
                <div class="form-group row">
                    <label for="username" class="col-3 col-form-label" style="text-align: right;"></label>
                    <div class="col-9"><small class="text-muted form-text" style="text-align: left;" set-lan="text:Note_ You can only upload a maximum of 5 files."></small></div>
                </div>
            </div>
        </div>
        <div class="form-row">
            <div class="col-12" style="text-align: center;">
                <button id="bAdd" class="btn btn-yellow font-weight-bold waves-effect waves-light" onclick="SaveAnnouncement()" type="button" set-lan="text:Add Announcement"></button>
            </div>
        </div>
    </div>
    <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
           
        </ContentTemplate>
    </asp:UpdatePanel>--%>
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
                    <h4 class="modal-title w-100 font-weight-bold" set-lan="text:Attach File"></h4>
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainScript" runat="server">
    <script src="../js/moment.min.js"></script>
    <script src="../js/pagination.js"></script>
    <script>
        var token = "";
        $(document).ready(function () {
            $("#menuAnnouncement , #menuAnnouncement > a , #menuAnnouncementAdd > a").addClass("active");
            $("#menuAnnouncement > div").css("display", "block");

            var date = new Date();
            var dateSet = date.getFullYear() + "-" + ("0" + (date.getMonth() + 1)).slice(-2) + "-" + ("0" + date.getDate()).slice(-2);
            $("#startdate").val(dateSet);
            $("#todate").val(dateSet);
            $("#AnnouncementStartDate").val(dateSet);
            $("#AnnouncementToDate").val(dateSet);

            $('#starttime, #AnnouncementStartTime').val('00:00');
            var currenttime = ("0" + date.getHours()).slice(-2) + ":" + ("0" + date.getMinutes()).slice(-2);
            $('#totime, #AnnouncementToTime').val(currenttime);

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

            $("option[value='']").attr("disabled", "disabled");
        });

        function maxLengthfield(field, maxChars) {
            if (field.value.length >= maxChars) {
                event.returnValue = false;
                //alert("more than " + maxChars + " chars");
                //field.value = field.value.substring(0, maxChars);
                return false;
            }
        }

        function showAttach(no) {
            if (no == "2") {
                $(".attach2").css("display", "flex");
                $(".icon1").css("display", "none");
            }
            else if (no == "3") {
                $(".attach3").css("display", "flex");
                $(".icon2").css("display", "none");
            }
            else if (no == "4") {
                $(".attach4").css("display", "flex");
                $(".icon3").css("display", "none");
            }
            else if (no == "5") {
                $(".attach5").css("display", "flex");
                $(".icon4").css("display", "none");
            }
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

        function addAnnouncement() {
            $("#bAdd").css("display", "flex");
            $("#txtModal").text("Add Announcement");
            $('#<%=ddlAgent.ClientID%>').prop("selectedIndex", 0);
            $('#<%=title.ClientID%>,#<%=description.ClientID%>,#<%=AttahcFile1.ClientID%>,#<%=AttahcFile2.ClientID%>,#<%=AttahcFile3.ClientID%>,#<%=AttahcFile4.ClientID%>,#<%=AttahcFile5.ClientID%>').val("");

            var date = new Date();
            var dateSet = date.getFullYear() + "-" + ("0" + (date.getMonth() + 1)).slice(-2) + "-" + ("0" + date.getDate()).slice(-2);
            $("#AnnouncementStartDate").val(dateSet);
            $("#AnnouncementToDate").val(dateSet);

            $('#AnnouncementStartTime').val('00:00');
            var currenttime = ("0" + date.getHours()).slice(-2) + ":" + ("0" + date.getMinutes()).slice(-2);
            $('#AnnouncementToTime').val(currenttime);

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

            $('#modalAddAnnouncement').modal();
        }

        function SaveAnnouncement() {
            $("#myModalLoad").modal();
            var dateOne = $("#AnnouncementStartDate").val() + " " + $("#AnnouncementStartTime").val() + ":00";
            var dateTwo = $("#AnnouncementToDate").val() + " " + $("#AnnouncementToTime").val() + ":00";
            var date1 = Date.parse(dateOne);
            var date2 = Date.parse(dateTwo);
            if (date1 > date2) {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:Field 'To Date' should be greater than 'Start Date'.");
                SetLan(localStorage.getItem("Language"));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else if ($('#AnnouncementStartDate').val() == "") {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:missing 'Start date' field");
                SetLan(localStorage.getItem("Language"));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else if ($('#AnnouncementToDate').val() == "") {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:missing 'To date' field");
                SetLan(localStorage.getItem("Language"));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else if ($('#<%=title.ClientID%>').val() == "") {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:missing 'Title' field");
                SetLan(localStorage.getItem("Language"));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else if ($('#<%=description.ClientID%>').val() == "") {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:missing 'Description' field");
                SetLan(localStorage.getItem('Language'));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else if (document.getElementById("<%=ddlAgent.ClientID%>").value == "") {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:missing 'Agent' field");
                SetLan(localStorage.getItem('Language'));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else if ($('#<%=order.ClientID%>').val() == "") {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:missing 'Order' field");
                SetLan(localStorage.getItem('Language'));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else {
                var dateStart = $("#AnnouncementStartDate").val();
                var dateStartTime = $("#AnnouncementStartTime").val();
                var totalDateStart = dateStart + " " + dateStartTime + ":00";
                $("#<%=AnnouncementStartDateAdd.ClientID%>").val(totalDateStart);

                var dateEnd = $("#AnnouncementToDate").val();
                var dateEndTime = $("#AnnouncementToTime").val();
                var totalDateEnd = dateEnd + " " + dateEndTime + ":00";
                $("#<%=AnnouncementToDateAdd.ClientID%>").val(totalDateEnd);

                $("#<%=AnnouncementAgentAdd.ClientID%>").val(document.getElementById("<%=ddlAgent.ClientID%>").value);
                $("#<%=btnAddAnnouncement.ClientID%>").click();
            }
            SetLan(localStorage.getItem('Language'));
}

function alertModal(txtAlert) {
    document.getElementById("lbAlert").setAttribute("set-lan", "text:" + txtAlert + "");
    SetLan(localStorage.getItem('Language'));
    $('#modalAlert').modal('show');
    $("#myModalLoad").modal('hide');

    if (txtAlert == "Add new announcement success.") {
        setTimeout(function () { window.location.href = "../Menu_Announcement/Announcement.aspx"; }, 1500);
    }
    else {
        setTimeout(function () { $('#modalAlert').modal('hide') }, 2000);
    }
}
    </script>
</asp:Content>

