<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="Support_Project.Menu_Profile.Profile" %>

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
            <h1 set-lan="text:Profile"></h1>
        </div>
    </div>
    <div class="section-group mb-4 col-6">
        <div class="form-row">
            <div class="form-group col-12">
                <div class="form-group row">
                    <label for="username" class="col-3 col-form-label" set-lan="text:Username_" style="text-align: right;"></label>
                    <div class="col-9">
                        <asp:TextBox ID="username" class="form-control" disabled="disabled" autocomplete="off" runat="server" />
                    </div>
                </div>
                <div class="form-group row">
                    <label for="username" class="col-3 col-form-label" set-lan="text:Level_" style="text-align: right;"></label>
                    <div class="col-9">
                        <asp:TextBox ID="level" class="form-control" disabled="disabled" autocomplete="off" runat="server" />
                    </div>
                </div>
                <div class="form-group row">
                    <label for="username" class="col-3 col-form-label" set-lan="text:Agent_" style="text-align: right;"></label>
                    <div class="col-9">
                        <asp:TextBox ID="Agent" class="form-control" disabled="disabled" autocomplete="off" runat="server" />
                    </div>
                </div>
            </div>
        </div>
        <%--<div class="form-row">
            <div class="col-12" style="text-align: center;">
                <asp:Button ID="btnChangePass" class="btn btn-lg btn-yellow font-weight-bold btn-block" OnClick="ChangePass_click" runat="server" Text="Save" Style="display: none;" />
                <button class="btn btn-yellow font-weight-bold" onclick="savePassword()" type="button">Save New Password</button>
            </div>
        </div>--%>
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
            $("#menuAccount , #menuAccount > a , #menuProfile > a").addClass("active");
            $("#menuAccount > div").css("display", "block");
        });
    </script>
</asp:Content>
