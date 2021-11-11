<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ChatBot.aspx.cs" Inherits="Support_Project.Menu_ChatBot.ChatBot" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .h_iframe iframe {
            width: 100%;
            height: 100%;
        }

        .h_iframe {
            height: 580px;
            width: 100%;
        }
    </style>
    <div class="row">
        <div class="col-md-8">
            <h1>Chat Bot</h1>
        </div>
    </div>
    <div class="section-group mb-4 col-12 h_iframe">
        <iframe src="https://support-gochat-web.secure-restapi.com/admin-login?uuid=5p7lmjaokt7jh882xvir" frameborder="0" allowfullscreen></iframe>
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainScript" runat="server">
    <script>
        var token = "";
        $(document).ready(function () {
            $("#menuChatBot , #menuChatBot > a").addClass("active");
        });
    </script>
</asp:Content>
