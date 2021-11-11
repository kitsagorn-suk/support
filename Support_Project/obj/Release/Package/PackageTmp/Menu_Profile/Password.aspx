<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Password.aspx.cs" Inherits="Support_Project.Menu_Profile.Password" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .disabled-link {
            cursor: default;
            pointer-events: none;
            text-decoration: none;
            color: grey !important;
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
    </style>
    <div class="row">
        <div class="col-md-8">
            <h1 set-lan="text:Password"></h1>
        </div>
    </div>
    <div class="section-group mb-4 col-6">
        <div class="form-row">
            <div class="form-group col-12">
                <div class="form-group row">
                    <label for="oldpassword" class="col-3 col-form-label" style="text-align: right;" set-lan="html:Old Password__"></label>
                    <div class="col-9">
                        <asp:TextBox ID="oldpassword" class="form-control" autocomplete="off" runat="server" MaxLength="24" type="password" />
                        <span class="toggle-password field-icon" onclick="showPass('oldpassword');"><i class="far fa-eye-slash"></i></span>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="newpassword" class="col-3 col-form-label" style="text-align: right;" set-lan="html:New Password__"></label>
                    <div class="col-9">
                        <input class="form-control" id="newpassword" autocomplete="off" maxlength="24" type="password" />
                        <span class="toggle-password field-icon" onclick="showPass('newpassword');"><i class="far fa-eye-slash"></i></span>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="confirmpassword" class="col-3 col-form-label" style="text-align: right;" set-lan="html:Confirm Password__"></label>
                    <div class="col-9">
                        <asp:TextBox ID="confirmpassword" class="form-control" autocomplete="off" runat="server" MaxLength="24" type="password" />
                        <span class="toggle-password field-icon" onclick="showPass('confirmpassword');"><i class="far fa-eye-slash"></i></span>
                    </div>
                </div>
            </div>
        </div>
        <div class="form-row">
            <div class="col-12" style="text-align: center;">
                <asp:Button ID="btnChangePass" class="btn btn-lg btn-yellow font-weight-bold btn-block" OnClick="ChangePass_click" runat="server" Text="Save" Style="display: none;" />
                <asp:Button ID="btnLogoutSuccess" class="btn btn-lg btn-yellow font-weight-bold btn-block" OnClick="Logout_click" runat="server" Text="Logout" Style="display: none;" />
                <button class="btn btn-yellow font-weight-bold" onclick="savePassword()" type="button" set-lan="text:Save New Password"></button>
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
    <asp:HiddenField ID="CurrentPassword" runat="Server"></asp:HiddenField>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainScript" runat="server">
    <script>
        $(document).ready(function () {
            $("#menuAccount , #menuAccount > a , #menuPassword > a").addClass("active");
            $("#menuAccount > div").css("display", "block");
        });

        function savePassword() {
            $("#myModalLoad").modal();
            var c1 = $('#<%=oldpassword.ClientID%>').val();
            var c2 = $('#newpassword').val();
            var c3 = $('#<%=confirmpassword.ClientID%>').val();

            if ($('#<%=oldpassword.ClientID%>').val() == "") {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:missing 'Old Password' field");
                SetLan(localStorage.getItem("Language"));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else if ($('#newpassword').val() == "") {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:missing 'New Password' field");
                SetLan(localStorage.getItem("Language"));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else if ($('#<%=confirmpassword.ClientID%>').val() == "") {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:missing 'Confirm Password' field");
                SetLan(localStorage.getItem("Language"));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else if ($('#newpassword').val() != $('#<%=confirmpassword.ClientID%>').val()) {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:New password doesn't match confirm password");
                SetLan(localStorage.getItem("Language"));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else if ($('#<%=oldpassword.ClientID%>').val() != $('#<%=CurrentPassword.ClientID%>').val()) {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:The old password doesn't match the current password.");
                SetLan(localStorage.getItem("Language"));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else if (c2.length < 8 || c3.length < 8) {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:Password must be greater than 8 characters.");
                SetLan(localStorage.getItem('Language'));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else {
                $("#<%=btnChangePass.ClientID%>").click();
            }
    SetLan(localStorage.getItem("Language"));
}

function showPass(id) {
    var x = "";
    if (id == "oldpassword") {
        x = document.getElementById("<%=oldpassword.ClientID%>");
    }
    else if (id == "newpassword") {
        x = document.getElementById("newpassword");
    }
    else if (id == "confirmpassword") {
        x = document.getElementById("<%=confirmpassword.ClientID%>");
    }

    if (x.type === "password") {
        x.type = "text";
    } else {
        x.type = "password";
    }
}

function LogOutSuccess() {
    localStorage.clear();
    $("#<%=btnLogoutSuccess.ClientID%>").click();
}
    </script>
</asp:Content>
