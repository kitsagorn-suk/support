<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Member.aspx.cs" Inherits="Support_Project.Menu_Management_Main.Member" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
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
            width: 8.5em;
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
            <li class="breadcrumb-item active txtMem" set-lan="text:Account List"></li>
        </ol>
    </nav>
    <div class="row">
        <div class="col-md-8">
            <h1 set-lan="text:Account List"></h1>
        </div>
    </div>
    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
        <ContentTemplate>
            <div class="btn-toolbar section-group" role="toolbar" style="padding-left: 1.5rem;">
                <div class="row">
                    <label for="email" class="col-form-label" set-lan="text:Search_"></label>
                    <div style="padding-left: 1rem;">
                        <asp:TextBox ID="searchUsername" class="form-control" autocomplete="off" runat="server" set-lan="placeholder:Name / Prefix" Style="width: 136px;" />
                    </div>
                </div>
                <div class="row" style="padding-left: 2.5rem;">
                    <label for="email" class="col-form-label alignright" set-lan="text:Level_"></label>
                    <div style="padding-left: 1rem;" class="select-outline">
                        <asp:DropDownList ID="ddllevelSearch" runat="server" class="form-control" DataValueField="id" DataTextField="name">
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="row zoneSearchCom" style="padding-left: 2.5rem;">
                    <label for="email" class="col-form-label alignright" set-lan="text:Company_"></label>
                    <div style="padding-left: 1rem;" class="select-outline">
                        <asp:DropDownList ID="ddlCompanySearch" runat="server" class="form-control" DataValueField="id" DataTextField="name" AutoPostBack="true" OnSelectedIndexChanged="getDropdownAgentSearch">
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="row zoneSearchAgent" style="padding-left: 2.5rem;">
                    <label for="email" class="col-form-label alignright" set-lan="text:Agent_"></label>
                    <div style="padding-left: 1rem;" class="select-outline">
                        <asp:DropDownList ID="ddlAgentSearch" runat="server" class="form-control" DataValueField="id" DataTextField="name">
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="row" style="padding-left: 2.5rem;">
                    <button class="btn btn-yellow font-weight-bold m-0 px-3 py-2 z-depth-0 waves-effect btnMenu" type="button" onclick="Search_Click('')" set-lan="text:Search"></button>
                </div>
            </div>
            <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="Search_click" autopostback="false" Style="display: none;" />
        </ContentTemplate>
    </asp:UpdatePanel>
     <div class="row" style="margin-top: 1rem;">
        <div class="col-md-8">
            <div id="navMenu" style="color: #17172c; width: fit-content; padding: 5px; font-weight: bold; border-radius: .3rem; font-size: .9rem; padding-right: 10px !important;"></div>
        </div>
        <div class="col-md-4">
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
            <div class="table-wrapper" style="margin-top: 1rem; margin-bottom: 1rem;">
                <table class="table table-border" id="tbData">
                    <thead class="rgba-green-slight">
                        <tr>
                            <th style="width: 3%;" set-lan="text:No"></th>
                            <th style="width: 6%;" set-lan="text:Username"></th>
                            <th style="width: 6%;" set-lan="text:Name"></th>
                            <th style="width: 6%;" set-lan="text:Contact"></th>
                            <th style="width: 7%;" set-lan="text:Level"></th>
                            <th style="width: 10%;" set-lan="text:Company"></th>
                            <th style="width: 10%;" set-lan="text:Agent"></th>
                            <th style="width: 12%;" set-lan="text:Login Time"></th>
                            <th style="width: 12%;" set-lan="text:Created date"></th>
                            <th style="width: 7%;" set-lan="text:Status"></th>
                            <th style="width: 6%;" set-lan="text:Actions"></th>
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
                            <td></td>
                        </tr>
                    </tfoot>
                </table>
            </div>
            <asp:Button ID="btnEditMember" class="btn btn-lg btn-yellow font-weight-bold btn-block" OnClick="EditMember_click" runat="server" Text="Add" Style="display: none;" />
            <asp:Button ID="btnDelete" runat="server" Text="Search" OnClick="DeleteMember_click" autopostback="false" Style="display: none;" />
            <asp:Button ID="btnReQR" runat="server" Text="Search" OnClick="ReQR_click" autopostback="false" Style="display: none;" />
            <asp:Button ID="btnGetddlCompany" class="btn btn-lg btn-yellow font-weight-bold btn-block" OnClick="GetSharholder_click" runat="server" Text="Add" Style="display: none;" />
            <asp:Button ID="btnGetddlAgentAdd" class="btn btn-lg btn-yellow font-weight-bold btn-block" OnClick="getDropdownAgent" runat="server" Text="Add" Style="display: none;" />
        </ContentTemplate>
    </asp:UpdatePanel>
    <!-- Modal -->
    <div class="modal fade" id="modalAddMember" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold" id="txtModal" set-lan="text:Edit Account"></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-3 text-center">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <div class="form-group row">
                                <label for="username" class="col-4 col-form-label" style="text-align: right;" set-lan="html:Username__"></label>
                                <div class="col-8">
                                    <asp:TextBox ID="username" class="form-control" autocomplete="off" runat="server" MaxLength="30" />
                                </div>
                            </div>
                            <div class="form-group row fillPass">
                                <label for="username" class="col-4 col-form-label" style="text-align: right" set-lan="html:Password__"></label>
                                <div class="col-8">
                                    <asp:TextBox ID="password" class="form-control" autocomplete="off" runat="server" MaxLength="24" type="password" />
                                    <span toggle="#password" class="toggle-password field-icon" onclick="showPass();"><i class="far fa-eye-slash"></i></span>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="username" class="col-4 col-form-label" style="text-align: right;" set-lan="html:Name__"></label>
                                <div class="col-8">
                                    <asp:TextBox ID="name" class="form-control" autocomplete="off" runat="server" MaxLength="250" />
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="username" class="col-4 col-form-label" style="text-align: right;" set-lan="text:Contact_"></label>
                                <div class="col-8">
                                    <asp:TextBox ID="contact" class="form-control" autocomplete="off" runat="server" MaxLength="150" />
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="username" class="col-4 col-form-label" style="text-align: right;" set-lan="html:Level__"></label>
                                <div class="col-8 inModal">
                                    <asp:DropDownList ID="ddlLevel" runat="server" class="form-control" DataValueField="id" DataTextField="name" AutoPostBack="false">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="username" class="col-4 col-form-label" style="text-align: right;" set-lan="html:Company__"></label>
                                <div class="col-8 inModal">
                                    <asp:DropDownList ID="ddlCompany" runat="server" class="form-control" DataValueField="id" DataTextField="name" AutoPostBack="true" OnSelectedIndexChanged="getDropdownAgent">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="username" class="col-4 col-form-label" style="text-align: right;" set-lan="html:Agent__"></label>
                                <div class="col-8 inModal">
                                    <asp:DropDownList ID="ddlAgent" runat="server" class="form-control" DataValueField="id" DataTextField="name">
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <div class="form-group row" id="zoneStatus">
                        <label for="username" class="col-4 col-form-label" style="text-align: right;" set-lan="text:Status_"></label>
                        <div class="col-8">
                            <asp:DropDownList ID="ddlStatus" class="form-control" runat="server">
                                <asp:ListItem Value="1">Active</asp:ListItem>
                                <asp:ListItem Value="0">Inactive</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
                <div class="modal-footer d-flex justify-content-center">
                    <button id="bAdd" class="btn btn-yellow font-weight-bold" onclick="SaveMember()" type="button" set-lan="text:Save" style="display: none;"></button>
                    <button id="bEdit" class="btn btn-yellow font-weight-bold" onclick="EditMember()" type="button" set-lan="text:Save" style="display: none;"></button>
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
    <div class="modal fade" id="modalDeleteMember" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold" set-lan="text:Delete Account"></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-3 text-center">
                    <label set-lan="text:Confirm delete this item ?"></label>
                </div>
                <div class="modal-footer d-flex justify-content-center">
                    <button class="btn btn-yellow font-weight-bold" onclick="DeleteMember()" type="button" set-lan="text:OK"></button>
                    <button type="button" class="btn btn-yellow font-weight-bold" data-dismiss="modal" aria-label="Close" set-lan="text:Close"></button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="modalReQR" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold" set-lan="text:Reset QR"></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-3 text-center">
                    <label set-lan="text:Confirm reset QR this item ?"></label>
                </div>
                <div class="modal-footer d-flex justify-content-center">
                    <button class="btn btn-yellow font-weight-bold" onclick="ReQR()" type="button" set-lan="text:OK"></button>
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
    <asp:HiddenField ID="CompanyEdit" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="AgentEdit" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="StatusEdit" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="IDDelete" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="IDReQR" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="IDEdit" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="IDRole" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="IDAgent" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="IDCompany" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="CompanyView" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="AgentView" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="thisPage" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="totalDocs" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="eventPaging" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="ShareIDLogin" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="AgentIDLogin" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="MemberIDSearch" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="AgentIDSearch" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="MemberName" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="getParent" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="MemberSearch" runat="Server"></asp:HiddenField>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainScript" runat="server">
    <script src="../js/moment.min.js"></script>
    <script src="../js/pagination.js"></script>
    <script>
        var token = "";
        var TotalData;
        var NumPage;
        var arrGetMemberParentID = [];
        var arrGetMemberParentName = [];
        var arrGetAgentParentID = [];
        $(document).ready(function () {
            //$("#myModalLoad").modal();
            $("#menuManagementMain , #menuManagementMain > a , #menuManagementMember > a").addClass("active");
            $("#menuManagementMain > div").css("display", "block");
            $(".inModal > select > option[value='']").attr("disabled", "disabled");

            $("input[type=date]").on("change", function () {
                this.setAttribute(
                    "data-date",
                    moment(this.value, "YYYY-MM-DD")
                    .format(this.getAttribute("data-date-format"))
                )
            }).trigger("change")

            $("option[value='']").attr("disabled", "disabled");

            $("#navMenu").html("");
            var htmlMenu = "";
            htmlMenu += "<a class='link' onclick='getParentAgent(" + $("#<%=MemberIDSearch.ClientID%>").val() + " , \"" + $("#<%=MemberName.ClientID%>").val() + "\" , " + $("#<%=AgentIDSearch.ClientID%>").val() + ");'>" + $("#<%=MemberName.ClientID%>").val() + "</a>";
            $("#navMenu").append(htmlMenu);
            $("#navMenu > a:last-child").css("text-decoration", "underline");
            arrGetMemberParentID.push(parseInt($("#<%=MemberIDSearch.ClientID%>").val()));
            arrGetMemberParentName.push($("#<%=MemberName.ClientID%>").val());
            arrGetAgentParentID.push(parseInt($("#<%=AgentIDSearch.ClientID%>").val()));

            SetLan(localStorage.getItem('Language'));
            GetData("");
        });

        function setDataLanguage() {
            SetLan(localStorage.getItem('Language'));
            $('#myModalLoad').modal('hide');
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

            console.log(TotalData)
            GetNumPage(NumPage);
        }

        function GetNumPage(NumPage) {
            $(function () {
                (function (name) {
                    var container = $('#pagination-' + name);
                    container.pagination({
                        totalNumber: TotalData,
                        pageNumber: NumPage,
                        pageSize: 50,
                        dataSource: 'https://api.flickr.com/services/feeds/photos_public.gne?tags=cat&tagmode=any&format=json&jsoncallback=?',
                        locator: 'items',
                        <%--callback: function (response, pagination) {
                            NumPage = container.pagination('getSelectedPageNum');
                            $("#<%=thisPage.ClientID%>").val(NumPage);
                            $("#myModalLoad").modal("hide");
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

        function showPass() {
            var x = document.getElementById("<%=password.ClientID%>");
            if (x.type === "password") {
                x.type = "text";
            } else {
                x.type = "password";
            }
        }

        function getAddModal() {
            $(".inModal > select > option[value='']").attr("disabled", "disabled");
            $('#modalAddMember').modal();
        }

        function alertModalDuplicate(txtAlert) {
            document.getElementById("lbAlert").setAttribute("set-lan", "text:" + txtAlert + "");
            SetLan(localStorage.getItem('Language'));

            if ($("#<%=AgentIDLogin.ClientID%>").val() != "0" && $("#<%=AgentIDLogin.ClientID%>").val() != "1") {
                $(".zoneSearchCom, .zoneSearchAgent, .zoneCompany, .zoneAgent").css("display", "none");
            }
            else {
                if ($("#<%=IDRole.ClientID%>").val() != "Super User" && $("#<%=IDRole.ClientID%>").val() != "Master") {
                    $(".zoneSearchCom, .zoneSearchAgent, .zoneCompany, .zoneAgent").css("display", "none");
                }
            }

            $('#modalAlert').modal('show');
            $("#myModalLoad").modal('hide');
        }

        function Search_Click(event) {
            $("#myModalLoad").modal();
            if (event == "") {
                $("#<%=thisPage.ClientID%>").val("1");
                $("#<%=getParent.ClientID%>").val("No");
                arrGetMemberParentID.length = 1;
                arrGetMemberParentName.length = 1;
                arrGetAgentParentID.length = 1;
                $("#navMenu").html("");
                var htmlMenu = "";
                for (var i = 0; i < arrGetMemberParentID.length; i++) {
                    if ((i + 1) == arrGetMemberParentID.length) {
                        htmlMenu += "<a class='link' onclick='getParentAgent(" + arrGetMemberParentID[i] + " , \"" + arrGetMemberParentName[i] + "\", " + arrGetAgentParentID[i] + ");'>" + arrGetMemberParentName[i] + "</a>";
                    }
                    else {
                        htmlMenu += "<a class='link' onclick='getParentAgent(" + arrGetMemberParentID[i] + " , \"" + arrGetMemberParentName[i] + "\", " + arrGetAgentParentID[i] + ");'>" + arrGetMemberParentName[i] + "</a> / ";
                    }
                }
                $("#navMenu").append(htmlMenu);
                $("#navMenu > a:last-child").css("text-decoration", "underline");
                $("#<%=CompanySearch.ClientID%>").val(document.getElementById("<%=ddlCompanySearch.ClientID%>").value);
                $("#<%=AgentIDSearch.ClientID%>").val(document.getElementById("<%=ddlAgentSearch.ClientID%>").value);
            }

            $("#<%=LevelSearch.ClientID%>").val(document.getElementById("<%=ddllevelSearch.ClientID%>").value);
            $("#<%=eventPaging.ClientID%>").val(event);
            $("#<%=btnSearch.ClientID%>").click();
        }

        function getParentAgent(eleID, name, agent) {
            $("#<%=searchUsername.ClientID%>").val("");
            $("#<%=thisPage.ClientID%>").val("1");
            $("#<%=eventPaging.ClientID%>").val("");
            $("#<%=getParent.ClientID%>").val("Yes");
            $("#<%=CompanySearch.ClientID%>").val(document.getElementById("<%=ddlCompanySearch.ClientID%>").value);
            $("#<%=MemberIDSearch.ClientID%>").val(eleID);
            $("#<%=AgentIDSearch.ClientID%>").val(agent);

            var index = arrGetMemberParentID.indexOf(eleID);
            if (index > -1) {
                arrGetMemberParentID.length = index + 1;
            }
            else {
                arrGetMemberParentID.push(eleID);
            }

            var index2 = arrGetMemberParentName.indexOf(name);
            if (index2 > -1) {
                arrGetMemberParentName.length = index2 + 1;
            }
            else {
                arrGetMemberParentName.push(name);
            }

            var index3 = arrGetAgentParentID.indexOf(agent);
            if (index3 > -1) {
                arrGetAgentParentID.length = index3 + 1;
            }
            else {
                arrGetAgentParentID.push(agent);
            }

            $("#myModalLoad").modal();

            $("#navMenu").html("");
            var htmlMenu = "";
            for (var i = 0; i < arrGetMemberParentID.length; i++) {
                if ((i + 1) == arrGetMemberParentID.length) {
                    htmlMenu += "<a class='link' onclick='getParentAgent(" + arrGetMemberParentID[i] + " , \"" + arrGetMemberParentName[i] + "\", " + arrGetAgentParentID[i] + ");'>" + arrGetMemberParentName[i] + "</a>";
                }
                else {
                    htmlMenu += "<a class='link' onclick='getParentAgent(" + arrGetMemberParentID[i] + " , \"" + arrGetMemberParentName[i] + "\", " + arrGetAgentParentID[i] + ");'>" + arrGetMemberParentName[i] + "</a> / ";
                }
            }
            $("#navMenu").append(htmlMenu);
            $("#navMenu > a:last-child").css("text-decoration", "underline");
            $("#<%=btnSearch.ClientID%>").click();
        }

        var id_Delete = "";
        function viewDelete(idItem) {
            id_Delete = idItem;
            $('#modalDeleteMember').modal();
        }

        var id_ReQR = "";
        function viewReQR(idItem) {
            id_ReQR = idItem;
            $('#modalReQR').modal();
        }

        function DeleteMember() {
            $("#myModalLoad").modal();
            $("#<%=IDDelete.ClientID%>").val(id_Delete);
            $("#<%=btnDelete.ClientID%>").click();
        }

        function ReQR() {
            $("#myModalLoad").modal();
            $("#<%=IDReQR.ClientID%>").val(id_ReQR);
            $("#<%=btnReQR.ClientID%>").click();
        }

        var id_Edit = "";
        var eleView;
        function viewEdit(ele) {
            eleView = ele;
            $("#<%=CompanyView.ClientID%>").val(ele.getAttribute("attr-share"));
            $("#<%=AgentView.ClientID%>").val(ele.getAttribute("attr-agent"));
            $("#<%=btnGetddlCompany.ClientID%>").click();
        }

        function getViewModal() {
            //$("#txtModal").text("Edit Account");
            $("#zoneStatus, #bEdit").css("display", "flex");
            $("#bAdd").css("display", "none");
            id_Edit = eleView.getAttribute("attr-id");
            $("#<%=IDEdit.ClientID%>").val(id_Edit);
            $('#<%=username.ClientID%>').val(eleView.getAttribute("attr-username"));
            $('#<%=password.ClientID%>').val(eleView.getAttribute("attr-password"));
            $('#<%=contact.ClientID%>').val(eleView.getAttribute("attr-contact"));
            $('#<%=name.ClientID%>').val(eleView.getAttribute("attr-fullname"));
            if (eleView.getAttribute("attr-status") == "True") {
                $('#<%=ddlStatus.ClientID%>').val("1");
            }
            else {
                $('#<%=ddlStatus.ClientID%>').val("0");
            }

            var dd = document.getElementById('<%=ddlLevel.ClientID%>');
            for (var i = 0; i < dd.options.length; i++) {
                if (dd.options[i].text === eleView.getAttribute("attr-role")) {
                    dd.selectedIndex = i;
                    break;
                }
            }

            var dd2 = document.getElementById('<%=ddlAgent.ClientID%>');
            for (var i2 = 0; i2 < dd2.options.length; i2++) {
                if (dd2.options[i2].value === eleView.getAttribute("attr-agent")) {
                    dd2.selectedIndex = i2;
                    break;
                }
            }

            var dd3 = document.getElementById('<%=ddlCompany.ClientID%>');
            for (var i3 = 0; i3 < dd3.options.length; i3++) {
                if (dd3.options[i3].value === eleView.getAttribute("attr-share")) {
                    dd3.selectedIndex = i3;
                    break;
                }
            }

            $(".inModal > select > option[value='']").attr("disabled", "disabled");

            if ($("#<%=AgentIDLogin.ClientID%>").val() != "0") {
                $("#<%=ddlCompany.ClientID%>").attr("disabled", "disabled");
            }
            <%--else if($("#<%=AgentIDLogin.ClientID%>").val() != "0" && $("#<%=SubAgentIDLogin.ClientID%>").val() != "0"){
                $("#<%=ddlCompany.ClientID%>, #<%=ddlAgent.ClientID%>, #<%=ddlSubAgent.ClientID%>").attr("disabled", "disabled");
            }--%>

            SetLan(localStorage.getItem("Language"));
            $('#modalAddMember').modal();
        }

        function EditMember() {
            $("#myModalLoad").modal();
            var c = $('#<%=password.ClientID%>').val();
            if ($('#<%=username.ClientID%>').val() == "") {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:missing 'Username' field");
                SetLan(localStorage.getItem("Language"));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else if ($('#<%=username.ClientID%>').val().length < 2) {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:Field 'Username' should be at least 2 characters.");
                SetLan(localStorage.getItem("Language"));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else if ($('#<%=password.ClientID%>').val() == "") {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:missing 'Password' field");
                SetLan(localStorage.getItem('Language'));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else if (c.length < 8) {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:Password must be greater than 8 characters.");
                SetLan(localStorage.getItem('Language'));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else if ($('#<%=name.ClientID%>').val() == "") {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:missing 'Name' field");
                SetLan(localStorage.getItem('Language'));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else if (document.getElementById("<%=ddlLevel.ClientID%>").value == "") {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:missing 'Level' field");
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
            else if (document.getElementById("<%=ddlCompany.ClientID%>").value == "") {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:missing 'Company' field");
                SetLan(localStorage.getItem('Language'));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else {
                $("#<%=LevelEdit.ClientID%>").val(document.getElementById("<%=ddlLevel.ClientID%>").value);
                $("#<%=StatusEdit.ClientID%>").val(document.getElementById("<%=ddlStatus.ClientID%>").value);

               $("#<%=AgentEdit.ClientID%>").val(document.getElementById("<%=ddlAgent.ClientID%>").value);
                $("#<%=CompanyEdit.ClientID%>").val(document.getElementById("<%=ddlCompany.ClientID%>").value);

            $("#<%=btnEditMember.ClientID%>").click();
            }
            SetLan(localStorage.getItem('Language'));
}

function alertModal(txtAlert) {
    document.getElementById("lbAlert").setAttribute("set-lan", "text:" + txtAlert + "");
    SetLan(localStorage.getItem('Language'));
    $('#modalAlert').modal('show');
    $("#myModalLoad, #modalAddMember, #modalDeleteMember, #modalReQR").modal('hide');

    if ($("#<%=AgentIDLogin.ClientID%>").val() != "0" && $("#<%=AgentIDLogin.ClientID%>").val() != "1") {
        $(".zoneSearchCom, .zoneSearchAgent, .zoneCompany, .zoneAgent").css("display", "none");
    }
    else {
        if ($("#<%=IDRole.ClientID%>").val() != "Super User" && $("#<%=IDRole.ClientID%>").val() != "Master") {
            $(".zoneSearchCom, .zoneSearchAgent, .zoneCompany, .zoneAgent").css("display", "none");
        }
    }

    setTimeout(function () { $('#modalAlert').modal('hide') }, 2000);
}

        function disDropdown() {
            $("option[value='']").attr("disabled", "disabled");
            $("option[value='0']").attr("disabled", "disabled");
            SetLan(localStorage.getItem('Language'));
        }
    </script>
</asp:Content>
