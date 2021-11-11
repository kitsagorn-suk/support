<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PrefixDetail.aspx.cs" Inherits="Support_Project.Menu_AMBBO.PrefixDetail" %>

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
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="" set-lan="text:Ambbo"></a></li>
            <li class="breadcrumb-item active txtMem" set-lan="text:Prefix Detail"></li>
        </ol>
    </nav>
    <div class="row">
        <div class="col-md-8">
            <h1 set-lan="text:Prefix Detail"></h1>
        </div>
    </div>
    <div class="btn-toolbar section-group" role="toolbar" style="padding-left: 2.5rem;">
        <div class="col-md-12 row" style="margin-left: 1rem;">
            <div class="row">
                <label for="email" class="col-form-label" set-lan="html:Prefix__"></label>
                <div style="padding-left: 1rem;">
                    <input type="text" class="form-control" id="searchPrefix" set-lan="placeholder:Prefix" onkeyup="inputKeyUp(event)" />
                </div>
                <button class="btn btn-yellow font-weight-bold m-0 px-3 py-2 z-depth-0 waves-effect btnMenu" style="margin-left: .5rem !important;" type="button" onclick="Search_Click()" set-lan="text:Search"></button>
            </div>
        </div>
    </div>
    <div id="zonePlsSearch" class="btn-toolbar section-group" role="toolbar" style="margin-top: 1rem; padding-top: 2rem; font-weight: bold; background-color: #dee2e6;">
        <p class="col-12" style="text-align: center; color: #333;" set-lan="text:Please enter search."></p>
    </div>
    <div class="section-group mb-4 col-12" id="detailData" style="display: none; margin-top: 1rem;">
        <div class="form-row">
            <div class="form-group col-5">
                <div class="form-group row">
                    <label for="username" class="col-4 col-form-label" set-lan="text:Prefix_"></label>
                    <div class="col-8">
                        <input type="text" id="prefix" class="form-control" disabled="disabled" autocomplete="off" />
                    </div>
                </div>
                <div class="form-group row">
                    <label for="username" class="col-4 col-form-label" set-lan="text:Company Name_"></label>
                    <div class="col-8">
                        <input type="text" id="companyName" class="form-control" disabled="disabled" autocomplete="off" />
                    </div>
                </div>
                 <div class="form-group row">
                    <label for="username" class="col-4 col-form-label" set-lan="text:Product_"></label>
                    <div class="col-8">
                        <input type="text" id="product" class="form-control" disabled="disabled" autocomplete="off" />
                    </div>
                </div>
                 <div class="form-group row">
                    <label for="username" class="col-4 col-form-label" set-lan="text:URL Old Data_"></label>
                    <div class="col-8">
                        <textarea id="urlOldData" class="form-control" rows="2" readonly></textarea>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="username" class="col-4 col-form-label" set-lan="text:Logo_"></label>
                    <div class="col-8">
                        <img src="../img/noImage2.jpg" style="width: 100%;" id="logo" />
                    </div>
                </div>              
            </div>
            <div class="form-group col-1"></div>
            <div class="form-group col-5">
                <div class="form-group row">
                    <label for="username" class="col-4 col-form-label" set-lan="text:Agent ID_"></label>
                    <div class="col-8">
                        <input type="text" id="agentId" class="form-control" disabled="disabled" autocomplete="off" />
                    </div>
                </div>
                <div class="form-group row">
                    <label for="username" class="col-4 col-form-label" set-lan="text:Line_"></label>
                    <div class="col-8">
                        <input type="text" id="line" class="form-control" disabled="disabled" autocomplete="off" />
                    </div>
                </div>
                <div class="form-group row">
                    <label for="username" class="col-4 col-form-label" set-lan="text:URL_"></label>
                    <div class="col-8">
                        <textarea id="url" class="form-control" rows="2" readonly></textarea>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="username" class="col-4 col-form-label" set-lan="text:URL API_"></label>
                    <div class="col-8">
                        <textarea id="urlAPI" class="form-control" rows="2" readonly></textarea>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="username" class="col-4 col-form-label" set-lan="text:Background_"></label>
                    <div class="col-8">
                        <img src="../img/noImage2.jpg" style="width: 100%;" id="background" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Button ID="btnTest" class="btn btn-lg btn-yellow font-weight-bold btn-block" OnClick="Test_click" runat="server" Text="Add" Style="display: none;" />
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
    <asp:HiddenField ID="IDRole" runat="Server"></asp:HiddenField>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainScript" runat="server">
    <script src="../js/moment.min.js"></script>
    <script src="../js/pagination.js"></script>
    <script>
        var token = "";
        var TotalData;
        var NumPage;
        $(document).ready(function () {
            $("#menuAmbbo , #menuAmbbo > a , #menuAmbboPrefix > a").addClass("active");
            $("#menuAmbbo > div").css("display", "block");

            var date = new Date();
            var dateSet = date.getFullYear() + "-" + ("0" + (date.getMonth() + 1)).slice(-2) + "-" + ("0" + date.getDate()).slice(-2);
        });

        function inputKeyUp(e) {
            e.which = e.which || e.keyCode;
            if (e.which == 13) {
                Search_Click();
            }
        }

        function Search_Click() {
            $("#myModalLoad").modal();

            if ($("#searchPrefix").val() == "" || $("#searchPrefix").val() == null) {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:missing 'Prefix' field");
                SetLan(localStorage.getItem("Language"));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else {
                $("#zonePlsSearch").css("display", "none");

                GetData();
            }
        }

        function GetData() {
            $("#detailData").css("display", "none");
            var dataAdd = new Object();
            dataAdd.prefix = $("#searchPrefix").val();
            $.ajax({
                url: "https://ambbo-test-support.prettygaming.asia/external/support/prefix",
                type: 'POST',
                dataType: 'json',
                data: JSON.stringify(dataAdd),
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    if (data.code == 0 || data.code == null) {
                        $("#prefix").val(data.result.prefix);
                        $("#url").val(data.result.url);
                        $("#companyName").val(data.result.companyName);
                        $("#agentId").val(data.result.agentId);
                        $("#product").val(data.result.product);
                        $("#line").val(data.result.line);
                        $("#urlOldData").val(data.result.urlOldData);
                        $("#urlAPI").val(data.result.urlAPI);
                        if (data.result.logo != "" && data.result.logo != null) {
                            $("#logo").attr("src", "https://d20gjgsn2f0jqy.cloudfront.net/Iamrobot/" + data.result.logo);
                        }
                        if (data.result.background != "" && data.result.background != null) {
                            $("#background").attr("src", "https://d20gjgsn2f0jqy.cloudfront.net/Iamrobot/" + data.result.background);
                        }
                        $("#detailData").css("display", "block");
                        SetLan(localStorage.getItem("Language"));
                        $("#myModalLoad").modal('hide');
                    }
                    else {
                        $("#zonePlsSearch").css("display", "block");
                        document.getElementById('lbAlert').innerHTML = data.message;
                        $("#myModalLoad").modal('hide');
                        $('#modalAlert').modal('show');
                    }
                },
                error: function (xhr, exception) {
                    var msg = '';
                    if (xhr.status === 0) {
                        msg = 'Not connect. Verify Network.';
                    } else if (xhr.status == 404) {
                        msg = 'Requested page not found. [404]';
                    } else if (xhr.status == 500) {
                        msg = 'Internal Server Error [500].';
                    } else if (exception === 'parsererror') {
                        msg = 'Requested JSON parse failed.';
                    } else if (exception === 'timeout') {
                        msg = 'Time out error.';
                    } else if (exception === 'abort') {
                        msg = 'Ajax request aborted.';
                    } else {
                        msg = 'Uncaught Error.\n' + xhr.responseText;
                    }
                    document.getElementById('lbAlert').innerHTML = msg;
                    $("#myModalLoad").modal('hide');
                    $('#modalAlert').modal('show');
                }
            });
        }
    </script>
</asp:Content>
