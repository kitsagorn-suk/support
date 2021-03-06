<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Company.aspx.cs" Inherits="Support_Project.Menu_Management_Main.Company" %>

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
            left: 148px;
            z-index: 9;
        }

        select {
            display: block !important;
        }
    </style>
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="" set-lan="text:Management"></a></li>
            <li class="breadcrumb-item active txtMem" set-lan="text:Company List"></li>
        </ol>
    </nav>
    <div class="row">
        <div class="col-md-8">
            <h1 set-lan="text:Company List"></h1>
        </div>
        <div class="col-md-4" style="text-align: right; display: none;">
            <a class="btn btn-primary btnAdd" onclick="addCompany()" style="color: #2F80ED !important;" set-lan="html:Add"></a>
        </div>
    </div>
    <div class="btn-toolbar section-group" role="toolbar" style="padding-left: 1.5rem;">
        <div class="row">
            <label for="email" class="col-form-label" set-lan="text:Search_"></label>
            <div style="padding-left: 1rem;">
                <asp:TextBox ID="searchName" class="form-control" autocomplete="off" runat="server" set-lan="placeholder:Name / Prefix" />
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
                            <th style="width: 10%;" set-lan="text:Name"></th>
                            <th style="width: 10%;" set-lan="text:Prefix"></th>
                            <th style="width: 10%;" set-lan="text:Description"></th>
                            <th style="width: 10%;" set-lan="text:Remark"></th>
                            <th style="width: 10%;" set-lan="text:Create date"></th>
                            <th style="width: 10%;" set-lan="text:Create by"></th>
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
                        </tr>
                    </tfoot>
                </table>
            </div>
            <asp:Button ID="btnEditCompany" class="btn btn-lg btn-yellow font-weight-bold btn-block" OnClick="EditCompany_click" runat="server" Text="Add" Style="display: none;" />
            <asp:Button ID="btnDelete" runat="server" Text="Search" OnClick="DeleteCompany_click" autopostback="false" Style="display: none;" />
        </ContentTemplate>
    </asp:UpdatePanel>
    <!-- Modal -->
    <div class="modal fade" id="modalAddCompany" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold" id="txtModal" set-lan="text:Edit Company"></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-3 text-center">
                    <div class="form-group row">
                        <label for="username" class="col-4 col-form-label" style="text-align: right;" set-lan="html:Name__"></label>
                        <div class="col-8">
                            <asp:TextBox ID="Name" class="form-control" autocomplete="off" runat="server" MaxLength="255" />
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="username" class="col-4 col-form-label" style="text-align: right;" set-lan="html:Prefix__"></label>
                        <div class="col-8">
                            <asp:TextBox ID="Prefix" class="form-control" autocomplete="off" runat="server" MaxLength="255" />
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="username" class="col-4 col-form-label" style="text-align: right;" set-lan="text:Description_"></label>
                        <div class="col-8">
                            <asp:TextBox runat="server" ID="Description" TextMode="MultiLine" Rows="2" class="form-control" autocomplete="off" MaxLength="255" onkeypress="return maxLengthfield(this,255);" />
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="username" class="col-4 col-form-label" style="text-align: right;" set-lan="text:Remark_"></label>
                        <div class="col-8">
                            <asp:TextBox runat="server" ID="Remark" TextMode="MultiLine" Rows="2" class="form-control" autocomplete="off" MaxLength="255" onkeypress="return maxLengthfield(this,255);" />
                        </div>
                    </div>
                </div>
                <div class="modal-footer d-flex justify-content-center">
                    <button id="bEdit" class="btn btn-yellow font-weight-bold" onclick="EditCompany()" type="button" set-lan="text:Save" style="display: none;"></button>
                    <button type="button" class="btn btn-yellow font-weight-bold" data-dismiss="modal" aria-label="Close" set-lan="text:Close"></button>
                </div>
            </div>
        </div>
    </div>
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
    <div class="modal fade" id="modalDeleteCompany" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold" set-lan="text:Delete Company"></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-3 text-center">
                    <label set-lan="text:Confirm delete this item ?"></label>
                </div>
                <div class="modal-footer d-flex justify-content-center">
                    <button class="btn btn-yellow font-weight-bold" onclick="DeleteCompany()" type="button" set-lan="text:OK"></button>
                    <button type="button" class="btn btn-yellow font-weight-bold" data-dismiss="modal" aria-label="Close" set-lan="text:Close"></button>
                </div>
            </div>
        </div>
    </div>
    <asp:HiddenField ID="LevelSearch" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="LevelAdd" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="LevelEdit" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="AgentSearch" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="CompanySearch" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="AgentAdd" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="CompanyAdd" runat="Server"></asp:HiddenField>
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainScript" runat="server">
    <script src="../js/moment.min.js"></script>
    <script src="../js/pagination.js"></script>
    <script>
        var token = "";
        var TotalData;
        $(document).ready(function () {
            //$("#myModalLoad").modal();
            $("#menuManagementMain , #menuManagementMain > a , #menuManagementShare > a").addClass("active");
            $("#menuManagementMain > div").css("display", "block");

            <%--            if ($('#<%=IDRole.ClientID%>').val() != "Master" && $('#<%=IDRole.ClientID%>').val() != "Super User") {
                $(".btnAdd, .fillPass, #tbData > thead > tr > th:nth-child(11), #tbData > tbody > tr > td:nth-child(11), #tbData > tfoot > tr > td:nth-child(11)").remove();
            }--%>

            <%--if ($('#<%=IDAgent.ClientID%>').val() != "0") {
                $(".zoneAgent").css("display", "none");
                $("#tbData > thead > tr > th:nth-child(6), #tbData > tbody > tr > td:nth-child(6), #tbData > tfoot > tr > td:nth-child(6)").remove();
            }--%>

            $("option[value='']").attr("disabled", "disabled");

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

        function alertModalDuplicate(txtAlert) {
            document.getElementById("lbAlert").setAttribute("set-lan", "text:" + txtAlert + "");
            SetLan(localStorage.getItem('Language'));
            $('#modalAlert').modal('show');
            $("#myModalLoad").modal('hide');
        }

        function GetData(count) {
            var NumPage = 1;
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

        function GetNumPage(numPage) {
            $(function () {
                (function (name) {
                    var container = $('#pagination-' + name);
                    container.pagination({
                        totalNumber: TotalData,
                        pageNumber: numPage,
                        pageSize: 100,
                        dataSource: 'https://api.flickr.com/services/feeds/photos_public.gne?tags=cat&tagmode=any&format=json&jsoncallback=?',
                        locator: 'items',
                       <%-- callback: function (response, pagination) {
                            var NumPage = container.pagination('getSelectedPageNum');
                            $("#<%=thisPage.ClientID%>").val(NumPage);
                            Search_Click("paging");
                        },--%>
                        beforePageOnClick: function (response, pagination) {
                            NumPage = pagination;
                            $("#<%=thisPage.ClientID%>").val(NumPage);
                        },
                        afterPageOnClick: function (response, pagination) {
                            Search_Click("paging");
                        },

                        beforeNextOnClick: function (response, pagination) {
                            NumPage = pagination;
                            $("#<%=thisPage.ClientID%>").val(NumPage);
                        },
                        afterNextOnClick: function (response, pagination) {
                            Search_Click("paging");
                        },

                        beforePreviousOnClick: function (response, pagination) {
                            NumPage = pagination;
                            $("#<%=thisPage.ClientID%>").val(NumPage);
                        },
                        afterPreviousOnClick: function (response, pagination) {
                            Search_Click("paging");
                        },
                    });
                })('demo2');
            });
        }

        function addCompany() {
            $("#bAdd").css("display", "flex");
            $("#txtModal").text("Add Company");
            $("#zoneStatus, #bEdit").css("display", "none");
            $('#<%=Name.ClientID%>,#<%=Prefix.ClientID%>,#<%=Description.ClientID%>,#<%=Remark.ClientID%>').val("");
            $('#modalAddCompany').modal();
        }

        function getAddModal() {
            $(".inModal > select > option[value='']").attr("disabled", "disabled");
            $('#modalAddCompany').modal();
        }

        function Search_Click(event) {
            if (event == "") {
                $("#myModalLoad").modal();
                $("#<%=thisPage.ClientID%>").val("1");
            }

            $("#<%=eventPaging.ClientID%>").val(event);
            $("#<%=btnSearch.ClientID%>").click();
        }

        var id_Edit = "";
        function viewEdit(eleView) {
            //$("#txtModal").text("Edit Company");
            $("#zoneStatus, #bEdit").css("display", "flex");
            $("#bAdd").css("display", "none");
            id_Edit = eleView.getAttribute("attr-id");
            $("#<%=IDEdit.ClientID%>").val(id_Edit);
            $('#<%=Name.ClientID%>').val(eleView.getAttribute("attr-name"));
            $('#<%=Prefix.ClientID%>').val(eleView.getAttribute("attr-prefix"));
            $('#<%=Description.ClientID%>').val(eleView.getAttribute("attr-desc"));
            $('#<%=Remark.ClientID%>').val(eleView.getAttribute("attr-remark"));
            SetLan(localStorage.getItem('Language'));

            $('#modalAddCompany').modal();
        }

        function EditCompany() {
            $("#myModalLoad").modal();
            if ($('#<%=Name.ClientID%>').val() == "") {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:missing 'Name' field");
                SetLan(localStorage.getItem("Language"));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else if ($('#<%=Prefix.ClientID%>').val() == "") {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:missing 'Prefix' field");
                SetLan(localStorage.getItem('Language'));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else {
                $("#<%=btnEditCompany.ClientID%>").click();
            }
            SetLan(localStorage.getItem("Language"));
    }

    function alertModal(txtAlert) {
        document.getElementById("lbAlert").setAttribute("set-lan", "text:" + txtAlert + "");
        SetLan(localStorage.getItem('Language'));
        $('#modalAlert').modal('show');
        $("#myModalLoad, #modalAddCompany, #modalDeleteCompany").modal('hide');
        setTimeout(function () { $('#modalAlert').modal('hide') }, 2000);
    }

    function getDelete(idItem) {
        var dataAdd = new Object();
        dataAdd.pShareHolderID = parseInt(idItem);
        $.ajax({
            url: '../WebService.asmx/GetCancelCompany',
            method: 'post',
            data: JSON.stringify(dataAdd),
            contentType: "application/json; charset=utf-8",
            success: function (data) {
                if (data.d == "0") {
                    viewDelete(idItem);
                }
                else {
                    alertModal("Cann't delete this item because it is in use.");
                }
            },
            error: function (err) {
                document.getElementById('lbAlert').innerHTML = "Error : GetNotification";
                $("#myModalLoad").modal('hide');
                $('#modalAlert').modal('show');
            }
        });
    }

    var id_Delete = "";
    function viewDelete(idItem) {
        id_Delete = idItem;
        $('#modalDeleteCompany').modal();
    }

    function DeleteCompany() {
        $("#myModalLoad").modal();
        $("#<%=IDDelete.ClientID%>").val(id_Delete);
            $("#<%=btnDelete.ClientID%>").click();
    }

        function setDataLanguage() {
            SetLan(localStorage.getItem('Language'));
            $('#myModalLoad').modal('hide');
        }
    </script>
</asp:Content>
