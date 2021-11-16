<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Report.aspx.cs" Inherits="Support_Project.Menu_Casino.Report" %>

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
            <h1 set-lan="text:Casino"></h1>
        </div>
    </div>
    <div class="btn-toolbar section-group" role="toolbar" style="padding-left: 2.5rem;">
        <div class="col-md-12 row">
            <div class="row">
                <label for="email" class="col-form-label" set-lan="text:Bet ID_"></label>
                <div style="padding-left: 1rem;">
                    <input type="text" class="form-control" id="searchBetID" set-lan="placeholder:Bet ID" onkeyup="inputKeyUp(event)" />
                </div>
            </div>
            <div class="row" style="margin-left: 2.5rem;">
                <label for="email" class="col-form-label" set-lan="html:Username_"></label>
                <div style="padding-left: 1rem;">
                    <input type="text" class="form-control" id="searchUsername" set-lan="placeholder:Username" onkeyup="inputKeyUp(event)" />
                </div>
            </div>
            <%--<div class="row" style="padding-left: 2.5rem;">
                <label for="email" class="col-form-label alignright">
                    <label style='color: red;'>*</label>Type :</label>
                <div style="padding-left: 1rem;" class="select-outline">
                    <select name="" id="ddlType" class="mdb-select" data-live-search="true" searchable="Search here..">
                        <option value="" selected disabled>Select Type</option>
                        <option value="Sportbook">Sportbook</option>
                    </select>
                </div>
            </div>--%>
            <div class="row" style="padding-left: 2.5rem;">
                <label for="email" class="col-form-label alignright" set-lan="html:Agent__"></label>
                <div style="padding-left: 1rem;" class="select-outline">
                    <select name="" id="ddlAgent" class="mdb-select" data-live-search="true" searchable="Search here..">
                        <asp:Literal ID="LiteralDataDropdown" runat="server"></asp:Literal>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-md-12 row" style="margin-top: .5rem;">
            <div class="row fieldStart" style="">
                <label for="email" class="col-form-label" set-lan="text:Start date_"></label>
                <div style="padding-left: 1rem;" class="input-wrapper">
                    <i class="fas fa-calendar-alt iconCalendar"></i>
                    <input type="date" data-date="" id="startdate" class="testDate form-control" data-date-format="DD-MM-YYYY" style="width: 130px;" />
                </div>
            </div>
            <div class="row input-wrapper" style="padding-left: 2rem;">
                <i class="fa fa-clock iconTime"></i>
                <input type="time" data-date="" class="testDate form-control" id="starttime" data-date-format="hh:mm A" style="width: 120px;">
            </div>
            <div class="row" style="padding-left: 3.9rem;">
                <label for="email" class="col-form-label" set-lan="text:To date_"></label>
                <div style="padding-left: 1rem;" class="input-wrapper">
                    <i class="fas fa-calendar-alt iconCalendar"></i>
                    <input type="date" data-date="" id="todate" class="testDate form-control" data-date-format="DD-MM-YYYY" style="width: 130px;" />
                </div>
            </div>
            <div class="row input-wrapper" style="padding-left: 2rem;">
                <i class="fa fa-clock iconTime"></i>
                <input type="time" data-date="" class="testDate form-control" id="totime" data-date-format="hh:mm A" style="width: 120px;">
            </div>
            <div class="row" style="padding-left: 2.5rem;">
                <button class="btn btn-yellow font-weight-bold m-0 px-3 py-2 z-depth-0 waves-effect btnMenu" type="button" onclick="Search_Click('','')" set-lan="text:Search"></button>
            </div>
        </div>
    </div>
    <div id="zonePlsSearch" class="btn-toolbar section-group" role="toolbar" style="margin-top: 1rem; padding-top: 2rem; font-weight: bold; background-color: #dee2e6;">
        <p class="col-12" style="text-align: center; color: #333;" set-lan="text:Please enter search."></p>
    </div>
    <div class="table-wrapper" style="margin-top: 1rem; margin-bottom: 1rem; display: none;" id="zoneSearch">
        <div class="row" style="margin-bottom: 1rem; margin-top: 1rem;">
            <div class="col-8">
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
            <div class="col-4">
                <div id="wrapper" style="float: right;">
                    <section>
                        <div class="data-container"></div>
                        <div id="pagination-demo2"></div>
                    </section>
                </div>
            </div>
        </div>
        <table class="table table-border" id="tbDataSportbook">
            <thead class="rgba-green-slight">
                <tr>
                    <th style="width: 10%;" set-lan="text:Bet ID"></th>
                    <th style="width: 5%;" set-lan="text:Username"></th>
                    <th style="width: 10%;" set-lan="text:Start Date"></th>
                    <th style="width: 10%;" set-lan="text:End Date"></th>
                    <th style="width: 10%;" set-lan="text:Production"></th>
                    <th style="width: 7%;" set-lan="text:Status"></th>
                    <th style="width: 9%;" set-lan="text:Bet Amount"></th>
                    <th style="width: 13%;" set-lan="text:Game ID"></th>
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
    <div class="modal fade" id="modalGetDetail" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold" set-lan="text:Detail"></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-3">
                    <table class="table table-border" id="tbDetail">
                        <thead class="rgba-green-slight">
                            <tr>
                                <th set-lan="text:Bet ID"></th>
                                <th set-lan="text:Username"></th>
                                <th set-lan="text:Game ID"></th>
                                <th set-lan="text:Tx ID"></th>
                                <th set-lan="text:Bet Amount"></th>
                                <th set-lan="text:Actions"></th>
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
                <div class="modal-footer d-flex justify-content-center">
                    <button type="button" class="btn btn-yellow font-weight-bold waves-effect waves-light" data-dismiss="modal" aria-label="Close" set-lan="text:Close"></button>
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
        var NumPage = 1;
        var agent = "";
        var typeTime = "Day";
        var apiCancel = [{
            "name": "123BET",
            "url": "https://123bet-agent.askmebet.cloud"
        },
        {
            "name": "1819BET",
            "url": "https://1819bet-agent.askmebet.cloud"
        },
        {
            "name": "1FAZBET",
            "url": "https://1fazbet-agent.askmebet.cloud"
        },
        {
            "name": "2499VIP",
            "url": "https://2499vip-agent.askmebet.cloud"
        },
        {
            "name": "456BET",
            "url": "https://456bett-agent.askmebet.cloud"
        },
        {
            "name": "5GBET",
            "url": "https://5gbet-agent.askmebet.cloud"
        },
        {
            "name": "777WINBAR",
            "url": "https://777winbar-agent.askmebet.cloud"
        },
        {
            "name": "789BET",
            "url": "https://789betting-agent.askmebet.cloud"
        },
        {
            "name": "ABC88",
            "url": "https://abcgame88-agent.askmebet.cloud"
        },
        {
            "name": "AFC",
            "url": "https://afc1688-agent.askmebet.cloud"
        },
        {
            "name": "ALLSTAR",
            "url": "https://allstar55-agent.askmebet.cloud"
        },
        {
            "name": "AMB",
            "url": "https://ambbet-agent.askmebet.cloud"
        },
        {
            "name": "Ambet",
            "url": "https://ambet123-agent.askmebet.cloud"
        },
        {
            "name": "AMGOAL",
            "url": "https://amgoal-agent.askmebet.cloud"
        },
        {
            "name": "ASAWIN88",
            "url": "https://asawin-agent.askmebet.cloud"
        },
        {
            "name": "BCLUB",
            "url": "https://bclub-agent.askmebet.cloud"
        },
        {
            "name": "BEIN",
            "url": "https://bein88-agent.askmebet.cloud"
        },
        {
            "name": "BOZZ",
            "url": "https://bozz1688-agent.askmebet.cloud"
        },
        {
            "name": "BSB",
            "url": ""
        },
        {
            "name": "BWIN",
            "url": "https://guwin-agent.askmebet.cloud"
        },
        {
            "name": "COKE88",
            "url": "https://coke888-agent.askmebet.cloud"
        },
        {
            "name": "COVID",
            "url": "https://covidbet168-agent.askmebet.cloud"
        },
        {
            "name": "CSR",
            "url": "https://lucabet-agent.askmebet.cloud"
        },
        {
            "name": "CSRS",
            "url": "https://lucabets-agent.askmebet.cloud"
        },
        {
            "name": "DRAGON55",
            "url": "https://dragon55-agent.askmebet.cloud"
        },
        {
            "name": "FAST",
            "url": "https://fastbet98-agent.askmebet.cloud"
        },
        {
            "name": "FIN88",
            "url": "https://fin88-agent.askmebet.cloud"
        },
        {
            "name": "FOXZ",
            "url": "https://foxz168-agent.askmebet.cloud"
        },
        {
            "name": "G2G",
            "url": "https://g2gbet-agent.askmebet.cloud"
        },
        {
            "name": "GINZA",
            "url": "https://ginza1688-agent.askmebet.cloud"
        },
        {
            "name": "GOAL168",
            "url": ""
        },
        {
            "name": "GOAL6969",
            "url": "https://goal6969-agent.askmebet.cloud"
        },
        {
            "name": "HAFABET",
            "url": "https://hafabet-agent.askmebet.cloud"
        },
        {
            "name": "HENG168",
            "url": "https://dragonvip-agent.askmebet.cloud"
        },
        {
            "name": "2hilo",
            "url": "https://2hilo-agent.askmebet.cloud"
        },
        {
            "name": "IFM",
            "url": "https://ifm789plus-agent.askmebet.cloud"
        },
        {
            "name": "INWBALL",
            "url": "https://inwball-agent.askmebet.cloud"
        },
        {
            "name": "IPRO",
            "url": "https://iprobet-agent.askmebet.cloud"
        },
        {
            "name": "IRONMAN",
            "url": "https://ironmanbet-agent.askmebet.cloud"
        },
        {
            "name": "ISB888",
            "url": "https://isb888-agent.askmebet.cloud"
        },
        {
            "name": "IWANT",
            "url": "https://iwantbet-agent.askmebet.cloud"
        },
        {
            "name": "KINGCLUB",
            "url": "https://kingclub33-agent.askmebet.cloud"
        },
        {
            "name": "KKWVIP",
            "url": "https://kkwvip-agent.askmebet.cloud"
        },
        {
            "name": "LUCIABET",
            "url": "https://luciabet-agent.askmebet.cloud"
        },
        {
            "name": "LUCKYPRO",
            "url": "https://luckypro-agent.askmebet.cloud"
        },
        {
            "name": "MABET",
            "url": "https://mabet68-agent.askmebet.cloud"
        },
        {
            "name": "MAHAGAME66",
            "url": "https://mahagame66-agent.askmebet.cloud"
        },
        {
            "name": "MBK",
            "url": "https://mbk168-agent.askmebet.cloud"
        },
        {
            "name": "MCB168",
            "url": "https://mcb168bet-agent.askmebet.cloud"
        },
        {
            "name": "ME24",
            "url": "https://vr-agent.askmebet.cloud"
        },
        {
            "name": "MGM",
            "url": "https://mgm99win-agent.askmebet.cloud"
        },
        {
            "name": "MSCWIN",
            "url": "https://mscwin-agent.askmebet.cloud"
        },
        {
            "name": "MVP",
            "url": "https://mvpatm168-agent.askmebet.cloud"
        },
        {
            "name": "N88",
            "url": "https://n88bet-agent.askmebet.cloud"
        },
        {
            "name": "NAZA",
            "url": "https://naza-agent.askmebet.cloud"
        },
        {
            "name": "NAZABET",
            "url": "https://nazaagent-agent.askmebet.cloud"
        },
        {
            "name": "NIGOAL",
            "url": "https://nigoal-agent.askmebet.cloud"
        },
        {
            "name": "OMG",
            "url": "https://omgbet888-agent.askmebet.cloud"
        },
        {
            "name": "OSGAME",
            "url": "https://allbets-agent.askmebet.cloud"
        },
        {
            "name": "PAPA",
            "url": "https://papabet-agent.askmebet.cloud"
        },
        {
            "name": "PD99BET",
            "url": "https://pd99bet-agent.askmebet.cloud"
        },
        {
            "name": "PLAYONEBET",
            "url": ""
        },
        {
            "name": "POGBA",
            "url": "https://pogbabet-agent.askmebet.cloud"
        },
        {
            "name": "POPZA",
            "url": "https://popza24-agent.askmebet.cloud"
        },
        {
            "name": "PREMIRE",
            "url": "https://premier888-agent.askmebet.cloud"
        },
        {
            "name": "ROMAN",
            "url": "https://romanbets-agent.askmebet.cloud"
        },
        {
            "name": "S2K",
            "url": "https://s2kbet-agent.askmebet.cloud"
        },
        {
            "name": "SAND1988",
            "url": "https://sand1988-agent.askmebet.cloud"
        },
        {
            "name": "SAND333",
            "url": "https://sand333-agent.askmebet.cloud"
        },
        {
            "name": "SB234",
            "url": "https://sb234-agent.askmebet.cloud"
        },
        {
            "name": "SBOCOPA",
            "url": "https://sbocopa-agent.askmebet.cloud"
        },
        {
            "name": "SCC",
            "url": "https://scc777-agent.askmebet.cloud"
        },
        {
            "name": "TNT911",
            "url": "https://tnt911-agent.askmebet.cloud"
        },
        {
            "name": "TT69",
            "url": "https://tt69bet-agent.askmebet.cloud"
        },
        {
            "name": "UBC",
            "url": ""
        },
        {
            "name": "UKINGBET",
            "url": "https://ukingbet-agent.askmebet.cloud"
        },
        {
            "name": "UZI",
            "url": "https://uzibet-agent.askmebet.cloud"
        },
        {
            "name": "VIEWBET",
            "url": "https://viewbet-agent.askmebet.cloud"
        },
        {
            "name": "VMAX",
            "url": "https://viewbet-agent.askmebet.cloud"
        },
        {
            "name": "VRC",
            "url": "https://vrcbet-agent.askmebet.cloud"
        },
        {
            "name": "WINBET",
            "url": "https://winbetth-agent.askmebet.cloud"
        },
        {
            "name": "WINGBET",
            "url": "https://wingbet-agent.askmebet.cloud"
        },
        {
            "name": "XMAX",
            "url": "https://xmax999-agent.askmebet.cloud"
        },
        {
            "name": "XYZBET",
            "url": "https://xyzbet-agent.askmebet.cloud"
        },
        {
            "name": "ZAMBA",
            "url": "https://zambabet-agent.askmebet.cloud"
        }]
        var token = "";
        $(document).ready(function () {
            $("#menuCasino > a").addClass("active");

            var date = new Date();
            var dateSet = date.getFullYear() + "-" + ("0" + (date.getMonth() + 1)).slice(-2) + "-" + ("0" + date.getDate()).slice(-2);
            $("#startdate").val(dateSet);
            $("#todate").val(dateSet);

            $('#starttime').val('00:00');
            var currenttime = ("0" + date.getHours()).slice(-2) + ":" + ("0" + date.getMinutes()).slice(-2);
            $('#totime').val(currenttime);

            $("input[type=date]").on("change", function () {
                this.setAttribute(
                    "data-date",
                    moment(this.value, "YYYY-MM-DD")
                    .format(this.getAttribute("data-date-format"))
                )
            }).trigger("change")

            $("input[type=time]").on("change", function () {
                this.setAttribute(
                    "data-date",
                    moment(this.value, "hh:mm A")
                    .format(this.getAttribute("data-date-format"))
                )
            }).trigger("change")

            var htmlCurAll = "<option value='' selected disabled set-lan='text:Select agent'></option>";
            $(htmlCurAll).insertBefore("#ddlAgent option:first");
            SetLan(localStorage.getItem("Language"));
        });

        function inputKeyUp(e) {
            e.which = e.which || e.keyCode;
            if (e.which == 13) {
                Search_Click('','');
            }
        }

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

        function Search_Click(start, end) {
            $("#myModalLoad").modal();

            var dateOne = "";
            var dateTwo = "";

            if (start == "" && end == "") {
                dateOne = $("#startdate").val() + " " + $("#starttime").val() + ":00";
                dateTwo = $("#todate").val() + " " + $("#totime").val() + ":00";
            }
            else {
                dateOne = start + " " + $("#starttime").val() + ":00";
                dateTwo = end + " " + $("#totime").val() + ":00";
            }

            var date1 = Date.parse(dateOne);
            var date2 = Date.parse(dateTwo);
            if (date1 > date2) {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:Field 'To Date' should be greater than 'Start Date'.");
                SetLan(localStorage.getItem("Language"));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else if ($("#ddlAgent").val() == "" || $("#ddlAgent").val() == null) {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:Please select agent.");
                SetLan(localStorage.getItem("Language"));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else {
                GetData();
            }
        }

        function GetData() {
            agent = $("#ddlAgent").val();
            $("#tbDataSportbook > tbody").html("");

            var dataAdd = new Object();
            if ($("#searchBetID").val() != "" && $("#searchBetID").val() != null) {
                dataAdd.betId = $("#searchBetID").val();
            }
            if ($("#searchUsername").val() != "" && $("#searchUsername").val() != null) {
                dataAdd.username = $("#searchUsername").val();
            }
            var txtDateStart = $('#startdate').val();
            var txtDateEnd = $('#todate').val();
            dataAdd.dateForm = txtDateStart.split('-')[2] + "/" + txtDateStart.split('-')[1] + "/" + txtDateStart.split('-')[0];
            dataAdd.dateTo = txtDateEnd.split('-')[2] + "/" + txtDateEnd.split('-')[1] + "/" + txtDateEnd.split('-')[0];
            dataAdd.agent = agent;
            dataAdd.page = NumPage.toString();
            dataAdd.limit = "100";
            $.ajax({
                url: "https://support-sportbook-api.secure-restapi.com/casino/findTicketRunningByBet",
                type: 'POST',
                dataType: 'json',
                data: JSON.stringify(dataAdd),
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    if (data.code == 0 || data.code == null) {
                        if (data.result.code > 0) {
                            document.getElementById('lbAlert').innerHTML = data.result.message;
                            $("#myModalLoad").modal('hide');
                            $('#modalAlert').modal('show');
                        }
                        else {
                            $("#zonePlsSearch").css("display", "none");
                            $("#zoneSearch").css("display", "initial");
                            var result = data.result.result.total;
                            GetNumPage(result);
                        }
                    }
                    else {
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

        function GetNumPage(TotalData) {
            $(function () {
                (function (name) {
                    var container = $('#pagination-' + name);
                    container.pagination({
                        totalNumber: TotalData,
                        pageNumber: NumPage,
                        pageSize: 100,
                        dataSource: 'https://api.flickr.com/services/feeds/photos_public.gne?tags=cat&tagmode=any&format=json&jsoncallback=?',
                        locator: 'items',
                        //callback: function (response, pagination) {
                        //    NumPage = container.pagination('getSelectedPageNum');
                        //    GetData2(TotalData, NumPage);
                        //}
                        beforePageOnClick: function (response, pagination) {
                            NumPage = pagination;
                        },
                        afterPageOnClick: function (response, pagination) {
                            GetData2(TotalData, NumPage);
                        },

                        beforeNextOnClick: function (response, pagination) {
                            NumPage = pagination;
                        },
                        afterNextOnClick: function (response, pagination) {
                            GetData2(TotalData, NumPage);
                        },

                        beforePreviousOnClick: function (response, pagination) {
                            NumPage = pagination;
                        },
                        afterPreviousOnClick: function (response, pagination) {
                            GetData2(TotalData, NumPage);
                        },
                    });
                })('demo2');
            });
        }

        function GetData2(TotalData, numPage) {
            agent = $("#ddlAgent").val();
            $("#tbDataSportbook > tbody").html("");

            var dataAdd = new Object();
            if ($("#searchBetID").val() != "" && $("#searchBetID").val() != null) {
                dataAdd.betId = $("#searchBetID").val();
            }
            if ($("#searchUsername").val() != "" && $("#searchUsername").val() != null) {
                dataAdd.username = $("#searchUsername").val();
            }
            var txtDateStart = $('#startdate').val();
            var txtDateEnd = $('#todate').val();
            dataAdd.dateForm = txtDateStart.split('-')[2] + "/" + txtDateStart.split('-')[1] + "/" + txtDateStart.split('-')[0];
            dataAdd.dateTo = txtDateEnd.split('-')[2] + "/" + txtDateEnd.split('-')[1] + "/" + txtDateEnd.split('-')[0];
            dataAdd.agent = agent;
            dataAdd.page = numPage.toString();
            dataAdd.limit = "100";
            $.ajax({
                url: "https://support-sportbook-api.secure-restapi.com/casino/findTicketRunningByBet",
                type: 'POST',
                dataType: 'json',
                data: JSON.stringify(dataAdd),
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    if (data.code == 0 || data.code == null) {
                        if (data.result.code == 0) {
                            var dataTotal = data.result.result.betList;
                            var htmlData = "";
                            if (dataTotal.length > 0 && dataTotal != "") {
                                for (var i = 0; i < dataTotal.length; i++) {
                                    var obj = dataTotal[i];
                                    if (obj != null) {
                                        htmlData += "<tr>";
                                        htmlData += "<td class='aligncenter'>" + obj.betId + "</td>";
                                        htmlData += "<td><p class='overflowTable ellipsis' title='" + obj.memberUsername + "'>" + obj.memberUsername + "</p></td>";

                                        var createDate = new Date(obj.createdDate);
                                        var txtcreateDate = ("0" + createDate.getDate()).slice(-2) + "-" + ("0" + (createDate.getMonth() + 1)).slice(-2) + "-" + ("0" + createDate.getFullYear()).slice(-2) + " " + ("0" + createDate.getHours()).slice(-2) + ":" + ("0" + createDate.getMinutes()).slice(-2) + ":" + ("0" + createDate.getSeconds()).slice(-2);
                                        htmlData += "<td class='aligncenter'>" + txtcreateDate + "</td>";

                                        var gameDate = new Date(obj.gameDate);
                                        var txtgameDate = ("0" + gameDate.getDate()).slice(-2) + "-" + ("0" + (gameDate.getMonth() + 1)).slice(-2) + "-" + ("0" + gameDate.getFullYear()).slice(-2) + " " + ("0" + gameDate.getHours()).slice(-2) + ":" + ("0" + gameDate.getMinutes()).slice(-2) + ":" + ("0" + gameDate.getSeconds()).slice(-2);
                                        htmlData += "<td class='aligncenter'>" + txtgameDate + "</td>";

                                        htmlData += "<td class='aligncenter'>" + obj.source + "</td>";
                                        htmlData += "<td class='aligncenter'>" + obj.status + "</td>";

                                        var betAmount = parseFloat(obj.amount).toFixed(2);
                                        htmlData += "<td class='alignright'>" + betAmount.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";

                                        if (obj.source == "SEXY_BACCARAT") {
                                            var objTxns = obj.detailTicket.txns;
                                            var array = [];
                                            for (var x = 0; x < objTxns.length; x++) {
                                                var arrTotal = [];
                                                arrTotal.push(objTxns[x].betAmount.toString());
                                                arrTotal.push(objTxns[x].txId);
                                                array.push(arrTotal.join('/').toString());
                                            }
                                            if (array != "") {
                                                htmlData += "<td class='aligncenter'><a class='link linkClick' onclick='getDetail(\"" + array + "\", \"" + obj.betId + "\", \"" + obj.detailTicket.roundId + "\", \"" + obj.memberUsername + "\");'>" + obj.detailTicket.roundId + "</a></td>";
                                            }
                                            else {
                                                htmlData += "<td class='aligncenter'><a class='link linkClick'>" + obj.detailTicket.roundId + "</a></td>";
                                            }
                                        }
                                        else {
                                            var objTxns = obj.detailTicket.txns;
                                            var array = [];
                                            for (var x = 0; x < objTxns.length; x++) {
                                                var arrTotal = [];
                                                if (obj.source == "PRETTY_GAME") {
                                                    arrTotal.push(objTxns[x].betAmt.toString());
                                                }
                                                else {
                                                    arrTotal.push(objTxns[x].betAmount.toString());
                                                }

                                                if (obj.source == "PRETTY_GAME") {
                                                    arrTotal.push(objTxns[x].txtId);
                                                }
                                                else {
                                                    arrTotal.push(objTxns[x].txnId);
                                                }

                                                array.push(arrTotal.join('/').toString());
                                            }
                                            if (array != "") {
                                                htmlData += "<td class='aligncenter'><a class='link linkClick' onclick='getDetail(\"" + array + "\", \"" + obj.betId + "\", \"" + obj.detailTicket.gameId + "\", \"" + obj.memberUsername + "\");'>" + obj.detailTicket.gameId + "</a></td>";
                                            }
                                            else {
                                                htmlData += "<td class='aligncenter'><a class='link linkClick'>" + obj.detailTicket.gameId + "</a></td>";
                                            }
                                        }
                                        htmlData += "</tr>";
                                    }
                                }
                            }
                            else {
                                htmlData += "<tr><td colspan='8' style='text-align: center;' set-lan='text:No Data.'></td></tr>";
                            }

                            $("#tbDataSportbook > tbody").append(htmlData);
                            SetLan(localStorage.getItem("Language"));
                            $("#myModalLoad").modal('hide');
                        }
                        else {
                            document.getElementById('lbAlert').innerHTML = data.result.message;
                            var htmlData = "";
                            htmlData += "<tr><td colspan='8' style='text-align: center;' set-lan='text:No Data.'></td></tr>";
                            $("#tbDataSportbook > tbody").append(htmlData);
                            SetLan(localStorage.getItem("Language"));
                            $("#myModalLoad").modal('hide');
                            $('#modalAlert').modal('show');
                        }
                    }
                    else {
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

        function getDetail(obj, betID, gameID, username) {
            $("#myModalLoad").modal();
            var Arr = obj.split(',');
            $("#tbDetail > tbody").html("");
            var htmlData = "";
            if (Arr.length > 0) {
                for (var x = 0; x < Arr.length; x++) {
                    htmlData += "<tr>";
                    htmlData += "<td class='aligncenter'>" + betID + "</td>";
                    htmlData += "<td class='aligncenter'>" + username + "</td>";
                    htmlData += "<td class='aligncenter'>" + gameID + "</td>";
                    htmlData += "<td class='aligncenter'>" + Arr[x].split('/')[1] + "</td>";
                    var betAmount = parseFloat(Arr[x].split('/')[0]).toFixed(2);
                    htmlData += "<td class='aligncenter'>" + betAmount.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + "</td>";
                    if ($('#<%=IDRole.ClientID%>').val() == "Master" || $('#<%=IDRole.ClientID%>').val() == "Super User" || $('#<%=IDRole.ClientID%>').val() == "Lead") {
                        htmlData += "<td class='aligncenter'><a class='link linkCancel' onclick='getCancel(\"" + betAmount.toString() + "\",\"" + betID + "\",\"" + gameID + "\",\"" + username + "\");'>Cancel</td>";
                    }
                    else {
                        htmlData += "<td class='aligncenter'><a class='link disabled-link'>Cancel</td>";
                    }
                    htmlData += "</tr>";
                }
            }
            else {
                htmlData += "<tr><td colspan='6' style='text-align: center;' set-lan='text:No Data.'></td></tr>";
            }
            $("#tbDetail > tbody").append(htmlData);

            if ($('#<%=IDRole.ClientID%>').val() != "Master" && $('#<%=IDRole.ClientID%>').val() != "Super User" && $('#<%=IDRole.ClientID%>').val() != "Lead") {

            }

            SetLan(localStorage.getItem("Language"));
            $("#modalGetDetail").modal();
            $("#myModalLoad").modal('hide');
        }

        function getCancel(betAmount, BetID, GameID, Username) {
            var dataAdd = new Object();
            dataAdd.amount = betAmount;
            dataAdd.betId = BetID;
            dataAdd.gameId = GameID;
            dataAdd.username = Username;

            var resultApiCancel = apiCancel.filter(x => x.name === agent);
            //console.log(resultApiCancel[0].url);
            //console.log(result);

            $.ajax({
                url: resultApiCancel[0].url + "/spa/support/clear-ticket-running",
                type: 'POST',
                dataType: 'json',
                data: JSON.stringify(dataAdd),
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    if (data.code == 0 || data.code == null) {
                        document.getElementById("lbAlert").setAttribute("set-lan", "text:Cancel bet ID success.");
                        SetLan(localStorage.getItem('Language'));
                        $('#modalAlert').modal('show');
                        $("#myModalLoad").modal('hide');
                        setTimeout(function () {
                            location.reload();
                        }, 1500);
                    }
                    else {
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
