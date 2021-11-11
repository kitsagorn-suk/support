<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Promotion.aspx.cs" Inherits="Support_Project.Menu_AMBBO.Promotion" %>

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
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="" set-lan="text:Ambbo"></a></li>
            <li class="breadcrumb-item active txtMem" set-lan="text:Promotion"></li>
        </ol>
    </nav>
    <div class="row">
        <div class="col-md-8">
            <h1 set-lan="text:Promotion"></h1>
        </div>
    </div>
    <div class="btn-toolbar section-group" role="toolbar" style="padding-left: 2.5rem;">
        <div class="col-md-12 row" style="margin-left: 1rem;">
            <div class="row">
                <label for="email" class="col-form-label" set-lan="html:Prefix__"></label>
                <div style="padding-left: 1rem;">
                    <input type="text" class="form-control" id="searchPrefix" placeholder="Prefix" onkeyup="inputKeyUp(event)" />
                </div>
                <button class="btn btn-yellow font-weight-bold m-0 px-3 py-2 z-depth-0 waves-effect btnMenu" style="margin-left: .5rem !important;" type="button" onclick="Search_Click()" set-lan="text:Search"></button>
            </div>
        </div>
    </div>
    <div id="zonePlsSearch" class="btn-toolbar section-group" role="toolbar" style="margin-top: 1rem; padding-top: 2rem; font-weight: bold; background-color: #dee2e6;">
        <p class="col-12" style="text-align: center; color: #333;" set-lan="text:Please enter search."></p>
    </div>
    <div class="table-wrapper" style="margin-top: 1rem; margin-bottom: 1rem;">
        <table class="table table-border" id="tbDataPromotion" style="display: none;">
            <thead class="rgba-green-slight">
                <tr>
                    <th style="width: 5%;" set-lan="text:No"></th>
                    <th style="width: 15%;" set-lan="text:Promotion Name"></th>
                    <th style="width: 10%;" set-lan="text:Type"></th>
                    <th style="width: 10%;" set-lan="text:Min Topup"></th>
                    <th style="width: 10%;" set-lan="text:Max Topup"></th>
                    <th style="width: 10%;" set-lan="text:Max Bonus"></th>
                    <th style="width: 10%;" set-lan="text:Turnover"></th>
                    <th style="width: 10%;" set-lan="text:Max Withdraw"></th>
                    <th style="width: 10%;" set-lan="text:Status"></th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td colspan="9" style="text-align: center;" set-lan="text:No Data."></td>
                </tr>
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
                </tr>
            </tfoot>
        </table>
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
        $(document).ready(function () {
            $("#menuAmbbo , #menuAmbbo > a , #menuAmbboPromotion > a").addClass("active");
            $("#menuAmbbo > div").css("display", "block");
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
            $("#tbDataPromotion > tbody, #tbDataPromotion > tfoot").html("");
            $("#tbDataPromotion").css("display", "none");

            var dataAdd = new Object();
            dataAdd.prefix = $("#searchPrefix").val();
            $.ajax({
                url: "https://ambbo-test-support.prettygaming.asia/external/support/promotion",
                type: 'POST',
                dataType: 'json',
                data: JSON.stringify(dataAdd),
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    if (data.code == 0 || data.code == null) {
                        var dataTotal = data.result;
                        var htmlData = "";
                        var htmlFooter = "";
                        var no = 1;

                        if (dataTotal.length > 0) {
                            for (var i = 0; i < dataTotal.length; i++) {
                                var obj = dataTotal[i];
                                htmlData += "<tr>";
                                htmlData += "<td style='text-align: center;'>" + no + "</td>";
                                htmlData += "<td>" + obj.promotionName + "</td>";
                                htmlData += "<td>" + obj.type + "</td>";

                                var minTopup = parseFloat(obj.minTopup).toFixed(2);
                                if (minTopup < 0 || minTopup.toString() == "-0.00") {
                                    htmlData += "<td style='text-align: right; color: red;'>" + minTopup.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                }
                                else {
                                    htmlData += "<td style='text-align: right;'>" + minTopup.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                }

                                var maxTopup = parseFloat(obj.maxTopup).toFixed(2);
                                if (maxTopup < 0 || maxTopup.toString() == "-0.00") {
                                    htmlData += "<td style='text-align: right; color: red;'>" + maxTopup.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                }
                                else {
                                    htmlData += "<td style='text-align: right;'>" + maxTopup.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                }

                                var maxBonus = parseFloat(obj.maxBonus).toFixed(2);
                                if (maxBonus < 0 || maxBonus.toString() == "-0.00") {
                                    htmlData += "<td style='text-align: right; color: red;'>" + maxBonus.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                }
                                else {
                                    htmlData += "<td style='text-align: right;'>" + maxBonus.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                }

                                var turnOver = parseFloat(obj.turnOver).toFixed(2);
                                if (turnOver < 0 || turnOver.toString() == "-0.00") {
                                    htmlData += "<td style='text-align: right; color: red;'>" + turnOver.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                }
                                else {
                                    htmlData += "<td style='text-align: right;'>" + turnOver.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                }

                                var maxWithdraw = parseFloat(obj.maxWithdraw).toFixed(2);
                                if (maxWithdraw < 0 || maxWithdraw.toString() == "-0.00") {
                                    htmlData += "<td style='text-align: right; color: red;'>" + maxWithdraw.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                }
                                else {
                                    htmlData += "<td style='text-align: right;'>" + maxWithdraw.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                }

                                if (obj.active == true) {
                                    htmlData += "<td style='text-align: center;'>Active</td>";
                                }
                                else {
                                    htmlData += "<td style='text-align: center;'>Inactive</td>";
                                }

                                htmlData += "</tr>";
                                no++;
                            }

                            htmlFooter += "<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>";
                        }
                        else {
                            htmlData += "<tr><td colspan='9' style='text-align: center;' set-lan='text:No Data.'></td></tr>";
                            htmlFooter += "<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>";
                        }

                        $("#tbDataPromotion > tbody").append(htmlData);
                        $("#tbDataPromotion > tfoot").append(htmlFooter);
                        $("#tbDataPromotion").css("display", "inline-table");
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
