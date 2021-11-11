<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MyOpenTask.aspx.cs" Inherits="Support_Project.Menu_Profile.MyOpenTask" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
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


        .fa-eye-slash:before, .fa-eye:before {
            content: '\f06e' !important;
            background: none !important;
        }

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

        .iconTime {
            position: absolute;
            top: 12px;
            left: 121px;
            z-index: 9;
        }

        .trRed > td {
            background-color: #ffcfcf;
        }

        .trYellow > td {
            background-color: #ffe695;
        }
    </style>
    <div class="row">
        <div class="col-md-8">
            <h1>My open task</h1>
        </div>
    </div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="Search_click" autopostback="false" Style="display: none;" />
            <div class="table-wrapper" style="margin-top: 1rem; margin-bottom: 1rem;">
                <table class="table table-border" id="tbData">
                    <thead class="rgba-green-slight">
                        <tr>
                            <th style="width: 3%;">No</th>
                            <th style="width: 4%;">Level</th>
                            <th style="width: 6%;">Ticket ID</th>
                            <th style="width: 5%;">Status</th>
                            <th style="width: 7%;">Product</th>
                            <th style="">Agent / Prefix</th>
                            <th style="width: 6%;">Categories</th>
                            <th style="width: 10%;">Created by</th>
                            <th style="width: 10%;">Pick up / Action by</th>
                            <th style="width: 11%;">Average end date</th>
                            <th style="width: 4%;">Desc</th>
                            <th style="width: 9%;">Attached files</th>
                            <th style="width: 5%;">Acknowledge</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Literal ID="LiteralDataAllNotification" runat="server"></asp:Literal>
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
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                    </tfoot>
                </table>
            </div>
            <asp:Button ID="btnCloseDashboard" class="btn btn-lg btn-yellow font-weight-bold btn-block" OnClick="CloseDashboard_click" runat="server" Text="Add" Style="display: none;" AutoPostBack="false" />
            <asp:Button ID="btnCommentDashboard" class="btn btn-lg btn-yellow font-weight-bold btn-block" OnClick="CommentDashboard_click" runat="server" Text="Add" Style="display: none;" AutoPostBack="false" />
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
    <div class="modal fade" id="modalGetDesc" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold">Description</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-4 text-center">
                    <div class="form-group row">
                        <label for="username" class="col-4 col-form-label" style="text-align: right;">
                            Website link (Troubled) :</label>
                        <div class="col-8">
                            <asp:TextBox ID="WebsiteView" class="form-control" autocomplete="off" runat="server" MaxLength="255" disabled="disabled" />
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="username" class="col-4 col-form-label" style="text-align: right;">
                            Username (Troubled) :</label>
                        <div class="col-8">
                            <asp:TextBox ID="UsernameView" class="form-control" autocomplete="off" runat="server" MaxLength="255" disabled="disabled" />
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="username" class="col-4 col-form-label" style="text-align: right;">
                            Password (Troubled) :</label>
                        <div class="col-8">
                            <asp:TextBox ID="PasswordView" class="form-control" autocomplete="off" runat="server" MaxLength="255" disabled="disabled" />
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="username" class="col-4 col-form-label" style="text-align: right;">
                            Problem :</label>
                        <div class="col-8">
                            <asp:TextBox runat="server" ID="ProblemView" TextMode="MultiLine" Rows="2" class="form-control" autocomplete="off" MaxLength="255" readonly />
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="username" class="col-4 col-form-label" style="text-align: right;">
                            Troubleshooting :</label>
                        <div class="col-8">
                            <asp:TextBox runat="server" ID="TroubleshootingView" TextMode="MultiLine" Rows="2" class="form-control" autocomplete="off" MaxLength="255" readonly />
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="username" class="col-4 col-form-label" style="text-align: right;">
                            After first fixed :</label>
                        <div class="col-8">
                            <asp:TextBox runat="server" ID="AfterfirstfixedView" TextMode="MultiLine" Rows="2" class="form-control" autocomplete="off" MaxLength="255" readonly />
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="username" class="col-4 col-form-label" style="text-align: right;">
                            Other :</label>
                        <div class="col-8">
                            <asp:TextBox runat="server" ID="OtherView" TextMode="MultiLine" Rows="2" class="form-control" autocomplete="off" MaxLength="255" readonly />
                        </div>
                    </div>
                     <div class="form-group row">
                        <label for="username" class="col-4 col-form-label" style="text-align: right;">
                            Comment :</label>
                        <div class="col-8">
                            <asp:TextBox runat="server" ID="CommentView" TextMode="MultiLine" Rows="5" class="form-control" autocomplete="off" MaxLength="200" readonly />
                        </div>
                    </div>
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
                    <h4 class="modal-title w-100 font-weight-bold">Attach File</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-3 text-center" id="imgShow">
                    <%-- <img src="../img/excel_logo.png" id="imgShow" style="max-width: 100%; height: auto!important;" />--%>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="modalAlertClose" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-3 text-center">
                    <label>Confirm acknowledge your task ?</label>
                </div>
                <div class="modal-footer d-flex justify-content-center">
                    <button class="btn btn-yellow font-weight-bold" onclick="SaveCloseDashboard()" type="button" set-lan="text:OK"></button>
                    <button type="button" class="btn btn-yellow font-weight-bold" data-dismiss="modal" aria-label="Close" set-lan="text:Close"></button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="modalAlertComment" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-3 text-center">
                    <label>Confirm acknowledge your task ?</label>
                </div>
                <div class="modal-footer d-flex justify-content-center">
                    <button class="btn btn-yellow font-weight-bold" onclick="SaveCommentDashboard()" type="button" set-lan="text:OK"></button>
                    <button type="button" class="btn btn-yellow font-weight-bold" data-dismiss="modal" aria-label="Close" set-lan="text:Close"></button>
                </div>
            </div>
        </div>
    </div>
    <asp:HiddenField ID="closeID" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="commentID" runat="Server"></asp:HiddenField>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainScript" runat="server">
    <script src="../js/moment.min.js"></script>
    <script src="../js/pagination.js"></script>
    <script>
        var token = "";
        $(document).ready(function () {
            setInterval(function () { Search_Click(); }, 60 * 1000);
        });

        function Search_Click(event) {
            $("#myModalLoad").modal();
            $("#<%=btnSearch.ClientID%>").click();
        }

        function alertModal(txtAlert) {
            document.getElementById("lbAlert").setAttribute("set-lan", "text:" + txtAlert + "");
            SetLan(localStorage.getItem('Language'));
            $('#modalAlert').modal('show');
            $("#myModalLoad, #modalAlertClose, #modalAlertComment").modal('hide');
            getNoti();
            setTimeout(function () { $('#modalAlert').modal('hide') }, 2000);
        }

        function getDesc(text, text2, text3, text4, text5, text6, text7, text8) {
            text4 = text4.split('<br/>').join('\r\n');
            text5 = text5.split('<br/>').join('\r\n');
            text6 = text6.split('<br/>').join('\r\n');
            text7 = text7.split('<br/>').join('\r\n');
            text8 = text8.split('<br/>').join('\r\n');
            $('#<%=WebsiteView.ClientID%>').val(text);
            $('#<%=UsernameView.ClientID%>').val(text2);
            $('#<%=PasswordView.ClientID%>').val(text3);
            $('#<%=ProblemView.ClientID%>').val(text4);
            $('#<%=TroubleshootingView.ClientID%>').val(text5);
            $('#<%=AfterfirstfixedView.ClientID%>').val(text6);
            $('#<%=OtherView.ClientID%>').val(text7);
            $('#<%=CommentView.ClientID%>').val(text8);
            $('#modalGetDesc').modal();
        }

        function getImage(name) {
            $("#imgShow").html("");
            var htmlFile = "";
            var arrFile = name.split(',');;
            for (var i = 0; i < arrFile.length; i++) {
                if (name != "") {
                    htmlFile += "<img src='../FileAttach/" + arrFile[i] + "' style='max-width: 100%; height: auto!important; padding-bottom: 1rem;' />";
                }
            }

            if (name == "") {
                htmlFile += "<img src='../img/noImage.jpg' style='max-width: 100%; height: auto!important;' />";
            }

            $("#imgShow").append(htmlFile);
            $("#modalImage").modal();
        }

        function getClose(id) {
            $("#<%=closeID.ClientID%>").val(id);
            $("#modalAlertClose").modal();
        }

        function getComment(id) {
            $("#<%=commentID.ClientID%>").val(id);
            $("#modalAlertComment").modal();
        }

        function SaveCloseDashboard() {
            $("#myModalLoad").modal();
            $("#<%=btnCloseDashboard.ClientID%>").click();
        }

        function SaveCommentDashboard() {
            $("#myModalLoad").modal();
            $("#<%=btnCommentDashboard.ClientID%>").click();
        }
    </script>
</asp:Content>

