<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Member_Add.aspx.cs" Inherits="Support_Project.Menu_Management_Main.Member_Add" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
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
            left: 148px;
            z-index: 9;
        }

        select {
            display: block !important;
        }

        select:disabled {
            color: #1F2532 !important;
        }
    </style>
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="" set-lan="text:Management"></a></li>
            <li class="breadcrumb-item active txtMem" set-lan="text:Add Account"></li>
        </ol>
    </nav>
    <div class="row">
        <div class="col-md-8">
            <h1 set-lan="text:Add Account"></h1>
        </div>
    </div>
    <div class="section-group mb-4 col-6">
        <div class="form-row">
            <div class="form-group col-12">
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <div class="form-group row">
                            <label for="username" class="col-3 col-form-label" style="text-align: right;" set-lan="html:Username__"></label>
                            <div class="col-9">
                                <asp:TextBox ID="username" class="form-control" autocomplete="off" runat="server" MaxLength="30" onkeypress="clsAlphaNoOnly(event)" />
                            </div>
                        </div>
                        <div class="form-group row fillPass">
                            <label for="username" class="col-3 col-form-label" style="text-align: right;" set-lan="html:Password__"></label>
                            <div class="col-9">
                                <asp:TextBox ID="password" class="form-control" autocomplete="off" runat="server" MaxLength="24" type="password" />
                                <span toggle="#password" class="toggle-password field-icon" onclick="showPass();"><i class="far fa-eye-slash"></i></span>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="username" class="col-3 col-form-label" style="text-align: right;" set-lan="html:Name__"></label>
                            <div class="col-9">
                                <asp:TextBox ID="name" class="form-control" autocomplete="off" runat="server" MaxLength="250" />
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="username" class="col-3 col-form-label" style="text-align: right;" set-lan="text:Contact_"></label>
                            <div class="col-9">
                                <asp:TextBox ID="contact" class="form-control" autocomplete="off" runat="server" MaxLength="150" oninput="this.value=this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" />
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="username" class="col-3 col-form-label" style="text-align: right;" set-lan="html:Level__"></label>
                            <div class="col-9 inModal">
                                <asp:DropDownList ID="ddlLevel" runat="server" class="form-control" DataValueField="id" DataTextField="name" AutoPostBack="false">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="form-group row zoneCompany">
                            <label for="username" class="col-3 col-form-label" style="text-align: right;" set-lan="html:Company__"></label>
                            <div class="col-9 inModal">
                                <asp:DropDownList ID="ddlCompany" runat="server" class="form-control" DataValueField="id" DataTextField="name" AutoPostBack="true" OnSelectedIndexChanged="getDropdownAgent">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="form-group row zoneAgent">
                            <label for="username" class="col-3 col-form-label" style="text-align: right;" set-lan="html:Agent__"></label>
                            <div class="col-9 inModal">
                                <asp:DropDownList ID="ddlAgent" runat="server" class="form-control" DataValueField="id" DataTextField="name">
                                </asp:DropDownList>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
        <div class="form-row">
            <div class="col-12" style="text-align: center;">
                <button id="bAdd" class="btn btn-yellow font-weight-bold" onclick="SaveMember()" type="button" set-lan="text:Add Account"></button>
            </div>
        </div>
    </div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Button ID="btnAddMember" class="btn btn-lg btn-yellow font-weight-bold btn-block" OnClick="AddMember_click" runat="server" Text="Add" Style="display: none;" />
            <asp:Button ID="btnGetddlAgentAdd" class="btn btn-lg btn-yellow font-weight-bold btn-block" OnClick="getDropdownAgent" runat="server" Text="Add" Style="display: none;" />
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
    <asp:HiddenField ID="IDEdit" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="IDRole" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="IDAgent" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="IDCompany" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="CompanyView" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="thisPage" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="totalDocs" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="eventPaging" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="ShareIDLogin" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="AgentIDLogin" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="LoginPosi" runat="Server"></asp:HiddenField>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainScript" runat="server">
    <script src="../js/moment.min.js"></script>
    <script src="../js/pagination.js"></script>
    <script>
        var token = "";
        $(document).ready(function () {
            $("#menuManagementMain , #menuManagementMain > a , #menuManagementMemberAdd > a").addClass("active");
            $("#menuManagementMain > div").css("display", "block");
            $(".inModal > select > option[value='']").attr("disabled", "disabled");
        });

        function disDropdown() {
            $("option[value='']").attr("disabled", "disabled");
            $("option[value='0']").attr("disabled", "disabled");
            SetLan(localStorage.getItem('Language'));
        }

        function SaveMember() {
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
            else if (document.getElementById("<%=ddlCompany.ClientID%>").value == "") {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:missing 'Company' field");
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
            else {
                $("#<%=LevelAdd.ClientID%>").val(document.getElementById("<%=ddlLevel.ClientID%>").value);
                $("#<%=CompanyAdd.ClientID%>").val(document.getElementById("<%=ddlCompany.ClientID%>").value);
                $("#<%=AgentAdd.ClientID%>").val(document.getElementById("<%=ddlAgent.ClientID%>").value);
                $("#<%=btnAddMember.ClientID%>").click();
            }
            SetLan(localStorage.getItem('Language'));
        }

        function alertModalDuplicate(txtAlert) {
            document.getElementById("lbAlert").setAttribute("set-lan", "text:" + txtAlert + "");
            SetLan(localStorage.getItem('Language'));

            if ($("#<%=AgentIDLogin.ClientID%>").val() == "0" || $("#<%=AgentIDLogin.ClientID%>").val() == "1") {
                $(".zoneCompany, .zoneAgent").css("display", "flex");
            }
            else {
               <%-- if ($("#<%=SubAgentIDLogin.ClientID%>").val() == "0") {
                    $(".zoneSubAgent").css("display", "flex");
                }
                else {
                    $(".zoneCompany, .zoneAgent, .zoneSubAgent").css("display", "none");
                }--%>
            }

            $('#modalAlert').modal('show');
            $("#myModalLoad").modal('hide');
        }

        function alertModal(txtAlert) {
            document.getElementById("lbAlert").setAttribute("set-lan", "text:" + txtAlert + "");
            SetLan(localStorage.getItem('Language'));
            $('#modalAlert').modal('show');
            $("#myModalLoad").modal('hide');

            if (txtAlert == "Add new account success.") {
                setTimeout(function () { window.location.href = "../Menu_Management_Main/Member.aspx"; }, 1500);
            }
            else {
                setTimeout(function () { $('#modalAlert').modal('hide') }, 2000);
            }
        }

        function showPass() {
            var x = document.getElementById("<%=password.ClientID%>");
            if (x.type === "password") {
                x.type = "text";
            } else {
                x.type = "password";
            }
        }
    </script>
</asp:Content>
