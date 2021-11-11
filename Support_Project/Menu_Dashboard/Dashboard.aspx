<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="Support_Project.Menu_Dashboard.Dashboard" %>

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
            /*margin: 20px auto;*/
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

        .navCur {
            margin-top: 1rem;
            background-color: #fde60c;
            width: fit-content;
            padding: .1rem;
            padding-left: 1rem;
            padding-right: 1rem;
            color: #4a4a4a;
            font-weight: bold;
            border-top-left-radius: .375rem;
        }
    </style>
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="" set-lan="text:Dashboard"></a></li>
            <li class="breadcrumb-item active txtMem" set-lan="text:Dashboard"></li>
        </ol>
    </nav>
    <div class="row">
        <div class="col-md-8">
            <h1 set-lan="text:Dashboard">Dashboard</h1>
        </div>
        <div class="col-md-4" style="text-align: right;">
            <%--<a class="btn btn-primary" onclick="btnExport();" style="color: #2F80ED !important;" id="btnExport">Export Report</a>--%>
        </div>
    </div>
    <div class="row">
        <div class="col-6">
            <div class="table-wrapper" style="margin-top: -1.5rem; width: 100%;">
                <div style="display: flex;">
                    <div class="navCur" style="margin-top: 1rem;">
                        <label style="font-weight: bold;font-size: 11pt;" set-lan="text:Today"></label>
                    </div>
                    <div style="border-bottom: 27px solid #fde60c; border-right: 50px solid transparent;"></div>
                </div>
                <table class="table table-border">
                    <thead class="rgba-green-slight">
                        <tr>
                            <th style="border: 1px #ced4da solid; width: 20%; text-align: center; padding-left: 5px; background-color: #0b926c; color: #fff;" set-lan="text:Category"></th>
                            <th style="border: 1px #ced4da solid; width: 10%; background-color: #0b926c; color: #fff;" set-lan="text:Amount"></th>
                            <th style="border: 1px #ced4da solid; width: 10%; background-color: #0b926c; color: #fff;" set-lan="text:New today"></th>
                            <th style="border: 1px #ced4da solid; width: 10%; background-color: #0b926c; color: #fff;" set-lan="text:Open"></th>
                            <th style="border: 1px #ced4da solid; width: 10%; background-color: #0b926c; color: #fff;" set-lan="text:Waiting"></th>
                            <th style="border: 1px #ced4da solid; width: 10%; background-color: #0b926c; color: #fff;" set-lan="text:Done"></th>
                            <th style="border: 1px #ced4da solid; width: 10%; background-color: #0b926c; color: #fff;" set-lan="text:Cancel"></th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Literal ID="LiteralDataAllToday" runat="server"></asp:Literal>
                    </tbody>
                    <tfoot class="rgba-yellow-slight">
                        <asp:Literal ID="LiteralDataAllFooterToday" runat="server"></asp:Literal>
                    </tfoot>
                </table>
                 <div style="display: flex; margin-top: -.5rem;">
                    <div class="navCur" style="margin-top: 1rem;">
                        <label style="font-weight: bold;font-size: 11pt;" set-lan="text:All"></label>
                    </div>
                    <div style="border-bottom: 27px solid #fde60c; border-right: 50px solid transparent;"></div>
                </div>
                 <table class="table table-border">
                    <thead class="rgba-green-slight">
                        <tr>
                            <th style="border: 1px #ced4da solid; width: 20%; text-align: center; padding-left: 5px; background-color: #0b926c; color: #fff;" set-lan="text:Category"></th>
                            <th style="border: 1px #ced4da solid; width: 10%; background-color: #0b926c; color: #fff;" set-lan="text:Amount"></th>
                            <th style="border: 1px #ced4da solid; width: 10%; background-color: #0b926c; color: #fff;" set-lan="text:New today"></th>
                            <th style="border: 1px #ced4da solid; width: 10%; background-color: #0b926c; color: #fff;" set-lan="text:Open"></th>
                            <th style="border: 1px #ced4da solid; width: 10%; background-color: #0b926c; color: #fff;" set-lan="text:Waiting"></th>
                            <th style="border: 1px #ced4da solid; width: 10%; background-color: #0b926c; color: #fff;" set-lan="text:Done"></th>
                            <th style="border: 1px #ced4da solid; width: 10%; background-color: #0b926c; color: #fff;" set-lan="text:Cancel"></th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Literal ID="LiteralDataAll" runat="server"></asp:Literal>
                    </tbody>
                    <tfoot class="rgba-yellow-slight">
                        <asp:Literal ID="LiteralDataAllFooter" runat="server"></asp:Literal>
                    </tfoot>
                </table>
            </div>
        </div>
        <div class="col-6" style="padding-top: 1.2rem;">
            <div id="containerForDate"></div>
        </div>
    </div>
    <div class="row" style="margin-top: 1rem;">
        <div class="col-6">
            <div class="table-wrapper" style="margin-top: 1rem; margin-bottom: 1rem; width: 100%; display: none;">
                <table class="table table-border">
                    <thead class="rgba-green-slight">
                        <tr style="display: none;">
                            <th></th>
                            <th></th>
                            <th></th>
                        </tr>
                        <tr>
                            <th style="border: 1px #ced4da solid; background-color: #17172C; color: #f2e8be;" set-lan="text:Category"></th>
                            <th style="border: 1px #ced4da solid; background-color: #17172C; color: #f2e8be;" set-lan="text:Agent"></th>
                            <th style="border: 1px #ced4da solid; background-color: #17172C; color: #f2e8be;" set-lan="text:Total"></th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Literal ID="LiteralDataAllReport" runat="server"></asp:Literal>
                    </tbody>
                </table>
            </div>
            <div id="container"></div>
        </div>
        <div class="col-6">
            <div id="container2"></div>
        </div>
    </div>
    <div class="row" style="margin-top: 1rem;">
        <div class="col-6">
            <div id="container3"></div>
        </div>
        <div class="col-6">
            <div id="container4"></div>
        </div>
    </div>
    <div class="row" style="margin-top: 1rem;">
        <div class="col-6">
            <div id="container5"></div>
        </div>
        <%--<div class="col-6">
            <div id="container4"></div>
        </div>--%>
    </div>
    <!-- Modal -->
    <div class="modal fade" id="modalAlertWarning" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-3">
                    <div id="divAlert">
                        เรียนผู้ใช้บริการทุกท่าน<br/>&emsp;&emsp;เพื่อยกระดับมาตรฐานความปลอดภัย ทางเรามีการอัพเดตรหัสยืนยันตัวตน ให้ท่านดาวน์โหลด App Google Authentication เพื่อสร้างรหัสผ่าน หลังจากสร้างรหัสยืนยันตัวตนแล้ว ห้ามลบ!! App Google Authentication ออกจากมือถือ<br/>
                        &emsp;&emsp;เนื่องจากท่านจะต้องใช้รหัสผ่าน 6 หลัก จากApp Google Authentication ทุกครั้งที่ทำการ Login เข้าระบบ<br/>
                        ***หากมีข้อสงสัยเพิ่มเติม กรุณาติดต่อเรา<br/>Askmebet Company
                    </div>
                </div>
                <div class="modal-footer d-flex justify-content-center">
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
    <div class="modal fade" id="modalSport" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold" set-lan="text:Sport"></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-3 text-center" style="height: 500px; overflow: auto;">
                    <table class="table table-border">
                        <thead class="rgba-green-slight">
                            <tr>
                                <th set-lan="text:No"></th>
                                <th set-lan="text:Agent"></th>
                                <th set-lan="text:Total"></th>
                            </tr>
                        </thead>
                        <asp:Literal ID="LiteralSport" runat="server"></asp:Literal>
                        <tbody>
                        </tbody>
                        <tfoot class="rgba-yellow-slight">
                            <tr class="total">
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
                <div class="modal-footer d-flex justify-content-center">
                    <button type="button" class="btn btn-yellow font-weight-bold" data-dismiss="modal" aria-label="Close" set-lan="text:Close"></button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="modalCasino" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold" set-lan="text:Casino"></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-3 text-center" style="height: 500px; overflow: auto;">
                    <table class="table table-border">
                        <thead class="rgba-green-slight">
                            <tr>
                                <th set-lan="text:No"></th>
                                <th set-lan="text:Agent"></th>
                                <th set-lan="text:Total"></th>
                            </tr>
                        </thead>
                        <asp:Literal ID="LiteralCasino" runat="server"></asp:Literal>
                        <tbody>
                        </tbody>
                        <tfoot class="rgba-yellow-slight">
                            <tr class="total">
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
                <div class="modal-footer d-flex justify-content-center">
                    <button type="button" class="btn btn-yellow font-weight-bold" data-dismiss="modal" aria-label="Close" set-lan="text:Close"></button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="modalLotto" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold" set-lan="text:Lotto"></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-3 text-center" style="height: 500px; overflow: auto;">
                    <table class="table table-border">
                        <thead class="rgba-green-slight">
                            <tr>
                                <th set-lan="text:No"></th>
                                <th set-lan="text:Agent"></th>
                                <th set-lan="text:Total"></th>
                            </tr>
                        </thead>
                        <asp:Literal ID="LiteralLotto" runat="server"></asp:Literal>
                        <tbody>
                        </tbody>
                        <tfoot class="rgba-yellow-slight">
                            <tr class="total">
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
                <div class="modal-footer d-flex justify-content-center">
                    <button type="button" class="btn btn-yellow font-weight-bold" data-dismiss="modal" aria-label="Close" set-lan="text:Close"></button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="modalGame" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold" set-lan="text:Game"></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-3 text-center" style="height: 500px; overflow: auto;">
                    <table class="table table-border">
                        <thead class="rgba-green-slight">
                            <tr>
                                <th set-lan="text:No"></th>
                                <th set-lan="text:Agent"></th>
                                <th set-lan="text:Total"></th>
                            </tr>
                        </thead>
                        <asp:Literal ID="LiteralGame" runat="server"></asp:Literal>
                        <tbody>
                        </tbody>
                        <tfoot class="rgba-yellow-slight">
                            <tr class="total">
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
                <div class="modal-footer d-flex justify-content-center">
                    <button type="button" class="btn btn-yellow font-weight-bold" data-dismiss="modal" aria-label="Close" set-lan="text:Close"></button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="modalMulti" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold" set-lan="text:Multiplayer"></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-3 text-center" style="height: 500px; overflow: auto;">
                    <table class="table table-border">
                        <thead class="rgba-green-slight">
                            <tr>
                                <th set-lan="text:No"></th>
                                <th set-lan="text:Agent"></th>
                                <th set-lan="text:Total"></th>
                            </tr>
                        </thead>
                        <asp:Literal ID="LiteralMulti" runat="server"></asp:Literal>
                        <tbody>
                        </tbody>
                        <tfoot class="rgba-yellow-slight">
                            <tr class="total">
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
                <div class="modal-footer d-flex justify-content-center">
                    <button type="button" class="btn btn-yellow font-weight-bold" data-dismiss="modal" aria-label="Close" set-lan="text:Close"></button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="modalAnnouncement" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold" set-lan="text:Announcement"></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-3 text-center">
                    <div class="col-12">
                        <div id="wrapper">
                            <section>
                                <div class="data-container"></div>
                                <div id="pagination-demo2"></div>
                            </section>
                        </div>
                    </div>
                    <div class="col-12" style="margin-top: 3rem;">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <div class="form-group row">
                                    <label for="username" class="col-3 col-form-label" style="margin-top: 5px !important; text-align: right; padding: 0px !important;">
                                        Title :</label>
                                    <div class="col-9" style="text-align: left;">
                                        <asp:Label ID="title" runat="server"></asp:Label>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="username" class="col-3 col-form-label" style="margin-top: 5px !important; text-align: right; padding: 0px !important;">
                                        Description :</label>
                                    <div class="col-9" style="text-align: left;">
                                        <asp:Label ID="description" runat="server"></asp:Label>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="username" class="col-3 col-form-label" style="margin-top: 5px !important; text-align: right; padding: 0px !important;">
                                        Start Date :</label>
                                    <div class="col-9" style="text-align: left;">
                                        <asp:Label ID="startdate" runat="server"></asp:Label>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="username" class="col-3 col-form-label" style="margin-top: 5px !important; text-align: right; padding: 0px !important;">
                                        To Date :</label>
                                    <div class="col-9" style="text-align: left;">
                                        <asp:Label ID="todate" runat="server"></asp:Label>
                                    </div>
                                </div>
                                <div id="overlay2"></div>
                                <div class="row" id="imgShow">
                                    <asp:Literal ID="LiteralImage" runat="server"></asp:Literal>
                                </div>
                                <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="Search_click" autopostback="false" Style="display: none;" />
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
                <div class="modal-footer d-flex justify-content-center">
                    <button type="button" class="btn btn-yellow font-weight-bold" data-dismiss="modal" aria-label="Close" set-lan="text:Close"></button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="modalSportToday" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold" set-lan="text:Sport"></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-3 text-center" style="height: 500px; overflow: auto;">
                    <table class="table table-border">
                        <thead class="rgba-green-slight">
                            <tr>
                                <th set-lan="text:No"></th>
                                <th set-lan="text:Agent"></th>
                                <th set-lan="text:Total"></th>
                            </tr>
                        </thead>
                        <asp:Literal ID="LiteralSportToday" runat="server"></asp:Literal>
                        <tbody>
                        </tbody>
                        <tfoot class="rgba-yellow-slight">
                            <tr class="total">
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
                <div class="modal-footer d-flex justify-content-center">
                    <button type="button" class="btn btn-yellow font-weight-bold" data-dismiss="modal" aria-label="Close" set-lan="text:Close"></button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="modalCasinoToday" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold" set-lan="text:Casino"></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-3 text-center" style="height: 500px; overflow: auto;">
                    <table class="table table-border">
                        <thead class="rgba-green-slight">
                            <tr>
                                <th set-lan="text:No"></th>
                                <th set-lan="text:Agent"></th>
                                <th set-lan="text:Total"></th>
                            </tr>
                        </thead>
                        <asp:Literal ID="LiteralCasinoToday" runat="server"></asp:Literal>
                        <tbody>
                        </tbody>
                        <tfoot class="rgba-yellow-slight">
                            <tr class="total">
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
                <div class="modal-footer d-flex justify-content-center">
                    <button type="button" class="btn btn-yellow font-weight-bold" data-dismiss="modal" aria-label="Close" set-lan="text:Close"></button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="modalLottoToday" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold" set-lan="text:Lotto"></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-3 text-center" style="height: 500px; overflow: auto;">
                    <table class="table table-border">
                        <thead class="rgba-green-slight">
                            <tr>
                                <th set-lan="text:No"></th>
                                <th set-lan="text:Agent"></th>
                                <th set-lan="text:Total"></th>
                            </tr>
                        </thead>
                        <asp:Literal ID="LiteralLottoToday" runat="server"></asp:Literal>
                        <tbody>
                        </tbody>
                        <tfoot class="rgba-yellow-slight">
                            <tr class="total">
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
                <div class="modal-footer d-flex justify-content-center">
                    <button type="button" class="btn btn-yellow font-weight-bold" data-dismiss="modal" aria-label="Close" set-lan="text:Close"></button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="modalGameToday" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold" set-lan="text:Game"></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-3 text-center" style="height: 500px; overflow: auto;">
                    <table class="table table-border">
                        <thead class="rgba-green-slight">
                            <tr>
                                <th set-lan="text:No"></th>
                                <th set-lan="text:Agent"></th>
                                <th set-lan="text:Total"></th>
                            </tr>
                        </thead>
                        <asp:Literal ID="LiteralGameToday" runat="server"></asp:Literal>
                        <tbody>
                        </tbody>
                        <tfoot class="rgba-yellow-slight">
                            <tr class="total">
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
                <div class="modal-footer d-flex justify-content-center">
                    <button type="button" class="btn btn-yellow font-weight-bold" data-dismiss="modal" aria-label="Close" set-lan="text:Close"></button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="modalMultiToday" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold" set-lan="text:Multiplayer"></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-3 text-center" style="height: 500px; overflow: auto;">
                    <table class="table table-border">
                        <thead class="rgba-green-slight">
                            <tr>
                                <th set-lan="text:No"></th>
                                <th set-lan="text:Agent"></th>
                                <th set-lan="text:Total"></th>
                            </tr>
                        </thead>
                        <asp:Literal ID="LiteralMultiToday" runat="server"></asp:Literal>
                        <tbody>
                        </tbody>
                        <tfoot class="rgba-yellow-slight">
                            <tr class="total">
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
                <div class="modal-footer d-flex justify-content-center">
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
    <asp:HiddenField ID="dataSportAgent" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="dataSportTotal" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="dataLottoAgent" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="dataLottoTotal" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="dataCasinoAgent" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="dataCasinoTotal" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="dataGameAgent" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="dataGameTotal" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="dataMultiAgent" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="dataMultiTotal" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="dataForDate" runat="Server"></asp:HiddenField>
    <asp:HiddenField ID="dataForTotal" runat="Server"></asp:HiddenField>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainScript" runat="server">
    <script src="../js/moment.min.js"></script>
    <script src="../js/pagination.js"></script>
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/modules/exporting.js"></script>
    <script src="https://code.highcharts.com/modules/export-data.js"></script>
    <script src="https://code.highcharts.com/modules/accessibility.js"></script>
    <script>
        var token = "";
        var TotalData;
        var NumPage;
        $(document).ready(function () {

            //$("#divAlert").html("เรียนผู้ใช้บริการทุกท่าน<br/>เพื่อยกระดับมาตรฐานความปลอดภัย ทางเรามีการอัพเดตรหัสยืนยันตัวตน ให้ท่านดาวน์โหลด App Google Authentication เพื่อสร้างรหัสผ่าน หลังจากสร้างรหัสยืนยันตัวตนแล้ว ห้ามลบ!! App Google Authentication ออกจากมือถือ<br/>เนื่องจากท่านจะต้องใช้รหัสผ่าน 6 หลัก จากApp Google Authentication ทุกครั้งที่ทำการ Login เข้าระบบ<br/>วิธีการยืนยันตัวตน1. ให้ลูกค้าโหลด App Google Authentication<br/>2. ให้เข้า app แล้วสแกนคิวอาร์โค๊ด ***สแกนได้รอบเดียว***<br/>3. ใส่รหัสที่ app ให้มา ***รหัสจะรีใหม่ทุก 30 วิ***<br/>4. เข้าระบบซับพอร์ตเรียบร้อย<br/>***หากเคยสแกนแล้ว เมื่อเข้าใหม่ให้เอารหัสจาก App Google Authentication มาใส่ได้เลย<br/>***หากมีข้อสงสัยเพิ่มเติม กรุณาติดต่อเรา<br/><br/>Askmebet Company");
            $('#modalAlertWarning').modal('show');

            clickzoom();

            $("#menuDashboard > div").css("display", "block");
            $("#menuDashboard , #menuDashboard > a , #menuDashboardMain > a").addClass("active");
            $(".inModal > select > option[value='']").attr("disabled", "disabled");

            GetData("");
            getGraph();
        });

        function getGraph() {
            var data1 = $('#<%=dataForDate.ClientID%>').val();
            var ForDateArr = data1.split(',');
            var data2 = $('#<%=dataForTotal.ClientID%>').val();
            var ForTotalArr = data2.replace(/, +/g, ",").split(",").map(Number);

            var data1_1 = $('#<%=dataSportAgent.ClientID%>').val();
            var SportAgentArr = data1_1.split(',');
            var data1_2 = $('#<%=dataSportTotal.ClientID%>').val();
            var SportTotalArr = data1_2.replace(/, +/g, ",").split(",").map(Number);

            var data2_1 = $('#<%=dataLottoAgent.ClientID%>').val();
            var LottoAgentArr = data2_1.split(',');
            var data2_2 = $('#<%=dataLottoTotal.ClientID%>').val();
            var LottoTotalArr = data2_2.replace(/, +/g, ",").split(",").map(Number);

            var data3_1 = $('#<%=dataCasinoAgent.ClientID%>').val();
            var CasinoAgentArr = data3_1.split(',');
            var data3_2 = $('#<%=dataCasinoTotal.ClientID%>').val();
            var CasinoTotalArr = data3_2.replace(/, +/g, ",").split(",").map(Number);

            var data4_1 = $('#<%=dataGameAgent.ClientID%>').val();
            var GameAgentArr = data4_1.split(',');
            var data4_2 = $('#<%=dataGameTotal.ClientID%>').val();
            var GameTotalArr = data4_2.replace(/, +/g, ",").split(",").map(Number);

            var data5_1 = $('#<%=dataMultiAgent.ClientID%>').val();
            var MultiAgentArr = data5_1.split(',');
            var data5_2 = $('#<%=dataMultiTotal.ClientID%>').val();
            var MultiTotalArr = data5_2.replace(/, +/g, ",").split(",").map(Number);

            var txtHead1 = "";
            var txtHead2 = "";
            var txtHead3 = "";
            var txtHead4 = "";
            var txtHead5 = "";
            var txtHead6 = "";
            var txtTotal = "";
            if (localStorage.getItem("Language") == "English") {
                txtHead1 = "For Date";
                txtHead2 = "Sport";
                txtHead3 = "Lotto";
                txtHead4 = "Casino";
                txtHead5 = "Game";
                txtHead6 = "Multiplayer";
                txtTotal = "Total";
            }
            else if (localStorage.getItem("Language") == "Thai") {
                txtHead1 = "รายการต่อวัน";
                txtHead2 = "กีฬา";
                txtHead3 = "หวย";
                txtHead4 = "คาสิโน";
                txtHead5 = "เกมส์";
                txtHead6 = "มัลติเพลเยอร์";
                txtTotal = "ทั้งหมด";
            }

            Highcharts.chart('containerForDate', {
                chart: {
                    type: 'line'
                },
                title: {
                    text: txtHead1
                },
                xAxis: {
                    categories: ForDateArr,
                    title: {
                        text: null
                    }
                },
                yAxis: {
                    min: 0,
                    title: {
                        text: txtTotal,
                        align: 'high'
                    },
                    labels: {
                        overflow: 'justify'
                    }
                },
                //tooltip: {
                //    valueSuffix: ' millions'
                //},
                plotOptions: {
                    line: {
                        dataLabels: {
                            enabled: false
                        },
                        enableMouseTracking: true
                    }
                },
                legend: {
                    layout: 'vertical',
                    align: 'right',
                    verticalAlign: 'top',
                    x: -40,
                    y: 80,
                    floating: true,
                    borderWidth: 1,
                    backgroundColor:
                        Highcharts.defaultOptions.legend.backgroundColor || '#FFFFFF',
                    shadow: true,
                    enabled: false
                },
                credits: {
                    enabled: false
                },
                series: [{
                    name: txtTotal,
                    data: ForTotalArr
                }]
            });

            Highcharts.chart('container', {
                chart: {
                    type: 'line'
                },
                title: {
                    text: txtHead2
                },
                xAxis: {
                    categories: SportAgentArr,
                    title: {
                        text: null
                    }
                },
                yAxis: {
                    min: 0,
                    title: {
                        text: txtTotal,
                        align: 'high'
                    },
                    labels: {
                        overflow: 'justify'
                    }
                },
                //tooltip: {
                //    valueSuffix: ' millions'
                //},
                plotOptions: {
                    line: {
                        dataLabels: {
                            enabled: false
                        },
                        enableMouseTracking: true
                    }
                },
                legend: {
                    layout: 'vertical',
                    align: 'right',
                    verticalAlign: 'top',
                    x: -40,
                    y: 80,
                    floating: true,
                    borderWidth: 1,
                    backgroundColor:
                        Highcharts.defaultOptions.legend.backgroundColor || '#FFFFFF',
                    shadow: true,
                    enabled: false
                },
                credits: {
                    enabled: false
                },
                series: [{
                    name: txtTotal,
                    data: SportTotalArr
                }]
            });

            Highcharts.chart('container2', {
                chart: {
                    type: 'line'
                },
                title: {
                    text: txtHead3
                },
                xAxis: {
                    categories: LottoAgentArr,
                    title: {
                        text: null
                    }
                },
                yAxis: {
                    min: 0,
                    title: {
                        text: txtTotal,
                        align: 'high'
                    },
                    labels: {
                        overflow: 'justify'
                    }
                },
                //tooltip: {
                //    valueSuffix: ' millions'
                //},
                plotOptions: {
                    line: {
                        dataLabels: {
                            enabled: false
                        },
                        enableMouseTracking: true
                    }
                },
                legend: {
                    layout: 'vertical',
                    align: 'right',
                    verticalAlign: 'top',
                    x: -40,
                    y: 80,
                    floating: true,
                    borderWidth: 1,
                    backgroundColor:
                        Highcharts.defaultOptions.legend.backgroundColor || '#FFFFFF',
                    shadow: true,
                    enabled: false
                },
                credits: {
                    enabled: false
                },
                series: [{
                    name: txtTotal,
                    data: LottoTotalArr
                }]
            });

            Highcharts.chart('container3', {
                chart: {
                    type: 'line'
                },
                title: {
                    text: txtHead4
                },
                xAxis: {
                    categories: CasinoAgentArr,
                    title: {
                        text: null
                    }
                },
                yAxis: {
                    min: 0,
                    title: {
                        text: txtTotal,
                        align: 'high'
                    },
                    labels: {
                        overflow: 'justify'
                    }
                },
                //tooltip: {
                //    valueSuffix: ' millions'
                //},
                plotOptions: {
                    line: {
                        dataLabels: {
                            enabled: false
                        },
                        enableMouseTracking: true
                    }
                },
                legend: {
                    layout: 'vertical',
                    align: 'right',
                    verticalAlign: 'top',
                    x: -40,
                    y: 80,
                    floating: true,
                    borderWidth: 1,
                    backgroundColor:
                        Highcharts.defaultOptions.legend.backgroundColor || '#FFFFFF',
                    shadow: true,
                    enabled: false
                },
                credits: {
                    enabled: false
                },
                series: [{
                    name: txtTotal,
                    data: CasinoTotalArr
                }]
            });

            Highcharts.chart('container4', {
                chart: {
                    type: 'line'
                },
                title: {
                    text: txtHead5
                },
                xAxis: {
                    categories: GameAgentArr,
                    title: {
                        text: null
                    }
                },
                yAxis: {
                    min: 0,
                    title: {
                        text: txtTotal,
                        align: 'high'
                    },
                    labels: {
                        overflow: 'justify'
                    }
                },
                //tooltip: {
                //    valueSuffix: ' millions'
                //},
                plotOptions: {
                    line: {
                        dataLabels: {
                            enabled: false
                        },
                        enableMouseTracking: true
                    }
                },
                legend: {
                    layout: 'vertical',
                    align: 'right',
                    verticalAlign: 'top',
                    x: -40,
                    y: 80,
                    floating: true,
                    borderWidth: 1,
                    backgroundColor:
                        Highcharts.defaultOptions.legend.backgroundColor || '#FFFFFF',
                    shadow: true,
                    enabled: false
                },
                credits: {
                    enabled: false
                },
                series: [{
                    name: txtTotal,
                    data: GameTotalArr
                }]
            });

            Highcharts.chart('container5', {
                chart: {
                    type: 'line'
                },
                title: {
                    text: txtHead6
                },
                xAxis: {
                    categories: MultiAgentArr,
                    title: {
                        text: null
                    }
                },
                yAxis: {
                    min: 0,
                    title: {
                        text: txtTotal,
                        align: 'high'
                    },
                    labels: {
                        overflow: 'justify'
                    }
                },
                //tooltip: {
                //    valueSuffix: ' millions'
                //},
                plotOptions: {
                    line: {
                        dataLabels: {
                            enabled: false
                        },
                        enableMouseTracking: true
                    }
                },
                legend: {
                    layout: 'vertical',
                    align: 'right',
                    verticalAlign: 'top',
                    x: -40,
                    y: 80,
                    floating: true,
                    borderWidth: 1,
                    backgroundColor:
                        Highcharts.defaultOptions.legend.backgroundColor || '#FFFFFF',
                    shadow: true,
                    enabled: false
                },
                credits: {
                    enabled: false
                },
                series: [{
                    name: txtTotal,
                    data: MultiTotalArr
                }]
            });
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
                        pageSize: 1,
                        dataSource: 'https://api.flickr.com/services/feeds/photos_public.gne?tags=cat&tagmode=any&format=json&jsoncallback=?',
                        locator: 'items',
                        callback: function (response, pagination) {
                            NumPage = container.pagination('getSelectedPageNum');
                            $("#<%=thisPage.ClientID%>").val(NumPage);
                            Search_Click("paging");
                        }
                    });
                })('demo2');
            });
        }

        function clickzoom() {
            $('img.imgShow').on('click', function () {
                $('#overlay2')
                  .css({ backgroundImage: `url(${this.src})` })
                  .addClass('open')
                  .one('click', function () { $(this).removeClass('open'); });
            });

            var vid = document.getElementsByClassName("vdo");
            vid.onplay = function () {
            };

            $('#myModalLoad').modal('hide')
        }

        function Search_Click(event) {
            $("#myModalLoad").modal();
            $("#<%=eventPaging.ClientID%>").val(event);
            $("#<%=btnSearch.ClientID%>").click();
        }

        function btnExport() {
            var date = new Date();
            var dateSet = ("0" + date.getDate()).slice(-2) + "" + ("0" + (date.getMonth() + 1)).slice(-2) + "" + ("0" + date.getFullYear()).slice(-2) + "_" + ("0" + date.getHours()).slice(-2) + "" + ("0" + date.getMinutes()).slice(-2);

            if ("ActiveXObject" in window) {
                alert("Export excel is not support an internet explorer program.");
            } else {
                var cache = {};
                this.tmpl = function tmpl(str, data) {
                    var fn = !/\W/.test(str) ? cache[str] = cache[str] || tmpl(document.getElementById(str).innerHTML) :
                    new Function("obj",
                                 "var p=[],print=function(){p.push.apply(p,arguments);};" +
                                 "with(obj){p.push('" +
                                 str.replace(/[\r\t\n]/g, " ")
                                 .split("{{").join("\t")
                                 .replace(/((^|}})[^\t]*)'/g, "$1\r")
                                 .replace(/\t=(.*?)}}/g, "',$1,'")
                                 .split("\t").join("');")
                                 .split("}}").join("p.push('")
                                 .split("\r").join("\\'") + "');}return p.join('');");
                    return data ? fn(data) : fn;
                };
                var txtTemp = "";
                txtTemp = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{{=worksheet}}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body><table><tr><td colspan="7" style="font-weight: bold; text-align: center;">Total case report</td></tr></table>{{for(var i=0; i<tables.length;i++){ }}<table>{{=tables[i]}}</table>{{ } }}</body></html>';
                var tableToExcel = (function () {
                    var uri = 'data:application/vnd.ms-excel;base64,',
                        template = txtTemp;
                    base64 = function (s) {
                        return window.btoa(unescape(encodeURIComponent(s)));
                    },
                    format = function (s, c) {
                        return s.replace(/{(\w+)}/g, function (m, p) {
                            return c[p];
                        });
                    };
                    return function (tableList, name) {
                        if (!tableList.length > 0 && !tableList[0].nodeType) table = document.getElementById(table);
                        var tables = [];
                        for (var i = 0; i < tableList.length; i++) {
                            if (tableList[i].id != "tbData") {
                                tables.push(tableList[i].innerHTML);
                            }
                        }
                        var ctx = {
                            worksheet: name || 'Worksheet',
                            tables: tables
                        };
                        var a = document.createElement('a');
                        a.href = uri + base64(tmpl(template, ctx));
                        a.download = 'Report_Dashboard_' + dateSet + '.xls';
                        a.click();
                    };
                })();
                tableToExcel(document.getElementsByTagName("table"), "Report");
            }
        }

        function getModalDetail(type) {
            if (type == 0) {
                $("#modalSport").modal();
            }
            else if (type == 1) {
                $("#modalLotto").modal();
            }
            else if (type == 2) {
                $("#modalCasino").modal();
            }
            else if (type == 3) {
                $("#modalGame").modal();
            }
            else if (type == 4) {
                $("#modalMulti").modal();
            }
        }

        function getModalDetailToday(type) {
            if (type == 0) {
                $("#modalSportToday").modal();
            }
            else if (type == 1) {
                $("#modalLottoToday").modal();
            }
            else if (type == 2) {
                $("#modalCasinoToday").modal();
            }
            else if (type == 3) {
                $("#modalGameToday").modal();
            }
            else if (type == 4) {
                $("#modalMultiToday").modal();
            }
        }
    </script>
</asp:Content>

