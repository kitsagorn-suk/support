<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LineToken.aspx.cs" Inherits="Support_Project.Menu_Announcement.LineToken" %>

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

        .overflowTable {
            margin: 0px !important;
            width: 18em;
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
            left: 148px;
            z-index: 9;
        }

        select {
            display: block !important;
        }
    </style>
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="" set-lan="text:Announcement"></a></li>
            <li class="breadcrumb-item active txtMem" set-lan="text:Line Token"></li>
        </ol>
    </nav>
    <div class="row">
        <div class="col-md-8">
            <h1 set-lan="text:Line Token"></h1>
        </div>
    </div>
     <div class="btn-toolbar section-group" role="toolbar" style="padding-left: 1.5rem;">
        <div class="row">
            <label for="email" class="col-form-label" set-lan="text:Search_"></label>
            <div style="padding-left: 1rem;">
                <asp:TextBox ID="searchName" class="form-control" autocomplete="off" runat="server" MaxLength="100" set-lan="placeholder:Name Group" />
            </div>
        </div>
        <div class="row" style="padding-left: 2.5rem;">
            <button class="btn btn-yellow font-weight-bold m-0 px-3 py-2 z-depth-0 waves-effect btnMenu" type="button" onclick="Search_Click('')" set-lan="text:Search"></button>
        </div>
    </div>
    <div id="wrapper">
        <section>
            <div class="data-container"></div>
            <div id="pagination-demo2"></div>
        </section>
    </div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="Search_click" autopostback="false" Style="display: none;" />
            <div class="table-wrapper" style="margin-top: 1rem; margin-bottom: 1rem;">
                <table class="table table-border" id="tbData">
                    <thead class="rgba-green-slight">
                        <tr>
                            <th style="width: 5%;" set-lan="text:No"></th>
                            <th style="width: 20%;" set-lan="text:Name Group"></th>
                            <th style="width: 20%;" set-lan="text:Token"></th>
                            <th style="width: 20%;" set-lan="text:Create date"></th>
                            <th style="width: 20%;" set-lan="text:Create by"></th>
                            <th style="width: 15%;" set-lan="text:Actions"></th>
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
                        </tr>
                    </tfoot>
                </table>
            </div>
                        <asp:Button ID="btnEditLineToken" class="btn btn-lg btn-yellow font-weight-bold btn-block" OnClick="EditLineToken_click" runat="server" Text="Add" Style="display: none;" />
            <asp:Button ID="btnDelete" runat="server" Text="Search" OnClick="DeleteLineToken_click" autopostback="false" Style="display: none;" />
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
    <div class="modal fade" id="modalDeleteLinetoken" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold" set-lan="text:Delete Line Token"></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-3 text-center">
                    <label set-lan="text:Confirm delete this item ?"></label>
                </div>
                <div class="modal-footer d-flex justify-content-center">
                    <button class="btn btn-yellow font-weight-bold" onclick="DeleteLineToken()" type="button" set-lan="text:OK"></button>
                    <button type="button" class="btn btn-yellow font-weight-bold" data-dismiss="modal" aria-label="Close" set-lan="text:Close"></button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="modalAddLinetoken" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold" id="txtModal" set-lan="text:Edit Line Token"></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-3 text-center">
                    <div class="form-group row">
                        <label for="username" class="col-4 col-form-label" style="text-align: right;" set-lan="html:NameGroup__"></label>
                        <div class="col-8">
                            <asp:TextBox ID="NameGroup" class="form-control" autocomplete="off" runat="server" MaxLength="255" />
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="username" class="col-4 col-form-label" style="text-align: right;" set-lan="html:Token__"></label>
                        <div class="col-8">
                            <asp:TextBox ID="Token" class="form-control" autocomplete="off" runat="server" MaxLength="100" />
                        </div>
                    </div>
                </div>
                <div class="modal-footer d-flex justify-content-center">
                    <button id="bEdit" class="btn btn-yellow font-weight-bold" onclick="EditLineToken()" type="button" set-lan="text:Save"></button>
                    <button type="button" class="btn btn-yellow font-weight-bold" data-dismiss="modal" aria-label="Close" set-lan="text:Close"></button>
                </div>
            </div>
        </div>
    </div>
    <asp:HiddenField ID="thisPage" runat="Server"></asp:HiddenField>
     <asp:HiddenField ID="totalDocs" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="eventPaging" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="IDDelete" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="IDEdit" runat="Server"></asp:HiddenField>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainScript" runat="server">
    <script src="../js/pagination.js"></script>
    <script>
        $(document).ready(function () {
            $("#myModalLoad").modal();
            $("#menuAnnouncement , #menuAnnouncement > a , #menuLineToken > a").addClass("active");
            $("#menuAnnouncement > div").css("display", "block");

            SetLan(localStorage.getItem('Language'));
            GetData("");
        });

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
            if (event == "") {
                $("#myModalLoad").modal();
                $("#<%=thisPage.ClientID%>").val("1");
            }

            $("#<%=eventPaging.ClientID%>").val(event);
            $("#<%=btnSearch.ClientID%>").click();
        }

        function setDataLanguage() {
            SetLan(localStorage.getItem('Language'));
            $('#myModalLoad').modal('hide');
        }

        function alertModal(txtAlert) {
            document.getElementById("lbAlert").setAttribute("set-lan", "text:" + txtAlert + "");
            SetLan(localStorage.getItem('Language'));
            $('#modalAlert').modal('show');
            $("#myModalLoad, #modalAddLinetoken, #modalDeleteLinetoken").modal('hide');
            setTimeout(function () { $('#modalAlert').modal('hide') }, 2000);
        }

        var id_Delete = "";
        function viewDelete(idItem) {
            id_Delete = idItem;
            $('#modalDeleteLinetoken').modal();
        }

        function DeleteLineToken() {
            $("#myModalLoad").modal();
            $("#<%=IDDelete.ClientID%>").val(id_Delete);
                $("#<%=btnDelete.ClientID%>").click();
        }

        var id_Edit = "";
        function viewEdit(eleView) {
            id_Edit = eleView.getAttribute("attr-id");
            $("#<%=IDEdit.ClientID%>").val(id_Edit);
            $('#<%=NameGroup.ClientID%>').val(eleView.getAttribute("attr-name"));
            $('#<%=Token.ClientID%>').val(eleView.getAttribute("attr-token"));
            SetLan(localStorage.getItem('Language'));
            $('#modalAddLinetoken').modal();
        }

        function EditLineToken() {
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
                $("#<%=btnEditLineToken.ClientID%>").click();
            }
            SetLan(localStorage.getItem("Language"));
    }
    </script>
</asp:Content>

