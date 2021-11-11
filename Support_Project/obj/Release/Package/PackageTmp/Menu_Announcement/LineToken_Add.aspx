<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LineToken_Add.aspx.cs" Inherits="Support_Project.Menu_Announcement.LineToken_Add" %>

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
            <li class="breadcrumb-item"><a href="" set-lan="text:Announcement"></a></li>
            <li class="breadcrumb-item active txtMem" set-lan="text:Add Line Token"></li>
        </ol>
    </nav>
    <div class="row">
        <div class="col-md-8">
            <h1 set-lan="text:Add Line Token"></h1>
        </div>
    </div>
    <div class="section-group mb-4 col-6">
        <div class="form-row">
            <div class="form-group col-12">
                <div class="form-group row">
                    <label for="username" class="col-3 col-form-label" style="text-align: right;" set-lan="html:NameGroup__"></label>
                    <div class="col-9">
                        <asp:TextBox ID="NameGroup" class="form-control" autocomplete="off" runat="server" MaxLength="255" />
                    </div>
                </div>
                <div class="form-group row">
                    <label for="username" class="col-3 col-form-label" style="text-align: right;" set-lan="html:Token__"></label>
                    <div class="col-9">
                        <asp:TextBox ID="Token" class="form-control" autocomplete="off" runat="server" MaxLength="100" />
                    </div>
                </div>
            </div>
        </div>
        <div class="form-row">
            <div class="col-12" style="text-align: center;">
                <button id="bAdd" class="btn btn-yellow font-weight-bold waves-effect waves-light" onclick="SaveLineToken()" type="button" set-lan="text:Add Line Token"></button>
            </div>
        </div>
    </div>
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <asp:Button ID="btnAddLineToken" class="btn btn-lg btn-yellow font-weight-bold btn-block" OnClick="AddLineToken_click" runat="server" Text="Add" Style="display: none;" />
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainScript" runat="server">
    <script>
        var token = "";
        $(document).ready(function () {
            $("#menuAnnouncement , #menuAnnouncement > a , #menuLineTokenAdd > a").addClass("active");
            $("#menuAnnouncement > div").css("display", "block");

            $("option[value='']").attr("disabled", "disabled");
        });

        function SaveLineToken() {
            $("#myModalLoad").modal();
            if ($('#<%=NameGroup.ClientID%>').val() == "") {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:missing 'Name group' field");
                SetLan(localStorage.getItem("Language"));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else if ($('#<%=Token.ClientID%>').val() == "") {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:missing 'Token' field");
                SetLan(localStorage.getItem('Language'));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else {
                $("#<%=btnAddLineToken.ClientID%>").click();
            }
            SetLan(localStorage.getItem('Language'));
        }

        function alertModal(txtAlert) {
            document.getElementById("lbAlert").setAttribute("set-lan", "text:" + txtAlert + "");
            SetLan(localStorage.getItem('Language'));
            $('#modalAlert').modal('show');
            $("#myModalLoad").modal('hide');

            if (txtAlert == "Add new line token success.") {
                setTimeout(function () { window.location.href = "../Menu_Announcement/LineToken.aspx"; }, 1500);
            }
            else {
                setTimeout(function () { $('#modalAlert').modal('hide') }, 2000);
            }
        }

        function alertModalDuplicate(txtAlert) {
            document.getElementById("lbAlert").setAttribute("set-lan", "text:" + txtAlert + "");
            SetLan(localStorage.getItem('Language'));
            $('#modalAlert').modal('show');
            $("#myModalLoad").modal('hide');
        }
    </script>
</asp:Content>

