<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Report.aspx.cs" Inherits="Support_Project.Menu_AMBBO.Report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .wrapperPage {
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
            width: 9em;
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
            <li class="breadcrumb-item"><a href="">Ambbo</a></li>
            <li class="breadcrumb-item active txtMem">Report</li>
        </ol>
    </nav>
    <div class="row">
        <div class="col-md-8">
            <h1>Report</h1>
        </div>
    </div>
    <div class="btn-toolbar section-group" role="toolbar" style="padding-left: 2.5rem;">
        <div class="col-md-12 row" style="margin-left: 0.4rem;">
            <div class="row">
                <label for="email" class="col-form-label" set-lan="text:Prefix_"></label>
                <div style="padding-left: 1rem;">
                    <input type="text" class="form-control" id="searchPrefix" onkeyup="inputKeyUp(event)" />
                </div>
            </div>
            <div class="row" style="padding-left: 2.5rem;">
                <label for="email" class="col-form-label alignright" set-lan="text:Type_"></label>
                <div style="padding-left: 1rem;" class="select-outline">
                    <select name="" id="ddlType" class="mdb-select" data-live-search="true" searchable="Search here.." onchange="GetDDL();">
                        <option value="" selected disabled set-lan="text:Select type"></option>
                        <option value="FIRST_TOPUP" set-lan="text:First topup">First topup</option>
                        <option value="DECIMAL" set-lan="text:Decimal"></option>
                        <option value="WITHDRAW_MARKETING" set-lan="text:Withdraw Marketing"></option>
                        <option value="AFFILIATE" set-lan="text:Affiliate"></option>
                        <option value="REPORT_DEPOSIT" set-lan="text:Report Deposit"></option>
                        <option value="WITHDRAW" set-lan="text:Withdraw"></option>
                    </select>
                </div>
            </div>
            <div class="row DDLCate" style="padding-left: 2.5rem; display: none;">
                <label for="email" class="col-form-label alignright" set-lan="text:Category_"></label>
                <div style="padding-left: 1rem;" class="select-outline">
                    <select name="" id="ddlCategory" class="mdb-select" data-live-search="true" searchable="Search here..">
                        <option value="" selected disabled set-lan="text:Select type"></option>
                        <option value="DEPOSIT" set-lan="text:Deposit"></option>
                        <option value="WALLET" set-lan="text:Wallet"></option>
                        <option value="TRUEMONEY" set-lan="text:Truemoney"></option>
                        <option value="7_DAY" set-lan="text:7 Day"></option>
                        <option value="PROBLEM" set-lan="text:Problem"></option>
                        <option value="CASHBACK" set-lan="text:Cashback"></option>
                    </select>
                </div>
            </div>
            <div class="row DDLStatus" style="padding-left: 2.5rem; display: none;">
                <label for="email" class="col-form-label alignright" set-lan="text:Status_"></label>
                <div style="padding-left: 1rem;" class="select-outline">
                    <select name="" id="ddlStatus" class="mdb-select" data-live-search="true" searchable="Search here..">
                        <option value="" selected disabled set-lan="text:Select type"></option>
                        <option value="CREATE">Create</option>
                        <option value="APPROVE">Approve</option>
                        <option value="PROCESS">Process</option>
                        <option value="REJECT">Reject</option>
                        <option value="FAIL">Fail</option>
                        <option value="MANUAL">Manual</option>
                        <option value="SUCCESS">Success</option>
                        <option value="DONE">Done</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-md-12 row" style="margin-top: .5rem;">
            <div class="row" style="margin-left: 0.1rem;">
                <label for="email" class="col-form-label" set-lan="text:Amount_"></label>
                <div style="padding-left: 1rem;">
                    <input type="text" class="form-control" id="searchAmount" onkeyup="inputKeyUp(event)" />
                </div>
            </div>
            <div class="row" style="padding-left: 2rem;">
                <label for="email" class="col-form-label" set-lan="text:Username_"></label>
                <div style="padding-left: 1rem;">
                    <input type="text" class="form-control" id="searchUsername" onkeyup="inputKeyUp(event)" />
                </div>
            </div>
            <div class="row fieldStart" style="padding-left: 2rem;">
                <label for="email" class="col-form-label" set-lan="text:Start date_"></label>
                <div style="padding-left: 1rem;" class="input-wrapper">
                    <i class="fas fa-calendar-alt iconCalendar"></i>
                    <input type="date" data-date="" id="startdate" class="testDate form-control" data-date-format="DD-MM-YYYY" style="width: 130px;" />
                </div>
            </div>
            <div class="row" style="padding-left: 2rem;">
                <label for="email" class="col-form-label" set-lan="text:To date_"></label>
                <div style="padding-left: 1rem;" class="input-wrapper">
                    <i class="fas fa-calendar-alt iconCalendar"></i>
                    <input type="date" data-date="" id="todate" class="testDate form-control" data-date-format="DD-MM-YYYY" style="width: 130px;" />
                </div>
            </div>
            <div class="row" style="padding-left: 2.5rem;">
                <button class="btn btn-yellow font-weight-bold m-0 px-3 py-2 z-depth-0 waves-effect btnMenu" type="button" onclick="Search_Click('','')" set-lan="text:Search"></button>
            </div>
        </div>
    </div>
    <div id="zonePlsSearch" class="btn-toolbar section-group" role="toolbar" style="margin-top: 1rem; padding-top: 2rem; font-weight: bold; background-color: #dee2e6;">
        <p class="col-12" style="text-align: center; color: #333;" set-lan="text:Please enter search."></p>
    </div>
    <div class="table-wrapper" style="margin-top: 1rem; margin-bottom: 1rem;">
        <div class="row btnPrevious" style="margin-top: 1rem; margin-bottom: 1rem; display: none;">
            <div class="col-12">
                <div class="btn-group mr-auto">
                    <div class="btn-group btn-group-green mr-3" data-toggle="buttons">
                        <label class="btn btn-white border border-success z-depth-0 form-check-label" onclick="btnTimePN('Previous');">
                            <input class="form-check-input" type="radio" name="options" id="option1" autocomplete="off" checked>
                            <span set-lan="text:Previous"></span>
                        </label>
                        <label class="btn btn-white border border-success z-depth-0 form-check-label active" onclick="btnTime('Today');">
                            <input class="form-check-input" type="radio" name="options" id="option2" autocomplete="off" checked>
                            <span set-lan="text:Today"></span>
                        </label>
                        <label class="btn btn-white border border-success z-depth-0 form-check-label" onclick="btnTime('Yesterday');">
                            <input class="form-check-input" type="radio" name="options" id="option3" autocomplete="off">
                            <span set-lan="text:Yesterday"></span>
                        </label>
                        <label class="btn btn-white border border-success z-depth-0 form-check-label" onclick="btnTime('This week');">
                            <input class="form-check-input" type="radio" name="options" id="option4" autocomplete="off">
                            <span set-lan="text:This week"></span>
                        </label>
                        <label class="btn btn-white border border-success z-depth-0 form-check-label" onclick="btnTime('Last week');">
                            <input class="form-check-input" type="radio" name="options" id="option5" autocomplete="off">
                            <span set-lan="text:Last week"></span>
                        </label>
                        <label class="btn btn-white border border-success z-depth-0 form-check-label" onclick="btnTime('This month');">
                            <input class="form-check-input" type="radio" name="options" id="option6" autocomplete="off">
                            <span set-lan="text:This month"></span>
                        </label>
                        <label class="btn btn-white border border-success z-depth-0 form-check-label" onclick="btnTime('Last month');">
                            <input class="form-check-input" type="radio" name="options" id="option7" autocomplete="off">
                            <span set-lan="text:Last month"></span>
                        </label>
                        <label class="btn btn-white border border-success z-depth-0 form-check-label" onclick="btnTimePN('Next');">
                            <input class="form-check-input" type="radio" name="options" id="option8" autocomplete="off" checked>
                            <span set-lan="text:Next"></span>
                        </label>
                    </div>
                </div>
            </div>
        </div>

        <table class="table table-border" id="tbDataFIRST_TOPUP" style="display: none;">
            <thead class="rgba-green-slight">
                <tr>
                    <th style="width: 10%;" set-lan="text:No"></th>
                    <th style="width: 15%;" set-lan="text:Datetime"></th>
                    <th style="width: 20%;" set-lan="text:Name - Surname"></th>
                    <th style="width: 15%;" set-lan="text:Username"></th>
                    <th style="width: 13%;" set-lan="text:Topup"></th>
                    <th style="width: 13%;" set-lan="text:Bonus"></th>
                    <th style="width: 20%;" set-lan="text:Recommend"></th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td colspan="7" style="text-align: center;" set-lan="text:No Data."></td>
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
                </tr>
            </tfoot>
        </table>

        <div id="Report_Deposit" style="display: none;">
            <table class="table table-border" id="tbDataREPORT_DEPOSIT_Summary">
                <thead class="rgba-green-slight">
                    <tr>
                        <th style="width: 10%;" set-lan="text:No"></th>
                        <th style="width: 20%;" set-lan="text:Bank Name"></th>
                        <th style="width: 15%;" set-lan="text:Amount"></th>
                        <th style="width: 15%;" set-lan="text:Summary"></th>
                        <th style="width: 15%;" set-lan="text:Summary Bonus"></th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan="5" style="text-align: center;" set-lan="text:No Data."></td>
                    </tr>
                </tbody>
                <tfoot class="rgba-yellow-slight">
                    <tr class="total">
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                </tfoot>
            </table>

            <div class="wrapperPage">
                <section>
                    <div class="data-container"></div>
                    <div id="pagination-REPORT_DEPOSIT"></div>
                </section>
            </div>
            <table class="table table-border" id="tbDataREPORT_DEPOSIT">
                <thead class="rgba-green-slight">
                    <tr>
                        <th style="width: 4%;" set-lan="text:No"></th>
                        <th style="width: 7%;" set-lan="text:Bank Name"></th>
                        <th style="width: 8%;" set-lan="text:Username"></th>
                        <th style="width: 5%;" set-lan="text:Topup"></th>
                        <th style="width: 5%;" set-lan="text:Bonus"></th>
                        <th style="width: 8%;" set-lan="text:Credit before topup"></th>
                        <th style="width: 5%;" set-lan="text:Value"></th>
                        <th style="width: 8%;" set-lan="text:Credit after topup"></th>
                        <th style="width: 11%;" set-lan="text:Date Bank"></th>
                        <th style="width: 11%;" set-lan="text:Create date"></th>
                        <th style="width: 11%;" set-lan="text:Update date"></th>
                        <th style="width: 8%;" set-lan="text:Action By"></th>
                        <th style="width: 10%;" set-lan="text:Remark"></th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan="13" style="text-align: center;" set-lan="text:No Data."></td>
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
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                </tfoot>
            </table>
        </div>

        <div id="WITHDRAW_MARKETING" style="display: none;">
            <div class="wrapperPage" style="margin-top: -3rem;">
                <section>
                    <div class="data-container"></div>
                    <div id="pagination-WITHDRAW_MARKETING"></div>
                </section>
            </div>
            <table class="table table-border" id="tbDataWITHDRAW_MARKETING">
                <thead class="rgba-green-slight">
                    <tr>
                        <th style="width: 5%;" set-lan="text:No"></th>
                        <th style="width: 10%;" set-lan="text:Username"></th>
                        <th style="width: 10%;" set-lan="text:Balance before withdraw"></th>
                        <th style="width: 10%;" set-lan="text:Value"></th>
                        <th style="width: 10%;" set-lan="text:Fee"></th>
                        <th style="width: 10%;" set-lan="text:Balance after withdraw"></th>
                        <th style="width: 10%;" set-lan="text:Create date"></th>
                        <th style="width: 10%;" set-lan="text:Update date"></th>
                        <th style="width: 8%;" set-lan="text:Status"></th>
                        <th style="width: 10%;" set-lan="text:Action By"></th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan="10" style="text-align: center;" set-lan="text:No Data."></td>
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
                        <td></td>
                    </tr>
                </tfoot>
            </table>
        </div>

        <div id="DECIMAL" style="display: none;">
            <div class="wrapperPage" style="margin-top: -3rem;">
                <section>
                    <div class="data-container"></div>
                    <div id="pagination-DECIMAL"></div>
                </section>
            </div>
            <table class="table table-border" id="tbDataDECIMAL">
                <thead class="rgba-green-slight">
                    <tr>
                        <th style="width: 5%;" set-lan="text:No"></th>
                        <th style="width: 10%;" set-lan="text:Username"></th>
                        <th style="width: 10%;" set-lan="text:Value"></th>
                        <th style="width: 10%;" set-lan="text:Create date"></th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan="4" style="text-align: center;" set-lan="text:No Data."></td>
                    </tr>
                </tbody>
                <tfoot class="rgba-yellow-slight">
                    <tr class="total">
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                </tfoot>
            </table>
        </div>

        <div id="WITHDRAW" style="display: none;">
            <table class="table table-border" id="tbDataWITHDRAW_Summary">
                <thead class="rgba-green-slight">
                    <tr>
                        <th style="width: 20%;" set-lan="text:Bank Name"></th>
                        <th style="width: 15%;" set-lan="text:Account set"></th>
                        <th style="width: 15%;" set-lan="text:Count"></th>
                        <th style="width: 15%;" set-lan="text:Summary"></th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan="4" style="text-align: center;" set-lan="text:No Data."></td>
                    </tr>
                </tbody>
                <tfoot class="rgba-yellow-slight">
                    <tr class="total">
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                </tfoot>
            </table>

            <div class="wrapperPage">
                <section>
                    <div class="data-container"></div>
                    <div id="pagination-WITHDRAW"></div>
                </section>
            </div>
            <table class="table table-border" id="tbDataWITHDRAW">
                <thead class="rgba-green-slight">
                    <tr>
                        <th style="width: 5%;" set-lan="text:No"></th>
                        <th style="width: 8%;" set-lan="text:Bank Name"></th>
                        <th style="width: 10%;" set-lan="text:Username"></th>
                        <th style="width: 8%;" set-lan="text:Withdraw"></th>
                        <th style="width: 10%;" set-lan="text:Type"></th>
                        <th style="width: 10%;" set-lan="text:Withdrawal Date"></th>
                        <th style="width: 8%;" set-lan="text:Status"></th>
                        <%--<th style="width: 10%;" set-lan="text:Action By"></th>--%>
                        <th style="width: 10%;" set-lan="text:Remark"></th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan="8" style="text-align: center;" set-lan="text:No Data."></td>
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
                    </tr>
                </tfoot>
            </table>
        </div>

        <div id="AFFILIATE" style="display: none;">
            <div class="form-row" style="padding-left: 2.5rem; margin-top: 2rem;">
                <div class="form-group col-5">
                    <div class="form-group row" style="margin-bottom: 0rem !important;">
                        <label for="username" class="col-4 col-form-label" set-lan="text:Name_"></label>
                        <div class="col-8">
                            <p id="name" style="margin-top: 7px !important;"></p>
                        </div>
                    </div>
                    <div class="form-group row" style="margin-bottom: 0rem !important;">
                        <label for="username" class="col-4 col-form-label" set-lan="text:Wallet Main_"></label>
                        <div class="col-8">
                            <p id="walletMain" style="margin-top: 7px !important;"></p>
                        </div>
                    </div>
                    <div class="form-group row" style="margin-bottom: 0rem !important;">
                        <label for="username" class="col-4 col-form-label" set-lan="text:Wallet Win Lose_"></label>
                        <div class="col-8">
                            <p id="walletWinLose" style="margin-top: 7px !important;"></p>
                        </div>
                    </div>
                </div>
                <div class="form-group col-5">
                    <div class="form-group row" style="margin-bottom: 0rem !important;">
                        <label for="username" class="col-4 col-form-label" set-lan="text:Shareholder Line_"></label>
                        <div class="col-8">
                            <p id="shareHolderLineName" style="margin-top: 7px !important;"></p>
                        </div>
                    </div>
                    <div class="form-group row" style="margin-bottom: 0rem !important;">
                        <label for="username" class="col-4 col-form-label" set-lan="text:Wallet Transfer_"></label>
                        <div class="col-8">
                            <p id="walletTransfer" style="margin-top: 7px !important;"></p>
                        </div>
                    </div>
                    <div class="form-group row" style="margin-bottom: 0rem !important;">
                        <label for="username" class="col-4 col-form-label" set-lan="text:Wallet Commission_"></label>
                        <div class="col-8">
                            <p id="walletCommission" style="margin-top: 7px !important;"></p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="wrapperPage">
                <section>
                    <div class="data-container"></div>
                    <div id="pagination-AFFILIATE"></div>
                </section>
            </div>
            <table class="table table-border" id="tbDataAFFILIATE">
                <thead class="rgba-green-slight">
                    <tr>
                        <th style="width: 10%;" set-lan="text:No"></th>
                        <th style="width: 20%;" set-lan="text:Username"></th>
                        <th style="width: 15%;" set-lan="text:Value"></th>
                        <th style="width: 15%;" set-lan="text:Create date"></th>
                        <th style="width: 10%;" set-lan="text:Type"></th>
                        <th style="width: 10%;" set-lan="text:Status"></th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan="6" style="text-align: center;" set-lan="text:No Data."></td>
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
                    </tr>
                </tfoot>
            </table>
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
        var typeTime = "Day";
        $(document).ready(function () {
            $(".paginationjs-page").click(function () {
                alert(this.getAttribute("data-num"));
            });

            $("#menuAmbbo , #menuAmbbo > a , #menuAmbboReport > a").addClass("active");
            $("#menuAmbbo > div").css("display", "block");

            var date = new Date();
            var dateSet = date.getFullYear() + "-" + ("0" + (date.getMonth() + 1)).slice(-2) + "-" + ("0" + date.getDate()).slice(-2);
            $("#startdate").val(dateSet);
            $("#todate").val(dateSet);

            $("input[type=date]").on("change", function () {
                this.setAttribute(
                    "data-date",
                    moment(this.value, "YYYY-MM-DD")
                    .format(this.getAttribute("data-date-format"))
                )
            }).trigger("change")
        });

        function btnTime(type) {
            var start = "";
            var end = "";
            var date = new Date();

            if (type == "Today") {
                date = date.getFullYear() + "-" + ("0" + (date.getMonth() + 1)).slice(-2) + "-" + ("0" + date.getDate()).slice(-2);
                $("#startdate").val(date);
                $("#todate").val(date);
                start = date;
                end = date;
                typeTime = "Day";
            }
            else if (type == "Yesterday") {
                var todayTimeStamp = +new Date;
                var oneDayTimeStamp = 1000 * 60 * 60 * 24;
                var diff = todayTimeStamp - oneDayTimeStamp;
                var yesterdayDate = new Date(diff);
                var yesterdayString = yesterdayDate.getFullYear() + "-" + ("0" + (yesterdayDate.getMonth() + 1)).slice(-2) + "-" + ("0" + yesterdayDate.getDate()).slice(-2);
                $("#startdate").val(yesterdayString);
                $("#todate").val(yesterdayString);
                start = yesterdayString;
                end = yesterdayString;
                typeTime = "Day";
            }
            else if (type == "This week") {
                var firstday = date.getDate() - date.getDay();
                var lastday = firstday + 6;
                var date1 = new Date(date.setDate(firstday));
                var date2 = new Date(date.setDate(lastday));
                var startDate = date1.getFullYear() + "-" + ("0" + (date1.getMonth() + 1)).slice(-2) + "-" + ("0" + date1.getDate()).slice(-2);
                var endDate = date2.getFullYear() + "-" + ("0" + (date2.getMonth() + 1)).slice(-2) + "-" + ("0" + date2.getDate()).slice(-2);
                $("#startdate").val(startDate);
                $("#todate").val(endDate);
                start = startDate;
                end = endDate;
                typeTime = "Week";
            }
            else if (type == "Last week") {
                var firstday = (date.getDate() - date.getDay()) - 7;
                var lastday = firstday + 6;
                var date1 = new Date(date.setDate(firstday));
                var date2 = new Date(date.setDate(lastday));
                var startDate = date1.getFullYear() + "-" + ("0" + (date1.getMonth() + 1)).slice(-2) + "-" + ("0" + date1.getDate()).slice(-2);
                var endDate = date2.getFullYear() + "-" + ("0" + (date2.getMonth() + 1)).slice(-2) + "-" + ("0" + date2.getDate()).slice(-2);
                $("#startdate").val(startDate);
                $("#todate").val(endDate);
                start = startDate;
                end = endDate;
                typeTime = "Week";
            }
            else if (type == "This month") {
                var date1 = new Date(date.getFullYear(), date.getMonth(), 1);
                var date2 = new Date(date.getFullYear(), date.getMonth() + 1, 0);
                var startDate = date1.getFullYear() + "-" + ("0" + (date1.getMonth() + 1)).slice(-2) + "-" + ("0" + date1.getDate()).slice(-2);
                var endDate = date2.getFullYear() + "-" + ("0" + (date2.getMonth() + 1)).slice(-2) + "-" + ("0" + date2.getDate()).slice(-2);;
                $("#startdate").val(startDate);
                $("#todate").val(endDate);
                start = startDate;
                end = endDate;
                typeTime = "Month";
            }
            else if (type == "Last month") {
                var date1 = new Date(date.getFullYear(), date.getMonth() - 1, 1);
                var date2 = new Date(date.getFullYear(), date.getMonth(), 0);
                var startDate = date1.getFullYear() + "-" + ("0" + (date1.getMonth() + 1)).slice(-2) + "-" + ("0" + date1.getDate()).slice(-2);
                var endDate = date2.getFullYear() + "-" + ("0" + (date2.getMonth() + 1)).slice(-2) + "-" + ("0" + date2.getDate()).slice(-2);
                $("#startdate").val(startDate);
                $("#todate").val(endDate);
                start = startDate;
                end = endDate;
                typeTime = "Month";
            }

            $("input[type=date]").on("change", function () {
                this.setAttribute(
                    "data-date",
                    moment(this.value, "YYYY-MM-DD")
                    .format(this.getAttribute("data-date-format"))
                )
            }).trigger("change")

            Search_Click(start, end);
        }

        function btnTimePN(type) {
            var startVal = new Date($('#startdate').val());
            var toVal = new Date($('#todate').val());
            var start = "";
            var end = "";

            if (typeTime == "Day") {
                if (type == "Previous") {
                    var todayTimeStamp = startVal;
                    var oneDayTimeStamp = 1000 * 60 * 60 * 24;
                    var diff = todayTimeStamp - oneDayTimeStamp;
                    var yesterdayDate = new Date(diff);
                    var yesterdayString = yesterdayDate.getFullYear() + "-" + ("0" + (yesterdayDate.getMonth() + 1)).slice(-2) + "-" + ("0" + yesterdayDate.getDate()).slice(-2);
                    $("#startdate").val(yesterdayString);
                    $("#todate").val(yesterdayString);
                    start = yesterdayString;
                    end = yesterdayString;
                }
                else if (type == "Next") {
                    var Val = new Date(startVal.setDate(startVal.getDate() + 1));
                    var tomorrowString = Val.getFullYear() + "-" + ("0" + (Val.getMonth() + 1)).slice(-2) + "-" + ("0" + Val.getDate()).slice(-2);
                    $("#startdate").val(tomorrowString);
                    $("#todate").val(tomorrowString);
                    start = tomorrowString;
                    end = tomorrowString;
                }
            }
            else if (typeTime == "Week") {
                if (type == "Previous") {
                    var firstday = (startVal.getDate() - startVal.getDay()) - 7;
                    var lastday = firstday + 6;
                    var date1 = new Date(startVal.setDate(firstday));
                    var date2 = new Date(startVal.setDate(lastday));
                    var startDate = date1.getFullYear() + "-" + ("0" + (date1.getMonth() + 1)).slice(-2) + "-" + ("0" + date1.getDate()).slice(-2);
                    var endDate;
                    if (date1.getDate() > date2.getDate()) {
                        endDate = date2.getFullYear() + "-" + ("0" + (date2.getMonth() + 2)).slice(-2) + "-" + ("0" + date2.getDate()).slice(-2);
                    }
                    else {
                        endDate = date2.getFullYear() + "-" + ("0" + (date2.getMonth() + 1)).slice(-2) + "-" + ("0" + date2.getDate()).slice(-2);
                    }
                    $("#startdate").val(startDate);
                    $("#todate").val(endDate);
                    start = startDate;
                    end = endDate;
                }
                else if (type == "Next") {
                    var firstday = (startVal.getDate() - startVal.getDay()) + 7;
                    var date1 = new Date(startVal.setDate(firstday));
                    var startDate = date1.getFullYear() + "-" + ("0" + (date1.getMonth() + 1)).slice(-2) + "-" + ("0" + date1.getDate()).slice(-2);
                    var date2 = new Date(date1.setTime(date1.getTime() + (6 * 24 * 60 * 60 * 1000)));
                    var endDate = date2.getFullYear() + "-" + ("0" + (date2.getMonth() + 1)).slice(-2) + "-" + ("0" + date2.getDate()).slice(-2);
                    $("#startdate").val(startDate);
                    $("#todate").val(endDate);
                    start = startDate;
                    end = endDate;
                }
            }
            else if (typeTime == "Month") {
                if (type == "Previous") {
                    var current = new Date(startVal.getFullYear(), startVal.getMonth() - 1, 1);
                    var tomorrowString = current.getFullYear() + "-" + ("0" + (current.getMonth() + 1)).slice(-2) + "-" + ("0" + current.getDate()).slice(-2);
                    $("#startdate").val(tomorrowString);
                    var current2 = new Date(startVal.getFullYear(), startVal.getMonth(), 0);
                    var tomorrowString2 = current2.getFullYear() + "-" + ("0" + (current2.getMonth() + 1)).slice(-2) + "-" + ("0" + current2.getDate()).slice(-2);
                    $("#todate").val(tomorrowString2);
                    start = tomorrowString;
                    end = tomorrowString2;
                }
                else if (type == "Next") {
                    var current = new Date(startVal.getFullYear(), startVal.getMonth() + 1, 1);
                    var tomorrowString = current.getFullYear() + "-" + ("0" + (current.getMonth() + 1)).slice(-2) + "-" + ("0" + current.getDate()).slice(-2);
                    $("#startdate").val(tomorrowString);
                    var current2 = new Date(startVal.getFullYear(), startVal.getMonth() + 2, 0);
                    var tomorrowString2 = current2.getFullYear() + "-" + ("0" + (current2.getMonth() + 1)).slice(-2) + "-" + ("0" + current2.getDate()).slice(-2);
                    $("#todate").val(tomorrowString2);
                    start = tomorrowString;
                    end = tomorrowString2;
                }
            }

            $("input[type=date]").on("change", function () {
                this.setAttribute(
                    "data-date",
                    moment(this.value, "YYYY-MM-DD")
                    .format(this.getAttribute("data-date-format"))
                )
            }).trigger("change")

            Search_Click(start, end);
        }

        function inputKeyUp(e) {
            e.which = e.which || e.keyCode;
            if (e.which == 13) {
                Search_Click('','');
            }
        }

        function GetDDL() {
            if ($("#ddlType").val() == "REPORT_DEPOSIT") {
                $(".DDLCate").css("display", "inline-flex");
                $(".DDLStatus").css("display", "none");
            }
            else if ($("#ddlType").val() == "WITHDRAW") {
                $(".DDLStatus").css("display", "inline-flex");
                $(".DDLCate").css("display", "none");
            }
            else {
                $(".DDLCate").css("display", "none");
                $(".DDLStatus").css("display", "none");
            }
            $('#ddlCategory, #ddlStatus').prop("selectedIndex", 0);
        }

        function Search_Click(start, end) {
            $("#myModalLoad").modal();

            var dateOne = "";
            var dateTwo = "";

            if (start == "" && end == "") {
                dateOne = $("#startdate").val();
                dateTwo = $("#todate").val();
            }
            else {
                dateOne = start;
                dateTwo = end;
            }

            var date1 = Date.parse(dateOne);
            var date2 = Date.parse(dateTwo);
            if (date1 > date2) {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:Field 'To Date' should be greater than 'Start Date'.");
                SetLan(localStorage.getItem("Language"));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else if ($("#searchPrefix").val() == "" || $("#searchPrefix").val() == null) {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:missing 'Prefix' field");
                SetLan(localStorage.getItem("Language"));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else if ($("#ddlType").val() == "" || $("#ddlType").val() == null) {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:missing 'Type' field");
                SetLan(localStorage.getItem("Language"));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else if ($("#ddlType").val() == "REPORT_DEPOSIT" && $("#ddlCategory").val() == null) {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:missing 'Category' field");
                SetLan(localStorage.getItem("Language"));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else if ($("#ddlType").val() == "WITHDRAW" && $("#ddlStatus").val() == null) {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:missing 'Status' field");
                SetLan(localStorage.getItem("Language"));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else {
                $("#zonePlsSearch").css("display", "none");
                GetData(1);
            }
        }

        function GetData(NumPage) {
            $("#tbDataFIRST_TOPUP > tbody, #tbDataFIRST_TOPUP > tfoot").html("");
            $("#tbDataREPORT_DEPOSIT_Summary > tbody, #tbDataREPORT_DEPOSIT_Summary > tfoot").html("");
            $("#tbDataREPORT_DEPOSIT > tbody, #tbDataREPORT_DEPOSIT > tfoot").html("");
            $("#tbDataWITHDRAW_MARKETING > tbody, #tbDataWITHDRAW_MARKETING > tfoot").html("");
            $("#tbDataDECIMAL > tbody, #tbDataDECIMAL > tfoot").html("");
            $("#tbDataWITHDRAW_Summary > tbody, #tbDataWITHDRAW_Summary > tfoot").html("");
            $("#tbDataWITHDRAW > tbody, #tbDataWITHDRAW > tfoot").html("");
            $("#tbDataAFFILIATE > tbody, #tbDataAFFILIATE > tfoot").html("");
            $("#name, #walletMain, #walletWinLose, #shareHolderLineName, #walletTransfer, #walletCommission").text("");
            $("#tbDataFIRST_TOPUP, #Report_Deposit, #WITHDRAW_MARKETING, #DECIMAL, #WITHDRAW, #AFFILIATE, .btnPrevious").css("display", "none");

            var dataAdd = new Object();
            dataAdd.prefix = $("#searchPrefix").val();
            dataAdd.type = $("#ddlType").val();
            if ($("#ddlType").val() == "REPORT_DEPOSIT") {
                dataAdd.category = $("#ddlCategory").val();
                dataAdd.status = "";
                dataAdd.startDate = $("#startdate").val() + "T00:00:00.000Z";
                dataAdd.endDate = $("#todate").val() + "T23:59:00.000Z";
            }
            else if ($("#ddlType").val() == "WITHDRAW") {
                dataAdd.category = "";
                dataAdd.status = $("#ddlStatus").val();
                dataAdd.startDate = $("#startdate").val() + "T00:00:00.000Z";
                dataAdd.endDate = $("#todate").val() + "T23:59:00.000Z";
            }
            else if ($("#ddlType").val() == "WITHDRAW_MARKETING" || $("#ddlType").val() == "DECIMAL") {
                dataAdd.category = "";
                dataAdd.status = "";
                dataAdd.startDate = $("#startdate").val() + "T00:00:00.000Z";
                dataAdd.endDate = $("#todate").val() + "T23:59:00.000Z";
            }
            else if ($("#ddlType").val() == "AFFILIATE") {

            }
            else {
                dataAdd.category = "";
                dataAdd.status = "";
                dataAdd.startDate = $("#startdate").val();
                dataAdd.endDate = $("#todate").val();
            }

            if ($("#searchAmount").val() != "" || $("#searchAmount").val() != null) {
                dataAdd.amount = parseInt($("#searchAmount").val());
            }
            dataAdd.username = $("#searchUsername").val();
            dataAdd.limit = 100;
            dataAdd.page = NumPage;
            $.ajax({
                url: "https://ambbo-test-support.prettygaming.asia/external/support/report",
                type: 'POST',
                dataType: 'json',
                data: JSON.stringify(dataAdd),
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    if (data.code == 0 || data.code == null) {
                        var dataTotal = data.result;

                        if ($("#ddlType").val() == "DECIMAL" || $("#ddlType").val() == "WITHDRAW_MARKETING" || $("#ddlType").val() == "AFFILIATE" || $("#ddlType").val() == "REPORT_DEPOSIT" || $("#ddlType").val() == "WITHDRAW") {
                            SetPaging($("#ddlType").val(), dataTotal.total, NumPage);
                        }
                        else {
                            SetDataTable(NumPage);
                        }
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

        function SetPaging(nameID, total, NumPage) {
            $(function () {
                (function (name) {
                    var container = $('#pagination-' + name);
                    container.pagination({
                        totalNumber: total,
                        pageNumber: NumPage,
                        pageSize: 100,
                        dataSource: 'https://api.flickr.com/services/feeds/photos_public.gne?tags=cat&tagmode=any&format=json&jsoncallback=?',
                        locator: 'items',
                        callback: function (response, pagination) {
                            NumPage = container.pagination('getSelectedPageNum');
                            SetDataTable(NumPage);
                        }
                    });
                })(nameID);
            });
        }

        function SetDataTable(NumPage) {
            $("#myModalLoad").modal();

            var dataAdd = new Object();
            dataAdd.prefix = $("#searchPrefix").val();
            dataAdd.type = $("#ddlType").val();
            if ($("#ddlType").val() == "REPORT_DEPOSIT") {
                dataAdd.category = $("#ddlCategory").val();
                dataAdd.status = "";
                dataAdd.startDate = $("#startdate").val() + "T00:00:00.000Z";
                dataAdd.endDate = $("#todate").val() + "T23:59:00.000Z";
            }
            else if ($("#ddlType").val() == "WITHDRAW") {
                dataAdd.category = "";
                dataAdd.status = $("#ddlStatus").val();
                dataAdd.startDate = $("#startdate").val() + "T00:00:00.000Z";
                dataAdd.endDate = $("#todate").val() + "T23:59:00.000Z";
            }
            else if ($("#ddlType").val() == "WITHDRAW_MARKETING" || $("#ddlType").val() == "DECIMAL") {
                dataAdd.category = "";
                dataAdd.status = "";
                dataAdd.startDate = $("#startdate").val() + "T00:00:00.000Z";
                dataAdd.endDate = $("#todate").val() + "T23:59:00.000Z";
            }
            else if ($("#ddlType").val() == "AFFILIATE") {

            }
            else {
                dataAdd.category = "";
                dataAdd.status = "";
                dataAdd.startDate = $("#startdate").val();
                dataAdd.endDate = $("#todate").val();
            }

            if ($("#searchAmount").val() != "" || $("#searchAmount").val() != null) {
                dataAdd.amount = parseInt($("#searchAmount").val());
            }
            dataAdd.username = $("#searchUsername").val();
            dataAdd.limit = 100;
            dataAdd.page = NumPage;
            $.ajax({
                url: "https://ambbo-test-support.prettygaming.asia/external/support/report",
                type: 'POST',
                dataType: 'json',
                data: JSON.stringify(dataAdd),
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    if (data.code == 0 || data.code == null) {
                        var dataTotal = data.result;
                        var htmlData = "";
                        var htmlFooter = "";
                        var htmlDataDEPOSIT = "";
                        var htmlFooterDEPOSIT = "";
                        var no = 1;

                        if ($("#ddlType").val() == "FIRST_TOPUP") {
                            if (dataTotal.length > 0) {
                                for (var i = 0; i < dataTotal.length; i++) {
                                    var obj = dataTotal[i];
                                    htmlData += "<tr>";
                                    htmlData += "<td style='text-align: center;'>" + (((parseInt(NumPage) - 1) * 100) + no) + "</td>";

                                    var createDate = new Date(obj.trans.createDate);
                                    var txtcreateDate = ("0" + createDate.getDate()).slice(-2) + "-" + ("0" + (createDate.getMonth() + 1)).slice(-2) + "-" + ("0" + createDate.getFullYear()).slice(-2) + " " + ("0" + createDate.getHours()).slice(-2) + ":" + ("0" + createDate.getMinutes()).slice(-2) + ":" + ("0" + createDate.getSeconds()).slice(-2);
                                    htmlData += "<td style='text-align: center;'>" + txtcreateDate + "</td>";

                                    if (obj.name != undefined) {
                                        htmlData += "<td>" + obj.name + "</td>";
                                    }
                                    else {
                                        htmlData += "<td>-</td>";
                                    }

                                    htmlData += "<td>" + obj.username + "</td>";

                                    var topup = parseFloat(obj.trans.topup).toFixed(2);
                                    if (topup < 0 || topup.toString() == "-0.00") {
                                        htmlData += "<td style='text-align: right; color: red;'>" + topup.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                    }
                                    else {
                                        htmlData += "<td style='text-align: right;'>" + topup.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                    }

                                    var bonus = parseFloat(obj.trans.bonus).toFixed(2);
                                    if (bonus < 0 || bonus.toString() == "-0.00") {
                                        htmlData += "<td style='text-align: right; color: red;'>" + bonus.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                    }
                                    else {
                                        htmlData += "<td style='text-align: right;'>" + bonus.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                    }

                                    if (obj.recommend != undefined) {
                                        htmlData += "<td style='text-align: center;'>" + obj.recommend + "</td>";
                                    }
                                    else {
                                        htmlData += "<td style='text-align: center;'>-</td>";
                                    }

                                    htmlData += "</tr>";
                                    no++;
                                }

                                htmlFooter += "<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>";
                            }
                            else {
                                htmlData += "<tr><td colspan='7' style='text-align: center;' set-lan='text:No Data.'></td></tr>";
                                htmlFooter += "<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>";
                            }

                            $("#tbDataFIRST_TOPUP > tbody").append(htmlData);
                            $("#tbDataFIRST_TOPUP > tfoot").append(htmlFooter);
                            $("#tbDataFIRST_TOPUP").css("display", "inline-table");
                            $(".btnPrevious").css("display", "flex");
                        }
                        else if ($("#ddlType").val() == "REPORT_DEPOSIT") {
                            var arrSum = dataTotal.summary;
                            var noData = 1;
                            if (arrSum.length > 0) {
                                for (var i = 0; i < arrSum.length; i++) {
                                    var obj = arrSum[i];
                                    htmlData += "<tr>";
                                    htmlData += "<td style='text-align: center;'>" + (((parseInt(NumPage) - 1) * 100) + noData) + "</td>";
                                    htmlData += "<td style='text-align: center;'>" + obj._id.bankName + "</td>";
                                    htmlData += "<td style='text-align: right;'>" + obj.count + "</td>";

                                    var summary = parseFloat(obj.summary).toFixed(2);
                                    if (summary < 0 || summary.toString() == "-0.00") {
                                        htmlData += "<td style='text-align: right; color: red;'>" + summary.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                    }
                                    else {
                                        htmlData += "<td style='text-align: right;'>" + summary.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                    }

                                    var summaryBonus = parseFloat(obj.summaryBonus).toFixed(2);
                                    if (summaryBonus < 0 || summaryBonus.toString() == "-0.00") {
                                        htmlData += "<td style='text-align: right; color: red;'>" + summaryBonus.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                    }
                                    else {
                                        htmlData += "<td style='text-align: right;'>" + summaryBonus.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                    }
                                    htmlData += "</tr>";

                                    noData++;
                                }
                                htmlFooter += "<tr><td></td><td></td><td></td><td></td><td></td></tr>";
                            }
                            else {
                                htmlData += "<tr><td colspan='5' style='text-align: center;' set-lan='text:No Data.'></td></tr>";
                                htmlFooter += "<tr><td></td><td></td><td></td><td></td><td></td></tr>";
                            }

                            var arrData = dataTotal.list;
                            if (arrData.length > 0) {
                                for (var i = 0; i < arrData.length; i++) {
                                    var obj = arrData[i];
                                    htmlDataDEPOSIT += "<tr>";
                                    htmlDataDEPOSIT += "<td style='text-align: center;'>" + (((parseInt(NumPage) - 1) * 100) + no) + "</td>";
                                    htmlDataDEPOSIT += "<td style='text-align: center;'>" + obj.bankName + "</td>";
                                    htmlDataDEPOSIT += "<td style='text-align: left;'><p class='overflowTable ellipsis' title='" + obj.user + "'>" + obj.user + "</p></td>";

                                    var topUp = parseFloat(obj.topUp).toFixed(2);
                                    if (topUp < 0 || topUp.toString() == "-0.00") {
                                        htmlDataDEPOSIT += "<td style='text-align: right; color: red;'>" + topUp.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                    }
                                    else {
                                        htmlDataDEPOSIT += "<td style='text-align: right;'>" + topUp.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                    }

                                    var bonus = parseFloat(obj.bonus).toFixed(2);
                                    if (bonus < 0 || bonus.toString() == "-0.00") {
                                        htmlDataDEPOSIT += "<td style='text-align: right; color: red;'>" + bonus.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                    }
                                    else {
                                        htmlDataDEPOSIT += "<td style='text-align: right;'>" + bonus.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                    }

                                    var previousDownlineGiven = parseFloat(obj.previousDownlineGiven).toFixed(2);
                                    if (previousDownlineGiven < 0 || previousDownlineGiven.toString() == "-0.00") {
                                        htmlDataDEPOSIT += "<td style='text-align: right; color: red;'>" + previousDownlineGiven.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                    }
                                    else {
                                        htmlDataDEPOSIT += "<td style='text-align: right;'>" + previousDownlineGiven.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                    }

                                    var value = parseFloat(obj.value).toFixed(2);
                                    if (value < 0 || value.toString() == "-0.00") {
                                        htmlDataDEPOSIT += "<td style='text-align: right; color: red;'>" + value.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                    }
                                    else {
                                        htmlDataDEPOSIT += "<td style='text-align: right;'>" + value.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                    }

                                    var currentDownlineGiven = parseFloat(obj.currentDownlineGiven).toFixed(2);
                                    if (currentDownlineGiven < 0 || currentDownlineGiven.toString() == "-0.00") {
                                        htmlDataDEPOSIT += "<td style='text-align: right; color: red;'>" + currentDownlineGiven.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                    }
                                    else {
                                        htmlDataDEPOSIT += "<td style='text-align: right;'>" + currentDownlineGiven.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                    }

                                    var str = obj.dateBank.toString();
                                    var res = str.split(" ")[0];
                                    var res2 = str.split(" ")[1];
                                    var txtdateBank = res.split("/")[0] + "-" + res.split("/")[1] + "-" + res.split("/")[2].slice(2, 4) + " " + res2 + ":00";
                                    htmlDataDEPOSIT += "<td style='text-align: center;'>" + txtdateBank + "</td>";

                                    var createDate = new Date(obj.createDate);
                                    var txtcreateDate = ("0" + createDate.getDate()).slice(-2) + "-" + ("0" + (createDate.getMonth() + 1)).slice(-2) + "-" + ("0" + createDate.getFullYear()).slice(-2) + " " + ("0" + createDate.getHours()).slice(-2) + ":" + ("0" + createDate.getMinutes()).slice(-2) + ":" + ("0" + createDate.getSeconds()).slice(-2);
                                    htmlDataDEPOSIT += "<td style='text-align: center;'>" + txtcreateDate + "</td>";

                                    var updateDate = new Date(obj.updateDate);
                                    var txtupdateDate = ("0" + updateDate.getDate()).slice(-2) + "-" + ("0" + (updateDate.getMonth() + 1)).slice(-2) + "-" + ("0" + updateDate.getFullYear()).slice(-2) + " " + ("0" + updateDate.getHours()).slice(-2) + ":" + ("0" + updateDate.getMinutes()).slice(-2) + ":" + ("0" + updateDate.getSeconds()).slice(-2);
                                    htmlDataDEPOSIT += "<td style='text-align: center;'>" + txtupdateDate + "</td>";

                                    if (obj.actionBy != null && obj.actionBy != "") {
                                        htmlDataDEPOSIT += "<td style='text-align: left;'><p class='overflowTable ellipsis' title='" + obj.actionBy + "'>" + obj.actionBy + "</p></td>";
                                    }
                                    else {
                                        htmlDataDEPOSIT += "<td style='text-align: left;'><p class='overflowTable ellipsis'>-</p></td>";
                                    }

                                    htmlDataDEPOSIT += "<td style='text-align: left;'>" + obj.remark + "</td>";
                                    htmlDataDEPOSIT += "</tr>";
                                    no++;
                                }
                                htmlFooterDEPOSIT += "<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>";
                            }
                            else {
                                htmlDataDEPOSIT += "<tr><td colspan='13' style='text-align: center;' set-lan='text:No Data.'></td></tr>";
                                htmlFooterDEPOSIT += "<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>";
                            }

                            $("#tbDataREPORT_DEPOSIT_Summary > tbody").append(htmlData);
                            $("#tbDataREPORT_DEPOSIT_Summary > tfoot").append(htmlFooter);
                            $("#tbDataREPORT_DEPOSIT > tbody").append(htmlDataDEPOSIT);
                            $("#tbDataREPORT_DEPOSIT > tfoot").append(htmlFooterDEPOSIT);
                            $("#Report_Deposit").css("display", "initial");
                            $(".btnPrevious").css("display", "flex");
                        }
                        else if ($("#ddlType").val() == "WITHDRAW_MARKETING") {
                            var arrData = dataTotal.list;
                            if (arrData.length > 0) {
                                for (var i = 0; i < arrData.length; i++) {
                                    var obj = arrData[i];
                                    htmlData += "<tr>";
                                    htmlData += "<td style='text-align: center;'>" + (((parseInt(NumPage) - 1) * 100) + no) + "</td>";
                                    htmlData += "<td style='text-align: left;'><p class='overflowTable ellipsis' title='" + obj.username + "'>" + obj.username + "</p></td>";

                                    var previousDownlineGiven = parseFloat(obj.previousDownlineGiven).toFixed(2);
                                    if (previousDownlineGiven < 0 || previousDownlineGiven.toString() == "-0.00") {
                                        htmlData += "<td style='text-align: right; color: red;'>" + previousDownlineGiven.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                    }
                                    else {
                                        htmlData += "<td style='text-align: right;'>" + previousDownlineGiven.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                    }

                                    var value = parseFloat(obj.value).toFixed(2);
                                    if (value < 0 || value.toString() == "-0.00") {
                                        htmlData += "<td style='text-align: right; color: red;'>" + value.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                    }
                                    else {
                                        htmlData += "<td style='text-align: right;'>" + value.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                    }

                                    var fee = parseFloat(obj.fee).toFixed(2);
                                    if (fee < 0 || fee.toString() == "-0.00") {
                                        htmlData += "<td style='text-align: right; color: red;'>" + fee.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                    }
                                    else {
                                        htmlData += "<td style='text-align: right;'>" + fee.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                    }

                                    var currentDownlineGiven = parseFloat(obj.currentDownlineGiven).toFixed(2);
                                    if (currentDownlineGiven < 0 || currentDownlineGiven.toString() == "-0.00") {
                                        htmlData += "<td style='text-align: right; color: red;'>" + currentDownlineGiven.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                    }
                                    else {
                                        htmlData += "<td style='text-align: right;'>" + currentDownlineGiven.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                    }

                                    var createDate = new Date(obj.createDate);
                                    var txtcreateDate = ("0" + createDate.getDate()).slice(-2) + "-" + ("0" + (createDate.getMonth() + 1)).slice(-2) + "-" + ("0" + createDate.getFullYear()).slice(-2) + " " + ("0" + createDate.getHours()).slice(-2) + ":" + ("0" + createDate.getMinutes()).slice(-2) + ":" + ("0" + createDate.getSeconds()).slice(-2);
                                    htmlData += "<td style='text-align: center;'>" + txtcreateDate + "</td>";

                                    var updateDate = new Date(obj.updateDate);
                                    var txtupdateDate = ("0" + updateDate.getDate()).slice(-2) + "-" + ("0" + (updateDate.getMonth() + 1)).slice(-2) + "-" + ("0" + updateDate.getFullYear()).slice(-2) + " " + ("0" + updateDate.getHours()).slice(-2) + ":" + ("0" + updateDate.getMinutes()).slice(-2) + ":" + ("0" + updateDate.getSeconds()).slice(-2);
                                    htmlData += "<td style='text-align: center;'>" + txtupdateDate + "</td>";

                                    htmlData += "<td style='text-align: center;'>" + obj.status + "</td>";

                                    if (obj.actionBy.name != null && obj.actionBy.name != "" && obj.actionBy.name != undefined) {
                                        htmlData += "<td style='text-align: left;'><p class='overflowTable ellipsis' title='" + obj.actionBy.name + "'>" + obj.actionBy.name + "</p></td>";
                                    }
                                    else {
                                        htmlData += "<td style='text-align: left;'><p class='overflowTable ellipsis'>-</p></td>";
                                    }

                                    htmlData += "</tr>";
                                    no++;
                                }
                                htmlFooter += "<tr><td></td><td></td><td>Total :</td>";

                                var summary = parseFloat(dataTotal.summary).toFixed(2);
                                if (summary < 0 || summary.toString() == "-0.00") {
                                    htmlFooter += "<td style='text-align: right; color: red;'>" + summary.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                }
                                else {
                                    htmlFooter += "<td style='text-align: right;'>" + summary.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                }

                                var summaryFee = parseFloat(dataTotal.summaryFee).toFixed(2);
                                if (summaryFee < 0 || summaryFee.toString() == "-0.00") {
                                    htmlFooter += "<td style='text-align: right; color: red;'>" + summaryFee.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                }
                                else {
                                    htmlFooter += "<td style='text-align: right;'>" + summaryFee.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                }

                                htmlFooter += "<td></td><td></td><td></td><td></td><td></td></tr>";
                            }
                            else {
                                htmlData += "<tr><td colspan='10' style='text-align: center;' set-lan='text:No Data.'></td></tr>";
                                htmlFooter += "<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>";
                            }

                            $("#tbDataWITHDRAW_MARKETING > tbody").append(htmlData);
                            $("#tbDataWITHDRAW_MARKETING > tfoot").append(htmlFooter);
                            $("#WITHDRAW_MARKETING").css("display", "initial");
                            $(".btnPrevious").css("display", "flex");
                        }
                        else if ($("#ddlType").val() == "DECIMAL") {
                            var arrData = dataTotal.list;
                            if (arrData.length > 0) {
                                for (var i = 0; i < arrData.length; i++) {
                                    var obj = arrData[i];
                                    htmlData += "<tr>";
                                    htmlData += "<td style='text-align: center;'>" + (((parseInt(NumPage) - 1) * 100) + no) + "</td>";
                                    htmlData += "<td style='text-align: left;'><p class='overflowTable ellipsis' title='" + obj.username + "'>" + obj.username + "</p></td>";

                                    var value = parseFloat(obj.value).toFixed(2);
                                    if (value < 0 || value.toString() == "-0.00") {
                                        htmlData += "<td style='text-align: right; color: red;'>" + value.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                    }
                                    else {
                                        htmlData += "<td style='text-align: right;'>" + value.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                    }

                                    var createDate = new Date(obj.createDate);
                                    var txtcreateDate = ("0" + createDate.getDate()).slice(-2) + "-" + ("0" + (createDate.getMonth() + 1)).slice(-2) + "-" + ("0" + createDate.getFullYear()).slice(-2) + " " + ("0" + createDate.getHours()).slice(-2) + ":" + ("0" + createDate.getMinutes()).slice(-2) + ":" + ("0" + createDate.getSeconds()).slice(-2);
                                    htmlData += "<td style='text-align: center;'>" + txtcreateDate + "</td>";

                                    htmlData += "</tr>";
                                    no++;
                                }
                                htmlFooter += "<tr><td></td><td></td><td></td><td></td></tr>";
                            }
                            else {
                                htmlData += "<tr><td colspan='4' style='text-align: center;' set-lan='text:No Data.'></td></tr>";
                                htmlFooter += "<tr><td></td><td></td><td></td><td></td></tr>";
                            }

                            $("#tbDataDECIMAL > tbody").append(htmlData);
                            $("#tbDataDECIMAL > tfoot").append(htmlFooter);
                            $("#DECIMAL").css("display", "initial");
                            $(".btnPrevious").css("display", "flex");
                        }
                        else if ($("#ddlType").val() == "WITHDRAW") {
                            var arrSum = dataTotal.banks;
                            if (arrSum.length > 0) {
                                for (var i = 0; i < arrSum.length; i++) {
                                    var obj = arrSum[i];
                                    htmlData += "<tr>";
                                    htmlData += "<td style='text-align: center;'>" + obj._id.bankSet + "</td>";
                                    htmlData += "<td style='text-align: center;'>" + obj._id.accountSet + "</td>";

                                    var count = parseFloat(obj.count).toFixed(2);
                                    if (count < 0 || count.toString() == "-0.00") {
                                        htmlData += "<td style='text-align: right; color: red;'>" + count.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                    }
                                    else {
                                        htmlData += "<td style='text-align: right;'>" + count.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                    }

                                    var summary = parseFloat(obj.summary).toFixed(2);
                                    if (summary < 0 || summary.toString() == "-0.00") {
                                        htmlData += "<td style='text-align: right; color: red;'>" + summary.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                    }
                                    else {
                                        htmlData += "<td style='text-align: right;'>" + summary.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                    }

                                    htmlData += "</tr>";
                                }
                                htmlFooter += "<tr><td></td><td></td><td></td><td></td></tr>";
                            }
                            else {
                                htmlData += "<tr><td colspan='4' style='text-align: center;' set-lan='text:No Data.'></td></tr>";
                                htmlFooter += "<tr><td></td><td></td><td></td><td></td></tr>";
                            }

                            var arrData = dataTotal.list;
                            if (arrData.length > 0) {
                                for (var i = 0; i < arrData.length; i++) {
                                    var obj = arrData[i];
                                    htmlDataDEPOSIT += "<tr>";
                                    htmlDataDEPOSIT += "<td style='text-align: center;'>" + (((parseInt(NumPage) - 1) * 100) + no) + "</td>";
                                    htmlDataDEPOSIT += "<td style='text-align: center;'>" + obj.bankName + "</td>";
                                    htmlDataDEPOSIT += "<td style='text-align: left;'><p class='overflowTable ellipsis' title='" + obj.username + "'>" + obj.username + "</p></td>";

                                    var value = parseFloat(obj.value).toFixed(2);
                                    if (value < 0 || value.toString() == "-0.00") {
                                        htmlDataDEPOSIT += "<td style='text-align: right; color: red;'>" + value.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                    }
                                    else {
                                        htmlDataDEPOSIT += "<td style='text-align: right;'>" + value.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                    }

                                    htmlDataDEPOSIT += "<td style='text-align: center;'>" + obj.type + "</td>";

                                    var createDate = new Date(obj.createDate);
                                    var txtcreateDate = ("0" + createDate.getDate()).slice(-2) + "-" + ("0" + (createDate.getMonth() + 1)).slice(-2) + "-" + ("0" + createDate.getFullYear()).slice(-2) + " " + ("0" + createDate.getHours()).slice(-2) + ":" + ("0" + createDate.getMinutes()).slice(-2) + ":" + ("0" + createDate.getSeconds()).slice(-2);
                                    htmlDataDEPOSIT += "<td style='text-align: center;'>" + txtcreateDate + "</td>";

                                    htmlDataDEPOSIT += "<td style='text-align: center;'>" + obj.status + "</td>";

                                    //if (obj.actionBy.name != null && obj.actionBy.name != "") {
                                    //    htmlDataDEPOSIT += "<td style='text-align: left;'><p class='overflowTable ellipsis' title='" + obj.actionBy.name + "'>" + obj.actionBy.name + "</p></td>";
                                    //}
                                    //else {
                                    //    htmlDataDEPOSIT += "<td style='text-align: left;'><p class='overflowTable ellipsis'>-</p></td>";
                                    //}

                                    htmlDataDEPOSIT += "<td style='text-align: left;'>" + obj.remark + "</td>";
                                    htmlDataDEPOSIT += "</tr>";
                                    no++;
                                }
                                htmlFooterDEPOSIT += "<tr><td></td><td></td><td>Total :</td><td> " + dataTotal.summary + "</td><td></td><td></td><td></td><td></td></tr>";
                            }
                            else {
                                htmlDataDEPOSIT += "<tr><td colspan='8' style='text-align: center;' set-lan='text:No Data.'></td></tr>";
                                htmlFooterDEPOSIT += "<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>";
                            }

                            $("#tbDataWITHDRAW_Summary > tbody").append(htmlData);
                            $("#tbDataWITHDRAW_Summary > tfoot").append(htmlFooter);
                            $("#tbDataWITHDRAW > tbody").append(htmlDataDEPOSIT);
                            $("#tbDataWITHDRAW > tfoot").append(htmlFooterDEPOSIT);
                            $("#WITHDRAW").css("display", "initial");
                            $(".btnPrevious").css("display", "flex");
                        }
                        else if ($("#ddlType").val() == "AFFILIATE") {
                            if (dataTotal.profile != null && dataTotal.profile != undefined) {
                                var objData = dataTotal.profile;
                                $("#name").text(objData.name);
                                $("#walletMain").text(objData.walletMain);
                                $("#walletWinLose").text(objData.walletWinLose);
                                $("#shareHolderLineName").text(objData.shareHolderLineName);
                                $("#walletTransfer").text(objData.walletTransfer);
                                $("#walletCommission").text(objData.walletCommission);

                                var arrList = dataTotal.list;
                                if (arrList.length > 0) {
                                    for (var i = 0; i < arrList.length; i++) {
                                        var obj = arrList[i];
                                        htmlData += "<tr>";
                                        htmlData += "<td style='text-align: center;'>" + (((parseInt(NumPage) - 1) * 100) + no) + "</td>";
                                        htmlData += "<td style='text-align: center;'>" + obj.usernameCustomer + "</td>";

                                        var value = parseFloat(obj.value).toFixed(2);
                                        if (value < 0 || value.toString() == "-0.00") {
                                            htmlData += "<td style='text-align: right; color: red;'>" + value.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                        }
                                        else {
                                            htmlData += "<td style='text-align: right;'>" + value.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                                        }

                                        var createDate = new Date(obj.createDate);
                                        var txtcreateDate = ("0" + createDate.getDate()).slice(-2) + "-" + ("0" + (createDate.getMonth() + 1)).slice(-2) + "-" + ("0" + createDate.getFullYear()).slice(-2) + " " + ("0" + createDate.getHours()).slice(-2) + ":" + ("0" + createDate.getMinutes()).slice(-2) + ":" + ("0" + createDate.getSeconds()).slice(-2);
                                        htmlData += "<td style='text-align: center;'>" + txtcreateDate + "</td>";

                                        htmlData += "<td style='text-align: center;'>" + obj.type + "</td>";
                                        htmlData += "<td style='text-align: center;'>" + obj.status + "</td>";
                                        htmlData += "</tr>";
                                        no++;
                                    }
                                    htmlFooter += "<tr><td></td><td></td><td></td><td></td><td></td><td></td></tr>";
                                }
                                else {
                                    htmlData += "<tr><td colspan='6' style='text-align: center;' set-lan='text:No Data.'></td></tr>";
                                    htmlFooter += "<tr><td></td><td></td><td></td><td></td><td></td><td></td></tr>";
                                }
                            }
                            else {
                                $("#name").text("-");
                                $("#walletMain").text("-");
                                $("#walletWinLose").text("-");
                                $("#shareHolderLineName").text("-");
                                $("#walletTransfer").text("-");
                                $("#walletCommission").text("-");

                                htmlData += "<tr><td colspan='6' style='text-align: center;' set-lan='text:No Data.'></td></tr>";
                                htmlFooter += "<tr><td></td><td></td><td></td><td></td><td></td><td></td></tr>";
                            }

                            $("#tbDataAFFILIATE > tbody").append(htmlData);
                            $("#tbDataAFFILIATE > tfoot").append(htmlFooter);
                            $("#AFFILIATE").css("display", "initial");
                            $(".btnPrevious").css("display", "flex");
                        }

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
