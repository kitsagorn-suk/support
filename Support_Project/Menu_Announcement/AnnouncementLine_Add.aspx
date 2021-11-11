<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AnnouncementLine_Add.aspx.cs" Inherits="Support_Project.AnnouncementLine_Add" %>

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
            <li class="breadcrumb-item active txtMem" set-lan="text:Add Announcement Line"></li>
        </ol>
    </nav>
    <div class="row">
        <div class="col-md-8">
            <h1 set-lan="text:Add Announcement Line"></h1>
        </div>
    </div>
    <div class="section-group mb-4 col-6">
        <div class="form-row">
            <div class="form-group col-12">
                <div class="form-group row">
                    <label for="username" class="col-3 col-form-label" style="text-align: right;" set-lan="html:Description__"></label>
                    <div class="col-9">
                        <asp:TextBox runat="server" ID="description" TextMode="MultiLine" Rows="2" class="form-control" autocomplete="off" />
                    </div>
                </div>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" style="margin-bottom: -2rem;">
                    <ContentTemplate>
                        <div class="form-group row">
                            <label for="username" class="col-3 col-form-label" style="text-align: right;" set-lan="text:Attach file_"></label>
                            <div class="col-9" style="display: inline-flex;">
                                <asp:FileUpload ID="AttahcFile1" runat="server" class="form-control" onchange="CheckExt(this)" />
                            </div>
                        </div>
                        <asp:Button ID="btnAddAnnouncement" class="btn btn-lg btn-yellow font-weight-bold btn-block" OnClick="AddAnnouncement_click" runat="server" Text="Add" Style="display: none;" autoPostBack="false" />
                    </ContentTemplate>
                    <Triggers>
                        <asp:PostBackTrigger ControlID="btnAddAnnouncement" />
                    </Triggers>
                </asp:UpdatePanel>
            </div>
        </div>
        <div class="form-row">
            <div class="col-12" style="text-align: center;">
                <button id="bAdd" class="btn btn-yellow font-weight-bold waves-effect waves-light" onclick="SaveAnnouncement()" type="button" set-lan="text:Send Announcement Line"></button>
            </div>
        </div>
    </div>
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
    <div class="modal fade" id="modalAlertConfirm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-3 text-center">
                    <label set-lan="text:Confirm send announcement to line?">Confirm send announcement to line?</label>
                </div>
                <div class="modal-footer d-flex justify-content-center">
                    <button class="btn btn-yellow font-weight-bold waves-effect waves-light" onclick="confirmAnnouncement()" type="button" set-lan="text:Confirm"></button>
                    <button type="button" class="btn btn-yellow font-weight-bold" data-dismiss="modal" aria-label="Close" set-lan="text:Close"></button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainScript" runat="server">
    <script src="../js/moment.min.js"></script>
    <script src="../js/pagination.js"></script>
    <script>
        var token = "";
        $(document).ready(function () {
            $("#menuAnnouncement , #menuAnnouncement > a , #menuAnnouncementAddLine > a").addClass("active");
            $("#menuAnnouncement > div").css("display", "block");
        });

        function maxLengthfield(field, maxChars) {
            if (field.value.length >= maxChars) {
                event.returnValue = false;
                return false;
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

        function SaveAnnouncement() {
            $("#myModalLoad").modal();
            if ($('#<%=description.ClientID%>').val() == "") {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:missing 'Description' field");
                SetLan(localStorage.getItem('Language'));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else {
                $("#modalAlertConfirm").modal('show');
                $("#myModalLoad").modal('hide');
                SetLan(localStorage.getItem('Language'));
                <%--$("#<%=btnAddAnnouncement.ClientID%>").click();--%>
            }
            SetLan(localStorage.getItem('Language'));
        }

        function confirmAnnouncement() {
            $("#<%=btnAddAnnouncement.ClientID%>").click();
        }

function alertModal(txtAlert) {
    document.getElementById("lbAlert").setAttribute("set-lan", "text:" + txtAlert + "");
    SetLan(localStorage.getItem('Language'));
    $('#modalAlert').modal('show');
    $("#myModalLoad").modal('hide');

    if (txtAlert == "Add new announcement success.") {
        setTimeout(function () { window.location.href = "../Menu_Announcement/AnnouncementLine.aspx"; }, 1500);
    }
    else {
        setTimeout(function () { $('#modalAlert').modal('hide') }, 2000);
    }
}
    </script>
</asp:Content>
