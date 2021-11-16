<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Report.aspx.cs" Inherits="Support_Project.Menu_Dasboard.Report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .imgShow {
            width: 100%;
            height: 135px;
            margin-bottom: 1rem;
        }

        #overlay2 {
            position: absolute;
            top: 0%;
            left: 19%;
            position: fixed;
            width: 60%;
            height: 100%;
            background: rgba(0,0,0,0.8) none 50% / contain no-repeat;
            cursor: pointer;
            transition: 0.3s;
            visibility: hidden;
            opacity: 0;
        }

            #overlay2.open {
                visibility: visible;
                opacity: 1;
                z-index: 999;
            }

            #overlay2:after { /* X button icon */
                content: "\2715";
                position: absolute;
                color: #fff;
                top: 10px;
                right: 20px;
                font-size: 2em;
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
            width: 7em;
            white-space: nowrap;
            overflow: hidden;
            font-size: 0.8rem;
        }

        .overflowTableS {
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

        .inbox_people {
            background: #f8f8f8 none repeat scroll 0 0;
            float: left;
            overflow: hidden;
            width: 40%;
            border-right: 1px solid #c4c4c4;
        }

        .inbox_msg {
            border: 1px solid #c4c4c4;
            clear: both;
            overflow: hidden;
        }

        .top_spac {
            margin: 20px 0 0;
        }


        .recent_heading {
            float: left;
            width: 40%;
        }

        .srch_bar {
            display: inline-block;
            text-align: right;
            width: 60%;
            padding:;
        }

        .headind_srch {
            padding: 10px 29px 10px 20px;
            overflow: hidden;
            border-bottom: 1px solid #c4c4c4;
        }

        .recent_heading h4 {
            color: #05728f;
            font-size: 21px;
            margin: auto;
        }

        .srch_bar input {
            border: 1px solid #cdcdcd;
            border-width: 0 0 1px 0;
            width: 80%;
            padding: 2px 0 4px 6px;
            background: none;
        }

        .srch_bar .input-group-addon button {
            background: rgba(0, 0, 0, 0) none repeat scroll 0 0;
            border: medium none;
            padding: 0;
            color: #707070;
            font-size: 18px;
        }

        .srch_bar .input-group-addon {
            margin: 0 0 0 -27px;
        }

        .chat_ib h5 {
            font-size: 15px;
            color: #464646;
            margin: 0 0 8px 0;
        }

            .chat_ib h5 span {
                font-size: 13px;
                float: right;
            }

        .chat_ib p {
            font-size: 14px;
            color: #989898;
            margin: auto;
        }

        .chat_img {
            float: left;
            width: 11%;
        }

        .chat_ib {
            float: left;
            padding: 0 0 0 15px;
            width: 88%;
        }

        .chat_people {
            overflow: hidden;
            clear: both;
        }

        .chat_list {
            border-bottom: 1px solid #c4c4c4;
            margin: 0;
            padding: 18px 16px 10px;
        }

        .inbox_chat {
            height: 550px;
            overflow-y: scroll;
        }

        .active_chat {
            background: #ebebeb;
        }

        .incoming_msg, .outgoing_msg {
            margin-bottom: 1rem;
        }

        .incoming_msg_img > p {
            text-align: left;
            margin-bottom: 8px !important;
            font-weight: bold;
        }

        .received_msg {
            display: inline-block;
            vertical-align: top;
            width: 100%;
        }

        .received_withd_msg p {
            background: #ebebeb none repeat scroll 0 0;
            border-radius: 3px;
            color: #646464;
            font-size: 14px;
            margin: 0;
            padding: 5px 10px 5px 12px;
            width: 100%;
        }

        .time_date {
            color: #747474;
            display: block;
            font-size: 12px;
            margin: 8px 0 0;
        }

        .received_withd_msg {
            width: 57%;
            text-align: left;
            word-break: break-word;
        }

        .mesgs {
            float: left;
            padding-left: 1rem;
            padding-right: 1rem;
            background-color: #ddd;
            width: 100%;
            margin-bottom: 1rem;
            height: 375px;
            overflow: auto;
            padding-top: 1rem;
        }

        .sent_msg p {
            background: #05728f none repeat scroll 0 0;
            border-radius: 3px;
            font-size: 14px;
            margin: 0;
            color: #fff;
            padding: 5px 10px 5px 12px;
            width: 100%;
        }

        .outgoing_msg {
            overflow: hidden;
            margin: 26px 0 26px;
        }

        .sent_msg {
            float: right;
            width: 46%;
            text-align: right;
            word-break: break-word;
        }

        .input_msg_write input {
            background: rgba(0, 0, 0, 0) none repeat scroll 0 0;
            border: medium none;
            color: #4c4c4c;
            font-size: 15px;
            min-height: 48px;
            width: 100%;
        }

        .type_msg {
            border-top: 1px solid #c4c4c4;
            position: relative;
        }

        .msg_send_btn {
            background: #05728f none repeat scroll 0 0;
            border: medium none;
            border-radius: 50%;
            color: #fff;
            cursor: pointer;
            font-size: 17px;
            height: 33px;
            position: absolute;
            right: 0;
            top: 11px;
            width: 33px;
        }

        .messaging {
            padding: 0 0 50px 0;
        }

        .msg_history {
            height: auto;
            overflow-y: auto;
        }

        .dot {
            height: 10px;
            width: 10px;
            background-color: red;
            border-radius: 50%;
            display: inline-block;
            margin-bottom: 4px;
            margin-left: -8px;
        }

        #overlay2Chat {
            position: absolute;
            top: 0%;
            left: 19%;
            position: fixed;
            width: 60%;
            height: 100%;
            background: rgba(0,0,0,0.8) none 50% / contain no-repeat;
            cursor: pointer;
            transition: 0.3s;
            visibility: hidden;
            opacity: 0;
        }

            #overlay2Chat.open {
                visibility: visible;
                opacity: 1;
                z-index: 999;
            }

            #overlay2Chat:after { /* X button icon */
                content: "\2715";
                position: absolute;
                color: #fff;
                top: 10px;
                right: 20px;
                font-size: 2em;
            }
    </style>
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="" set-lan="text:Dashboard"></a></li>
            <li class="breadcrumb-item active txtMem" set-lan="text:Task Tracking"></li>
        </ol>
    </nav>
    <div class="row">
        <div class="col-md-8">
            <h1 set-lan="text:Task Tracking"></h1>
        </div>
        <div class="col-md-4" style="text-align: right;">
            <a class="btn btn-primary" onclick="addDashboard()" style="color: #2F80ED !important; margin-right: 0.3rem;" set-lan="html:Add"></a>
        </div>
    </div>
    <div class="btn-toolbar section-group" role="toolbar" style="padding-left: 2.5rem;">
        <div class="col-md-12 row" style="margin-left: 0.7rem;">
            <div class="row">
                <label for="email" class="col-form-label" set-lan="text:Search_"></label>
                <div style="padding-left: 1rem;">
                    <asp:TextBox ID="searchProduct" class="form-control" autocomplete="off" runat="server" set-lan="placeholder:Product / Agent / Prefix" />
                </div>
            </div>
            <div class="row" style="padding-left: 2.5rem;">
                <label for="email" class="col-form-label alignright" set-lan="text:Category_"></label>
                <div style="padding-left: 1rem;" class="select-outline">
                    <asp:DropDownList ID="ddlCategorySearch" runat="server" class="form-control" DataValueField="id" DataTextField="name">
                    </asp:DropDownList>
                </div>
            </div>
            <div class="row" style="padding-left: 2.5rem;">
                <label for="email" class="col-form-label alignright" set-lan="text:Status_"></label>
                <div style="padding-left: 1rem;" class="select-outline">
                    <asp:DropDownList ID="ddlStatus" runat="server" class="form-control">
                        <asp:ListItem Value="" set-lan="text:All"></asp:ListItem>
                        <asp:ListItem Value="new" set-lan="text:New"></asp:ListItem>
                        <asp:ListItem Value="open" set-lan="text:Open"></asp:ListItem>
                        <asp:ListItem Value="waiting" set-lan="text:Waiting"></asp:ListItem>
                        <asp:ListItem Value="done" set-lan="text:Done"></asp:ListItem>
                        <asp:ListItem Value="cancel" set-lan="text:Cancel"></asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="row" style="padding-left: 1.8rem;">
                <label class="checkbox-inline" style="margin-left: 1rem;">
                    <input type="checkbox" class="chk" id="chkMyTask">
                    <label style="margin-left: .3rem;" class="col-form-label" set-lan="text:My task"></label>
                </label>
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
                <button class="btn btn-yellow font-weight-bold m-0 px-3 py-2 z-depth-0 waves-effect btnMenu" type="button" onclick="Search_Click('')" set-lan="text:Search"></button>
            </div>
        </div>
    </div>
    <div class="row" style="margin-top: 1rem;">
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
            <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="Search_click" autopostback="false" Style="display: none;" />
            <div class="table-wrapper" style="margin-top: 1rem; margin-bottom: 1rem;">
                <table class="table table-border" id="tbData">
                    <thead class="rgba-green-slight">
                        <tr>
                            <th style="width: 3%;" set-lan="text:No"></th>
                            <th style="width: 4%;" set-lan="text:Level"></th>
                            <th style="width: 6%;" set-lan="text:Ticket ID"></th>
                            <th style="width: 5%;" set-lan="text:Status"></th>
                            <th style="width: 9%;" set-lan="text:Product"></th>
                            <th style="width: 9%;" set-lan="text:Username (Troubled)"></th>
                            <th style="width: 9%;" set-lan="text:Ag / Pref"></th>
                            <th style="width: 6.5%;" set-lan="text:Categories"></th>
                            <th style="width: 10%;" set-lan="text:Created date"></th>
                            <th style="width: 8%;" set-lan="text:Created by"></th>
                            <th style="width: 7%;" set-lan="text:Pick up / Action by"></th>
                            <th style="width: 3.5%;" set-lan="text:Desc"></th>
                            <th style="width: 3.5%;" set-lan="text:Files"></th>
                            <th style="width: 5%;" set-lan="text:Pick up"></th>
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
            <asp:Button ID="btnCloseDashboard" class="btn btn-lg btn-yellow font-weight-bold btn-block" OnClick="CloseDashboard_click" runat="server" Text="Add" Style="display: none;" AutoPostBack="false" />
            <asp:Button ID="btnCancelDashboard" class="btn btn-lg btn-yellow font-weight-bold btn-block" OnClick="CancelDashboard_click" runat="server" Text="Add" Style="display: none;" />
            <asp:Button ID="btnCancelChat" class="btn btn-lg btn-yellow font-weight-bold btn-block" OnClick="CancelChat_click" runat="server" Text="Add" Style="display: none;" />
            <asp:Button ID="btnAddPickupDashboard" class="btn btn-lg btn-yellow font-weight-bold btn-block" OnClick="AddPickupDashboard_click" runat="server" Text="Add" Style="display: none;" />
            <asp:Button ID="btnChatDashboard" class="btn btn-lg btn-yellow font-weight-bold btn-block" OnClick="ChatDashboard_click" runat="server" Text="Add" Style="display: none;" AutoPostBack="false" />
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
    <div class="modal fade" id="modalAddDashboard" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold" id="txtModal" set-lan="text:Add Task Tracking"></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-3 text-center" style="height: 500px; overflow: auto;">
                    <div class="form-group row">
                        <label for="username" class="col-4 col-form-label" style="text-align: right;" set-lan="html:Product_v"></label>
                        <div class="col-8">
                            <asp:TextBox ID="product" class="form-control" autocomplete="off" runat="server" MaxLength="200" />
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="username" class="col-4 col-form-label" style="text-align: right;" set-lan="html:Agent / Prefix_v"></label>
                        <div class="col-8">
                            <asp:TextBox ID="agent" class="form-control" autocomplete="off" runat="server" MaxLength="200" />
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="username" class="col-4 col-form-label" style="text-align: right;" set-lan="html:Category_v"></label>
                        <div class="col-8 inModal">
                            <asp:DropDownList ID="ddlCategoryAdd" runat="server" class="form-control" DataValueField="id" DataTextField="name" AutoPostBack="false">
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="username" class="col-4 col-form-label" style="text-align: right;" set-lan="html:Level_v"></label>
                        <div class="col-8 inModal">
                            <asp:DropDownList ID="ddlLevelAdd" runat="server" class="form-control" DataValueField="id" DataTextField="name" AutoPostBack="false">
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="username" class="col-4 col-form-label" style="text-align: right;" set-lan="html:Website link (Troubled)_v"></label>
                        <div class="col-8">
                            <asp:TextBox ID="Website" class="form-control" autocomplete="off" runat="server" MaxLength="255" />
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="username" class="col-4 col-form-label" style="text-align: right;" set-lan="html:Username (Troubled)_v"></label>
                        <div class="col-8">
                            <asp:TextBox ID="Username" class="form-control" autocomplete="off" runat="server" MaxLength="255" />
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="username" class="col-4 col-form-label" style="text-align: right;" set-lan="html:Password (Troubled)_v"></label>
                        <div class="col-8">
                            <asp:TextBox ID="Password" class="form-control" autocomplete="off" runat="server" MaxLength="255" />
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="username" class="col-4 col-form-label" style="text-align: right;" set-lan="html:Problem_v"></label>
                        <div class="col-8">
                            <asp:TextBox runat="server" ID="Problem" TextMode="MultiLine" Rows="2" Style="resize: vertical;" class="form-control" autocomplete="off" MaxLength="255" onkeypress="return maxLengthfield(this,255);" />
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="username" class="col-4 col-form-label" style="text-align: right;" set-lan="html:Troubleshooting_v"></label>
                        <div class="col-8">
                            <asp:TextBox runat="server" ID="Troubleshooting" TextMode="MultiLine" Rows="2" Style="resize: vertical;" class="form-control" autocomplete="off" MaxLength="255" onkeypress="return maxLengthfield(this,255);" />
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="username" class="col-4 col-form-label" style="text-align: right;" set-lan="html:After first fixed_v"></label>
                        <div class="col-8">
                            <asp:TextBox runat="server" ID="Afterfirstfixed" TextMode="MultiLine" Rows="2" Style="resize: vertical;" class="form-control" autocomplete="off" MaxLength="255" onkeypress="return maxLengthfield(this,255);" />
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="username" class="col-4 col-form-label" style="text-align: right;" set-lan="text:Other_"></label>
                        <div class="col-8">
                            <asp:TextBox runat="server" ID="Other" TextMode="MultiLine" Rows="2" Style="resize: vertical;" class="form-control" autocomplete="off" MaxLength="255" onkeypress="return maxLengthfield(this,255);" />
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="username" class="col-4 col-form-label" style="text-align: right;" set-lan="text:Attach file_"></label>
                        <div class="col-8" style="display: inline-flex;">
                            <asp:FileUpload ID="AttahcFile1" runat="server" class="form-control" onchange="CheckExt(this)" />
                            <a style="font-size: 1.6rem; padding-left: .5rem;" class="link icon1" onclick="showAttach('2');"><i class="fas fa-plus-square" style="color: #CFA137;"></i></a>
                        </div>
                    </div>
                    <div class="form-group row attach2" style="display: none;">
                        <label for="username" class="col-4 col-form-label" style="text-align: right;" set-lan="text:Attach file_"></label>
                        <div class="col-8" style="display: inline-flex;">
                            <asp:FileUpload ID="AttahcFile2" runat="server" class="form-control" onchange="CheckExt(this)" />
                            <a style="font-size: 1.6rem; padding-left: .5rem;" class="link icon2" onclick="showAttach('3');"><i class="fas fa-plus-square" style="color: #CFA137;"></i></a>
                        </div>
                    </div>
                    <div class="form-group row attach3" style="display: none;">
                        <label for="username" class="col-4 col-form-label" style="text-align: right;" set-lan="text:Attach file_"></label>
                        <div class="col-8" style="display: inline-flex;">
                            <asp:FileUpload ID="AttahcFile3" runat="server" class="form-control" onchange="CheckExt(this)" />
                            <a style="font-size: 1.6rem; padding-left: .5rem;" class="link icon3" onclick="showAttach('4');"><i class="fas fa-plus-square" style="color: #CFA137;"></i></a>
                        </div>
                    </div>
                    <div class="form-group row attach4" style="display: none;">
                        <label for="username" class="col-4 col-form-label" style="text-align: right;" set-lan="text:Attach file_"></label>
                        <div class="col-8" style="display: inline-flex;">
                            <asp:FileUpload ID="AttahcFile4" runat="server" class="form-control" onchange="CheckExt(this)" />
                            <a style="font-size: 1.6rem; padding-left: .5rem;" class="link icon4" onclick="showAttach('5');"><i class="fas fa-plus-square" style="color: #CFA137;"></i></a>
                        </div>
                    </div>
                    <div class="form-group row attach5" style="display: none;">
                        <label for="username" class="col-4 col-form-label" style="text-align: right;" set-lan="text:Attach file_"></label>
                        <div class="col-8">
                            <asp:FileUpload ID="AttahcFile5" runat="server" class="form-control" onchange="CheckExt(this)" />
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="username" class="col-4 col-form-label" style="text-align: right;"></label>
                        <div class="col-8"><small class="text-muted form-text" style="text-align: left;" set-lan="text:Note: You can only upload a maximum of 5 files."></small></div>
                    </div>
                </div>
                <div class="modal-footer d-flex justify-content-center">
                    <button id="bAdd" class="btn btn-yellow font-weight-bold" onclick="SaveDashboard()" type="button" set-lan="text:Save" style="display: none;"></button>
                    <asp:Button ID="btnAddDashboard" class="btn btn-lg btn-yellow font-weight-bold btn-block" OnClick="AddDashboard_click" runat="server" Text="Add" Style="display: none;" />
                    <button type="button" class="btn btn-yellow font-weight-bold" data-dismiss="modal" aria-label="Close" set-lan="text:Close"></button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="modalGetDesc" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold" set-lan="text:Description"></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-4 text-center">
                    <div class="form-group row">
                        <label for="username" class="col-4 col-form-label" style="text-align: right;" set-lan="text:Ticket ID_"></label>
                        <div class="col-8">
                            <asp:TextBox ID="TicketIDView" class="form-control" autocomplete="off" runat="server" MaxLength="200" ReadOnly />
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="username" class="col-4 col-form-label" style="text-align: right;" set-lan="text:Website link (Troubled)_"></label>
                        <div class="col-8">
                            <asp:TextBox ID="WebsiteView" class="form-control" autocomplete="off" runat="server" MaxLength="200" ReadOnly />
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="username" class="col-4 col-form-label" style="text-align: right;" set-lan="text:Username (Troubled)_"></label>
                        <div class="col-8">
                            <asp:TextBox ID="UsernameView" class="form-control" autocomplete="off" runat="server" MaxLength="200" ReadOnly />
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="username" class="col-4 col-form-label" style="text-align: right;" set-lan="text:Password (Troubled)_"></label>
                        <div class="col-8">
                            <asp:TextBox ID="PasswordView" class="form-control" autocomplete="off" runat="server" MaxLength="200" ReadOnly />
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="username" class="col-4 col-form-label" style="text-align: right;" set-lan="text:Problem_"></label>
                        <div class="col-8">
                            <asp:TextBox runat="server" ID="ProblemView" TextMode="MultiLine" Rows="7" Style="resize: vertical;" class="form-control" autocomplete="off" MaxLength="255" ReadOnly />
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="username" class="col-4 col-form-label" style="text-align: right;" set-lan="text:Troubleshooting_"></label>
                        <div class="col-8">
                            <asp:TextBox runat="server" ID="TroubleshootingView" TextMode="MultiLine" Rows="2" Style="resize: vertical;" class="form-control" autocomplete="off" MaxLength="255" ReadOnly />
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="username" class="col-4 col-form-label" style="text-align: right;" set-lan="text:After first fixed_"></label>
                        <div class="col-8">
                            <asp:TextBox runat="server" ID="AfterfirstfixedView" TextMode="MultiLine" Rows="2" Style="resize: vertical;" class="form-control" autocomplete="off" MaxLength="255" ReadOnly />
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="username" class="col-4 col-form-label" style="text-align: right;" set-lan="text:Other_"></label>
                        <div class="col-8">
                            <asp:TextBox runat="server" ID="OtherView" TextMode="MultiLine" Rows="7" Style="resize: vertical;" class="form-control" autocomplete="off" MaxLength="255" ReadOnly />
                        </div>
                    </div>
                </div>
                <div class="modal-footer d-flex justify-content-center">
                    <button type="button" class="btn btn-yellow font-weight-bold" data-dismiss="modal" aria-label="Close" set-lan="text:Close"></button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="modalImage" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold" set-lan="text:Attach File"></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-3 text-center">
                    <div id="overlay2"></div>
                    <div class="row" id="imgShow">
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="modalPickupDashboard" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold" set-lan="text:Pick up"></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-3 text-center">
                    <div class="form-group row">
                        <label for="username" class="col-4 col-form-label" style="text-align: right;" set-lan="html:Estimate end date__"></label>
                        <div class="col-8" style="display: inline-flex;">
                            <div class="row fieldStart" style="">
                                <div style="padding-left: 1rem;" class="input-wrapper">
                                    <i class="fas fa-calendar-alt iconCalendar"></i>
                                    <input type="date" data-date="" id="pickupdate" class="testDate form-control" data-date-format="DD-MM-YYYY" style="width: 130px;" />
                                </div>
                            </div>
                            <div class="row input-wrapper" style="padding-left: 2rem;">
                                <i class="fa fa-clock iconTime"></i>
                                <input type="time" data-date="" class="testDate form-control" id="pickuptime" data-date-format="hh:mm A" style="width: 120px;">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer d-flex justify-content-center">
                    <button id="bPickup" class="btn btn-yellow font-weight-bold" onclick="SavePickupDashboard()" type="button" set-lan="text:Save"></button>
                    <button type="button" class="btn btn-yellow font-weight-bold" data-dismiss="modal" aria-label="Close" set-lan="text:Close"></button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="modalChatDashboard" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold" set-lan="text:Chat"></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-4 text-center">
                    <div id="overlay2Chat"></div>
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <div class="mesgs" id="bodyChat">
                                <div class="msg_history">
                                    <asp:Literal ID="LiteralDataChat" runat="server"></asp:Literal>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <div class="form-group row">
                        <label for="username" class="col-2 col-form-label" style="text-align: right;" set-lan="text:Chat_"></label>
                        <div class="col-10">
                            <asp:TextBox runat="server" ID="Chat" TextMode="MultiLine" Rows="3" Style="resize: vertical;" class="form-control" autocomplete="off" MaxLength="255" onkeypress="return maxLengthfield(this,255);" />
                        </div>
                    </div>
                    <%--<div class="form-group row">
                        <label for="username" class="col-2 col-form-label" style="text-align: right;" set-lan="text:Attach file_"></label>
                        <div class="col-10" style="display: inline-flex;">
                            <asp:FileUpload ID="FileUploadChat" runat="server" class="form-control" onchange="CheckExt(this)" />
                        </div>
                    </div>--%>
                    <div class="form-group row">
                        <label for="username" class="col-2 col-form-label" style="text-align: right;" set-lan="text:Attach file_"></label>
                        <div class="col-10" style="display: inline-flex;">
                            <asp:FileUpload ID="FileUploadChat1" runat="server" class="form-control" onchange="CheckExt(this)" />
                            <a style="font-size: 1.6rem; padding-left: .5rem;" class="link iconchat1" onclick="showAttachChat('2');"><i class="fas fa-plus-square" style="color: #CFA137;"></i></a>
                        </div>
                    </div>
                    <div class="form-group row attachchat2" style="display: none;">
                        <label for="username" class="col-2 col-form-label" style="text-align: right;" set-lan="text:Attach file_"></label>
                        <div class="col-10" style="display: inline-flex;">
                            <asp:FileUpload ID="FileUploadChat2" runat="server" class="form-control" onchange="CheckExt(this)" />
                            <a style="font-size: 1.6rem; padding-left: .5rem;" class="link iconchat2" onclick="showAttachChat('3');"><i class="fas fa-plus-square" style="color: #CFA137;"></i></a>
                        </div>
                    </div>
                    <div class="form-group row attachchat3" style="display: none;">
                        <label for="username" class="col-2 col-form-label" style="text-align: right;" set-lan="text:Attach file_"></label>
                        <div class="col-10" style="display: inline-flex;">
                            <asp:FileUpload ID="FileUploadChat3" runat="server" class="form-control" onchange="CheckExt(this)" />
                            <a style="font-size: 1.6rem; padding-left: .5rem;" class="link iconchat3" onclick="showAttachChat('4');"><i class="fas fa-plus-square" style="color: #CFA137;"></i></a>
                        </div>
                    </div>
                    <div class="form-group row attachchat4" style="display: none;">
                        <label for="username" class="col-2 col-form-label" style="text-align: right;" set-lan="text:Attach file_"></label>
                        <div class="col-10" style="display: inline-flex;">
                            <asp:FileUpload ID="FileUploadChat4" runat="server" class="form-control" onchange="CheckExt(this)" />
                            <a style="font-size: 1.6rem; padding-left: .5rem;" class="link iconchat4" onclick="showAttachChat('5');"><i class="fas fa-plus-square" style="color: #CFA137;"></i></a>
                        </div>
                    </div>
                    <div class="form-group row attachchat5" style="display: none;">
                        <label for="username" class="col-2 col-form-label" style="text-align: right;" set-lan="text:Attach file_"></label>
                        <div class="col-10">
                            <asp:FileUpload ID="FileUploadChat5" runat="server" class="form-control" onchange="CheckExt(this)" />
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="username" class="col-2 col-form-label" style="text-align: right;"></label>
                        <div class="col-10"><small class="text-muted form-text" style="text-align: left;" set-lan="text:Note: You can only upload a maximum of 5 files."></small></div>
                    </div>


                    <asp:Button ID="btnAddChatDashboard" class="btn btn-lg btn-yellow font-weight-bold btn-block" OnClick="AddChatDashboard_click" runat="server" Text="Add" Style="display: none;" />
                </div>
                <div class="modal-footer d-flex justify-content-center" style="margin-top: -30px !important;">
                    <button id="bChat" class="btn btn-yellow font-weight-bold" onclick="SaveChatDashboard()" type="button" set-lan="text:Save"></button>
                    <button type="button" class="btn btn-yellow font-weight-bold" data-dismiss="modal" aria-label="Close" set-lan="text:Close"></button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="modalAlertClose" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-3 text-center">
                    <label set-lan="text:Confirm close task tracking ?"></label>
                </div>
                <div class="modal-footer d-flex justify-content-center">
                    <button class="btn btn-yellow font-weight-bold" onclick="SaveCloseDashboard()" type="button" set-lan="text:OK"></button>
                    <button type="button" class="btn btn-yellow font-weight-bold" data-dismiss="modal" aria-label="Close" set-lan="text:Close"></button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="modalDeleteChat" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-3 text-center">
                    <label set-lan="text:Confirm unsend chat ?"></label>
                </div>
                <div class="modal-footer d-flex justify-content-center">
                    <button class="btn btn-yellow font-weight-bold" onclick="SaveCancelChat()" type="button" set-lan="text:OK"></button>
                    <button type="button" class="btn btn-yellow font-weight-bold" data-dismiss="modal" aria-label="Close" set-lan="text:Close"></button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="modalAlertCancel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-3 text-center">
                    <label set-lan="text:Confirm cancel task tracking ?"></label>
                </div>
                <div class="modal-footer d-flex justify-content-center">
                    <button class="btn btn-yellow font-weight-bold" onclick="SaveCancelDashboard()" type="button" set-lan="text:OK"></button>
                    <button type="button" class="btn btn-yellow font-weight-bold" data-dismiss="modal" aria-label="Close" set-lan="text:Close"></button>
                </div>
            </div>
        </div>
    </div>
    <asp:HiddenField ID="CategorySearch" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="StatusSearch" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="CategoryAdd" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="LevelAdd" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="MyTask" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="searchDateStart" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="searchDateTo" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="pickupID" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="cancelID" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="closeID" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="pickupDate" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="thisPage" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="totalDocs" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="eventPaging" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="chatID" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="AgentID" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="cancelChatID" runat="Server"></asp:HiddenField>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainScript" runat="server">
    <script src="../js/moment.min.js"></script>
    <script src="../js/pagination.js"></script>
    <script>
        var token = "";
        var typeTime = "Day";
        var startDateSearch = "";
        var endDateSearch = "";
        var TotalData;
        var NumPage;
        $(document).ready(function () {
            $('textarea').each(function () {
                this.setAttribute('style', 'height:100px;');
            });

            $("#menuDashboard > div").css("display", "block");
            $("#menuDashboard , #menuDashboard > a , #menuDashboardReport > a").addClass("active");
            $(".inModal > select > option[value='']").attr("disabled", "disabled");

            var date = new Date();
            var dateSet = date.getFullYear() + "-" + ("0" + (date.getMonth() + 1)).slice(-2) + "-" + ("0" + date.getDate()).slice(-2);
            $("#startdate").val(dateSet);
            $("#todate").val(dateSet);
            $("#pickupdate").val(dateSet);

            $('#starttime').val('00:00');
            var currenttime = ("0" + date.getHours()).slice(-2) + ":" + ("0" + date.getMinutes()).slice(-2);
            $('#totime').val(currenttime);

            var currenttimeTen = ("0" + date.getHours()).slice(-2) + ":" + ("0" + (date.getMinutes() + 10)).slice(-2);
            $('#pickuptime').val(currenttimeTen);

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

            setInterval(function () { Search_Click(); }, 300000);

            if ($("#<%=AgentID.ClientID%>").val() != "0" && $("#<%=AgentID.ClientID%>").val() != "1") {
                $("#tbData > thead > tr > th:nth-child(14) , #tbData > tbody > tr > td:nth-child(14), #tbData > tfoot > tr > td:nth-child(14)").css("display", "none");
            }

            GetData("");
            SetLan(localStorage.getItem("Language"));

            $("input").on('input', function () {
                var value = $(this).val().replace(/'/g, '').replace(/"/g, '');
                // go on with processing data
            });
        });

        function maxLengthfield(field, maxChars) {
            if (field.value.length >= maxChars) {
                event.returnValue = false;
                //alert("more than " + maxChars + " chars");
                //field.value = field.value.substring(0, maxChars);
                return false;
            }
        }

        function autoResize() {
            this.style.height = 'auto';
            this.style.height = this.scrollHeight + 'px';
        }

        function GetImageChat() {
            console.log("Test");
            $('#modalChatDashboard').modal();
            $("#overlay2Chat").removeClass("open");
            $('img.imgShowChat').on('click', function () {
                $('#overlay2Chat')
                  .css({ backgroundImage: `url(${this.src})` })
                  .addClass('open')
                  .one('click', function () { $(this).removeClass('open'); });
            });

            var vid = document.getElementsByClassName("vdo");
            vid.onplay = function () {
            };
            $('#myModalLoad').modal('hide');

            SetLan(localStorage.getItem("Language"));
        }

        function fixScroll() {
            var element = document.getElementById("bodyChat");
            element.scrollTop = element.scrollHeight;
        }

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
                            Search_Click("paging");
                        }--%>

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

        function showAttach(no) {
            if (no == "2") {
                $(".attach2").css("display", "flex");
                $(".icon1").css("display", "none");
            }
            else if (no == "3") {
                $(".attach3").css("display", "flex");
                $(".icon2").css("display", "none");
            }
            else if (no == "4") {
                $(".attach4").css("display", "flex");
                $(".icon3").css("display", "none");
            }
            else if (no == "5") {
                $(".attach5").css("display", "flex");
                $(".icon4").css("display", "none");
            }
        }

        function showAttachChat(no) {
            if (no == "2") {
                $(".attachchat2").css("display", "flex");
                $(".iconchat1").css("display", "none");
            }
            else if (no == "3") {
                $(".attachchat3").css("display", "flex");
                $(".iconchat2").css("display", "none");
            }
            else if (no == "4") {
                $(".attachchat4").css("display", "flex");
                $(".iconchat3").css("display", "none");
            }
            else if (no == "5") {
                $(".attachchat5").css("display", "flex");
                $(".iconchat4").css("display", "none");
            }
        }

        var validFiles = ["bmp", "gif", "png", "jpg", "jpeg", "mp4", "mov", "wmv", "avi"];
        function CheckExt(obj) {
            var source = obj.value;
            var ext = source.substring(source.lastIndexOf(".") + 1, source.length).toLowerCase();
            for (var i = 0; i < validFiles.length; i++) {
                if (validFiles[i] == ext)
                    break;
            }
            if (i >= validFiles.length) {
                alert("Please load an image with an extention of one of the following:\n\n" + validFiles.join(", "));
                $("#" + obj.id + "").val("");
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

            startDateSearch = start;
            endDateSearch = end;
            Search_Click('');
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

            startDateSearch = start;
            endDateSearch = end;
            Search_Click('');
        }

        function Search_Click(event) {
            $("#<%=CategorySearch.ClientID%>").val(document.getElementById("<%=ddlCategorySearch.ClientID%>").value);
            $("#<%=StatusSearch.ClientID%>").val(document.getElementById("<%=ddlStatus.ClientID%>").value);
            if (!$('#chkMyTask').is(':checked')) {
                $("#<%=MyTask.ClientID%>").val("0");
            }
            else {
                $("#<%=MyTask.ClientID%>").val("Yes");
            }

            if (startDateSearch == "" && endDateSearch == "") {
                var txt1 = $("#startdate").val() + " " + $('#starttime').val() + ":59";
                var txt2 = $("#todate").val() + " " + $('#totime').val() + ":59";
                $("#<%=searchDateStart.ClientID%>").val(txt1);
                $("#<%=searchDateTo.ClientID%>").val(txt2);
            }
            else {
                var txt1 = startDateSearch + " " + $('#starttime').val() + ":59";
                var txt2 = endDateSearch + " " + $('#totime').val() + ":59";
                $("#<%=searchDateStart.ClientID%>").val(txt1);
                $("#<%=searchDateTo.ClientID%>").val(txt2);
                startDateSearch = "";
                endDateSearch = "";
            }

            $("#myModalLoad").modal();
            $("#<%=eventPaging.ClientID%>").val(event);

            var dateOne = $("#startdate").val() + " " + $("#starttime").val() + ":59";
            var dateTwo = $("#todate").val() + " " + $("#totime").val() + ":59";
            var date1 = Date.parse(dateOne);
            var date2 = Date.parse(dateTwo);
            if (date1 > date2) {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:Field 'To Date' should be greater than 'Start Date'.");
                SetLan(localStorage.getItem("Language"));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else {
                $("#<%=btnSearch.ClientID%>").click();
            }
            SetLan(localStorage.getItem("Language"));
        }

        function addDashboard() {
            $("#bAdd").css("display", "flex");
            $("#txtModal").text("Add Task Tracking");
            $('#<%=ddlCategoryAdd.ClientID%>, #<%=ddlLevelAdd.ClientID%>').prop("selectedIndex", 0);
            $('#<%=product.ClientID%>,#<%=agent.ClientID%>,#<%=AttahcFile1.ClientID%>,#<%=AttahcFile2.ClientID%>,#<%=AttahcFile3.ClientID%>,#<%=AttahcFile4.ClientID%>,#<%=AttahcFile5.ClientID%>,#<%=Website.ClientID%>,#<%=Username.ClientID%>,#<%=Password.ClientID%>,#<%=Problem.ClientID%>,#<%=Troubleshooting.ClientID%>,#<%=Afterfirstfixed.ClientID%>,#<%=Other.ClientID%>').val("");
            SetLan(localStorage.getItem("Language"));
            $('#modalAddDashboard').modal();
        }

        function alertModal(txtAlert) {
            if (txtAlert != "Unsend chat success.") {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:" + txtAlert + "");
                SetLan(localStorage.getItem('Language'));
                $('#modalAlert').modal('show');
                $("#myModalLoad, #modalAddDashboard, #modalPickupDashboard, #modalAlertClose, #modalAlertCancel, #modalChatDashboard, #modalDeleteChat").modal('hide');
                setTimeout(function () { $('#modalAlert').modal('hide') }, 2000);
            }
            else {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:" + txtAlert + "");
                SetLan(localStorage.getItem('Language'));
                $('#modalAlert').modal('show');
                $("#myModalLoad, #modalAddDashboard, #modalPickupDashboard, #modalAlertClose, #modalAlertCancel, #modalDeleteChat").modal('hide');
                setTimeout(function () { $('#modalAlert').modal('hide') }, 2000);
            }
        }

        function getImage(name) {
            $("#overlay2").removeClass("open");
            $("#imgShow").html("");
            var htmlFile = "";
            var arrFile = name.split(',');;
            for (var i = 0; i < arrFile.length; i++) {
                if (name != "") {
                    if (arrFile[i].split('.')[1] == "mp4" || arrFile[i].split('.')[1] == "mov" || arrFile[i].split('.')[1] == "wmv" || arrFile[i].split('.')[1] == "avi") {
                        htmlFile += "<video class='col-4 vdo' style='width: 100%; height: 135px; margin-bottom: 1rem;' controls>";
                        htmlFile += "<source src='../FileAttach/" + arrFile[i] + "'>";
                        htmlFile += "</video>";
                    }
                    else {
                        htmlFile += "<img class='col-4 imgShow' src='../FileAttach/" + arrFile[i] + "' />";
                    }
                }
            }

            if (name == "") {
                htmlFile += "<img src='../img/noImage.jpg' style='max-width: 100%; height: auto !important;' />";
            }

            $("#imgShow").append(htmlFile);
            $("#modalImage").modal();

            $('img.imgShow').on('click', function () {
                $('#overlay2')
                  .css({ backgroundImage: `url(${this.src})` })
                  .addClass('open')
                  .one('click', function () { $(this).removeClass('open'); });
            });

            var vid = document.getElementsByClassName("vdo");
            vid.onplay = function () {
            };
        }

        function getPickup(id) {
            var date = new Date();
            var dateSet = date.getFullYear() + "-" + ("0" + (date.getMonth() + 1)).slice(-2) + "-" + ("0" + date.getDate()).slice(-2);
            $("#pickupdate").val(dateSet);

            var dateTime = new Date(date.getTime() + 10 * 60000);
            var currenttimeTen = ("0" + dateTime.getHours()).slice(-2) + ":" + ("0" + dateTime.getMinutes()).slice(-2);
            $('#pickuptime').val(currenttimeTen);

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

            $("#<%=pickupID.ClientID%>").val(id);
            document.getElementById("imgShow").src = "../FileAttach/" + name;
            $("#modalPickupDashboard").modal();
        }

        function getDesc(textTicket, text, text2, text3, text4, text5, text6, text7) {
            text4 = text4.split('<br/>').join('\r\n');
            text5 = text5.split('<br/>').join('\r\n');
            text6 = text6.split('<br/>').join('\r\n');
            text7 = text7.split('<br/>').join('\r\n');
            $('#<%=TicketIDView.ClientID%>').val(textTicket);
            $('#<%=WebsiteView.ClientID%>').val(text);
            $('#<%=UsernameView.ClientID%>').val(text2);
            $('#<%=PasswordView.ClientID%>').val(text3);
            $('#<%=ProblemView.ClientID%>').val(text4);
            $('#<%=TroubleshootingView.ClientID%>').val(text5);
            $('#<%=AfterfirstfixedView.ClientID%>').val(text6);
            $('#<%=OtherView.ClientID%>').val(text7);

            $('textarea').each(function () {
                this.setAttribute('style', 'height:100px;');
            });
            //.on('input', function () {
            //    this.style.height = 'auto';
            //    this.style.height = (this.scrollHeight) + 'px';
            //});

            $('#modalGetDesc').modal();
        }

        function getChat(id) {
            $("#<%=Chat.ClientID%>,#<%=FileUploadChat1.ClientID%>,#<%=FileUploadChat2.ClientID%>,#<%=FileUploadChat3.ClientID%>,#<%=FileUploadChat4.ClientID%>,#<%=FileUploadChat5.ClientID%>").val("");
            $("#<%=chatID.ClientID%>").val(id);
            $("#<%=btnChatDashboard.ClientID%>").click();
            //$("#modalChatDashboard").modal();
        }

        function SaveChatDashboard() {
            $("#myModalLoad").modal();
            var fileCount1 = document.getElementById('<%=FileUploadChat1.ClientID%>').files.length;
            var fileCount2 = document.getElementById('<%=FileUploadChat2.ClientID%>').files.length;
            var fileCount3 = document.getElementById('<%=FileUploadChat3.ClientID%>').files.length;
            var fileCount4 = document.getElementById('<%=FileUploadChat4.ClientID%>').files.length;
            var fileCount5 = document.getElementById('<%=FileUploadChat5.ClientID%>').files.length;
            if ($('#<%=Chat.ClientID%>').val() == "" && fileCount1 == 0 && fileCount2 == 0 && fileCount3 == 0 && fileCount4 == 0 && fileCount5 == 0) {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:missing 'Chat' field");
                SetLan(localStorage.getItem("Language"));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else {
                $("#<%=btnAddChatDashboard.ClientID%>").click();
            }
            SetLan(localStorage.getItem('Language'));
        }

        function SaveDashboard() {
            $("#myModalLoad").modal();
            if ($('#<%=product.ClientID%>').val() == "") {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:missing 'Product' field");
                SetLan(localStorage.getItem("Language"));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else if ($('#<%=agent.ClientID%>').val() == "") {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:missing 'Agent' field");
                SetLan(localStorage.getItem('Language'));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else if (document.getElementById("<%=ddlCategoryAdd.ClientID%>").value == "") {
        document.getElementById("lbAlert").setAttribute("set-lan", "text:missing 'Category' field");
        SetLan(localStorage.getItem('Language'));
        $('#modalAlert').modal('show');
        $("#myModalLoad").modal('hide');
    }
    else if (document.getElementById("<%=ddlLevelAdd.ClientID%>").value == "") {
        document.getElementById("lbAlert").setAttribute("set-lan", "text:missing 'Level' field");
        SetLan(localStorage.getItem('Language'));
        $('#modalAlert').modal('show');
        $("#myModalLoad").modal('hide');
    }
    else if ($('#<%=Website.ClientID%>').val() == "") {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:missing 'Website' field");
                SetLan(localStorage.getItem('Language'));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else if ($('#<%=Username.ClientID%>').val() == "") {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:missing 'Username' field");
                SetLan(localStorage.getItem('Language'));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else if ($('#<%=Password.ClientID%>').val() == "") {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:missing 'Password' field");
                SetLan(localStorage.getItem('Language'));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else if ($('#<%=Problem.ClientID%>').val() == "") {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:missing 'Problem' field");
                SetLan(localStorage.getItem('Language'));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else if ($('#<%=Troubleshooting .ClientID%>').val() == "") {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:missing 'Troubleshooting' field");
                SetLan(localStorage.getItem('Language'));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else if ($('#<%=Afterfirstfixed.ClientID%>').val() == "") {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:missing 'Afterfirstfixed' field");
                SetLan(localStorage.getItem('Language'));
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else {
                $("#<%=CategoryAdd.ClientID%>").val(document.getElementById("<%=ddlCategoryAdd.ClientID%>").value);
                $("#<%=LevelAdd.ClientID%>").val(document.getElementById("<%=ddlLevelAdd.ClientID%>").value);
                $("#<%=btnAddDashboard.ClientID%>").click();
            }
    SetLan(localStorage.getItem('Language'));
}

function getCancel(id) {
    $("#<%=cancelID.ClientID%>").val(id);
    $("#modalAlertCancel").modal();
}

function getClose(id) {
    $("#<%=closeID.ClientID%>").val(id);
    $("#modalAlertClose").modal();
}

function SaveCloseDashboard() {
    $("#myModalLoad").modal();
    $("#<%=btnCloseDashboard.ClientID%>").click();
}

function SaveCancelDashboard() {
    $("#myModalLoad").modal();
    $("#<%=btnCancelDashboard.ClientID%>").click();
}

function getCancelChat(id) {
    $("#<%=cancelChatID.ClientID%>").val(id);
    $("#modalDeleteChat").modal();
}

function SaveCancelChat() {
    $("#myModalLoad").modal();
    $("#<%=btnCancelChat.ClientID%>").click();
}

function SavePickupDashboard() {
    $("#myModalLoad").modal();
    var date = $("#pickupdate").val();
    var time = $("#pickuptime").val();
    var totalDate = date + " " + time + ":59";
    $("#<%=pickupDate.ClientID%>").val(totalDate);
            $("#<%=btnAddPickupDashboard.ClientID%>").click();
        }
    </script>
</asp:Content>

