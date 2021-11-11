<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Support_Project.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=1480" />
    <meta http-equiv="x-ua-compatible" content="ie=edge" />
    <title>Ask Me Bet Support</title>
    <link rel="icon" href="img/amb-logo-full.png" />
    <link href="https://use.fontawesome.com/releases/v5.8.2/css/all.css" rel="stylesheet" />
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/mdb.min.css" rel="stylesheet" />
    <link href="css/style.css" rel="stylesheet" />
    <style>
        .waves-input-wrapper {
            display: block !important;
        }
    </style>
</head>
<body class="login-page">
    <div id="myModalLoad" class="modal" data-backdrop="static" data-keyboard="false" style="z-index: 9999;">
        <div class="d-flex justify-content-center" style="position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); color: #CFA137 !important;">
            <div class="spinner-border" role="status" style="width: 10rem; height: 10rem; font-size: 5rem;">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
    </div>

    <form runat="server" class="login-page">
        <div class="wrapper container h-100 d-flex justify-content-center align-items-center">
            <div class="login-section">
                <div class="card">
                    <div class="login-footer pt-4" style="padding-top: 1rem !important; border-bottom: 1px #fff solid; padding-bottom: 1rem !important;">
                        <a style="color: #fff;" id="txtLan">
                            <img src="img/Flag/thailand.png" style="width: 20px;" />&emsp;ไทย</a>
                        <div id="divblock" style="display: none; left: 12.2rem;">
                            <div style="border-bottom: 1px #ddd solid; padding: 3px;">
                                <a onclick="SetLanguage('Thai');">
                                    <img src="img/Flag/thailand.png" style="width: 20px;" />&emsp;ไทย
                                </a>
                            </div>
                            <div style="padding: 3px;">
                                <a onclick="SetLanguage('English');">
                                    <img src="img/Flag/usa.png" style="width: 20px;" />&emsp;English
                                </a>
                            </div>
                            <%--<div style="padding: 3px;">
                                <a onclick="SetLanguage('Chinese');">
                                    <img src="img/Flag/china.png" style="width: 20px;" />&emsp;中文
                                </a>
                            </div>--%>
                        </div>
                    </div>
                    <div class="card-header text-center" style="padding-top: 2.2rem; padding-bottom: 2rem;">
                        <a href="#" class="logo mx-auto">
                            <img src="img/amb-logo-full.png" style="width: 310px;" />
                        </a>
                        <div class="card-header-text" set-lan="html:Askmebet Support" style="font-size: 16pt; margin-top: 1rem;"></div>
                    </div>
                    <div class="card-body" <%--style="padding-bottom: 0 !important;"--%>>
                        <div class="card-body-holder" style="padding-bottom: 1.6rem;">
                            <div class="form-group row mb-4">
                                <div class="col-12">
                                    <div class="md-form md-outline">
                                        <%--<input type="text" id="username" class="form-control form-control-lg mb-0" autocomplete="off" onkeypress="clsAlphaNoOnly(event)" maxlength="30" />--%>
                                        <asp:TextBox ID="username" class="form-control form-control-lg mb-0" autocomplete="off" runat="server" MaxLength="30" />
                                        <label for="username" class="label" set-lan="html:Username"></label>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group row mb-4">
                                <div class="col-12">
                                    <div class="md-form md-outline">
                                        <%--<input type="password" id="password" class="form-control form-control-lg mb-0" autocomplete="off" maxlength="24" />--%>
                                        <asp:TextBox ID="password" type="password" class="form-control form-control-lg mb-0" autocomplete="off" runat="server" MaxLength="24" />
                                        <label for="password" class="label" set-lan="html:Password"></label>
                                        <span toggle="#password" class="toggle-password field-icon"><i class="far fa-eye-slash"></i></span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group row mb-4">
                                <div class="col-12">
                                    <asp:Button ID="btnlogin" class="btn btn-lg btn-yellow font-weight-bold btn-block" OnClick="Login_click" runat="server" Text="Sign in" Style="display: none;" />
                                    <button class="btn btn-lg btn-yellow font-weight-bold btn-block" onclick="Login()" id="btnSignIn" type="button" set-lan="text:Sign in"></button>
                                </div>
                            </div>
                            <div class="note-text white-text text-center">
                                <span style="font-size: 9pt;" set-lan="html:Contact your associate in case you forgot the password or unable to sign in"></span>
                            </div>
                        </div>
                    </div>
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

        <div class="modal fade" id="modalLanguage" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
            aria-hidden="true">
            <div class="modal-dialog" role="document" style="max-width: 250px !important;">
                <div class="modal-content" style="background-color: #66667A;">
                    <div class="modal-body mx-3 text-center">
                        <a onclick="SetLanguage('Thai');">
                            <div class="row">
                                <div class="col-md-10" style="color: #fff; text-align: right;">ไทย</div>
                                <div class="col-md-2">
                                    <img src="img/Flag/thailand.png" style="width: 27px;" />
                                </div>
                            </div>
                        </a>
                        <a onclick="SetLanguage('English');">
                            <div class="row" style="margin-top: .3rem;">
                                <div class="col-md-10" style="color: #fff; text-align: right;">English</div>
                                <div class="col-md-2">
                                    <img src="img/Flag/usa.png" style="width: 27px;" />
                                </div>
                            </div>
                        </a>
                        <a onclick="SetLanguage('Chinese');">
                            <div class="row" style="margin-top: .3rem;">
                                <div class="col-md-10" style="color: #fff; text-align: right;">中文</div>
                                <div class="col-md-2">
                                    <img src="img/Flag/china.png" style="width: 27px;" />
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="modalAlertAuthen" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
            aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header text-center">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body mx-3 text-center">
                        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>

                                <h4 class="text-center">กรุณายืนยันตัวตน</h4>
                                <asp:Literal ID="LiteralimgQrCode" runat="server"></asp:Literal>
                                <div class="text-center" style="margin-top: 20px; margin-bottom: 20px;">
                                    <div style="display: inline-flex;">
                                        <div class="form-group">
                                            <asp:TextBox runat="server" CssClass="form-control" ID="txtSecurityCode" MaxLength="20" Style="width: 200px;" ToolTip="Please enter security code you get on your authenticator application">  
                                            </asp:TextBox>
                                        </div>
                                        <button class="btn btn-yellow font-weight-bold" type="button" onclick="confirmAuthen()" style="margin-left: 10px; height: 40px;">ยืนยัน</button>
                                        <asp:Button ID="btnValidate" OnClick="btnValidate_Click" CssClass="btn btn-yellow font-weight-bold" runat="server" Text="ยืนยัน" Style="margin-left: 10px; height: 40px; display: none;" />
                                    </div>
                                    <div class="text-center" style="color: red;">
                                        <asp:Label ID="lblResult" runat="server" Text=""></asp:Label>
                                    </div>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <div style="margin-bottom:20px; text-align: left !important;">
                            วิธีการยืนยันตัวตน<br />
1. ให้ลูกค้าโหลด App Google Authentication<br />
2. ให้เข้า app แล้วสแกนคิวอาร์โค๊ด ***สแกนได้รอบเดียว***<br />
3. ใส่รหัสที่ app ให้มา ***รหัสจะรีใหม่ทุก 30 วิ***<br />
4. เข้าระบบซับพอร์ตเรียบร้อย<br /><br />

*** หากเคยสแกนแล้ว เมื่อเข้าใหม่ ให้เอารหัสจาก App Google Authentication มาใส่ได้เลย ***
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <asp:HiddenField ID="Lat" runat="Server"></asp:HiddenField>
        <asp:HiddenField ID="Long" runat="Server"></asp:HiddenField>
    </form>
    <!-- SCRIPTS -->
    <!-- JQuery -->
    <script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
    <!-- Bootstrap tooltips -->
    <script type="text/javascript" src="js/popper.min.js"></script>
    <!-- Bootstrap core JavaScript -->
    <!-- <script type="text/javascript" src="js/bootstrap.min.js"></script>-->
    <!-- MDB core JavaScript -->
    <script type="text/javascript" src="js/mdb.min.js"></script>
    <!-- ACE core JavaScript -->
    <script type="text/javascript" src="js/ace.min.js"></script>
    <!-- Language core JavaScript -->
    <script type="text/javascript" src="js/language_Login.js"></script>
    <script type="text/javascript">
        var ipAddress;
        var logLan = "Thai";
        $(document).ready(function () {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(showPosition);
            }

            //$(document).keyup(function (e) {
                //if (e.keyCode == 13 && $('#modalAlertAuthen').is(':visible')) {
                //    confirmAuthen();
                //}
                //else if (e.keyCode == 13) {
                //    Login();
                //}
            //});

            $("form").bind("keypress", function (e) {
                if (e.keyCode == 13) {
                    return false;
                }
            });

            $(document).on('keyup', function (e) {
                var key = e.which;
                if (key == 13) {
                    if ($('#modalAlertAuthen').is(':visible')) {
                        //This is an ENTER 
                        confirmAuthen();
                    }
                    else {
                        Login();
                    }
                }
            });

            $.getJSON("https://jsonip.com?callback=?", function (data) {
                ipAddress = data.ip;
            });

            localStorage.clear();


            $('#divblock').hide();
            $('#txtLan').click(function (e) {
                e.stopPropagation();
                $('#divblock').slideToggle();
            });
            $('#divblock').click(function (e) {
                e.stopPropagation();
            });
            $(document).click(function () {
                $('#divblock').slideUp();
            });

            //var txtLan = agentLang();
            SetLan(logLan);
            if (logLan == "Thai") {
                $("#txtLan").html("ไทย<img src='img/Flag/thailand.png' style='width: 20px; margin-left: .4rem;' />");
            }
            else if (logLan == "English") {
                $("#txtLan").html("English<img src='img/Flag/usa.png' style='width: 20px; margin-left: .4rem;' />");
            }
            else if (logLan == "Chinese") {
                $("#txtLan").html("中文<img src='img/Flag/china.png' style='width: 20px; margin-left: .4rem;' />");
            }

            localStorage.setItem("Language", logLan);
        });

        function confirmAuthen() {
            $("#myModalLoad").modal();
            $("#<%=btnValidate.ClientID%>").click();
        }

        function closeLoading() {
            $("#myModalLoad").modal('hide');
        }

        function showPosition(position) {
            $("#<%=Lat.ClientID%>").val(position.coords.latitude);
            $("#<%=Long.ClientID%>").val(position.coords.longitude);
            //console.log("Latitude: " + $("#<%=Lat.ClientID%>").val() + " Longitude: " + $("#<%=Long.ClientID%>").val());
        }

        function ShowModal() {
            $('#modalAlert').modal('show');

        }

        //function agentLang() {
        //    var lang = window.navigator.userLanguage || window.navigator.language;
        //    lang = lang.toLowerCase();
        //    var lg = "English";
        //    if (lang.includes("en")) {
        //        lg = "English";
        //    }
        //    else if (lang.includes("th") != -1) {
        //        lg = "Thai";
        //    }
        //    else if (lang.includes("cn") != -1) {
        //        lg = "Chinese";
        //    }
        //    else {
        //        lg = "English";
        //    }
        //    return lg;
        //}

        function ModalLanguage() {
            $("#modalLanguage").modal();
        }

        function Login() {
            $("#myModalLoad").modal();
            if ($('#username').val() == "") {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:missing 'Username' field");
                SetLan(logLan);
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else if ($('#password').val() == "") {
                document.getElementById("lbAlert").setAttribute("set-lan", "text:missing 'Password' field");
                SetLan(logLan);
                $('#modalAlert').modal('show');
                $("#myModalLoad").modal('hide');
            }
            else {
                $("#<%=btnlogin.ClientID%>").click();
            }
    }

    function getIPAddress() {
        var myPeerConnection = window.RTCPeerConnection || window.mozRTCPeerConnection || window.webkitRTCPeerConnection;
        var pc = new myPeerConnection({
            iceServers: []
        }),
        noop = function () { },
        localIPs = {},
        ipRegex = /([0-9]{1,3}(\.[0-9]{1,3}){3}|[a-f0-9]{1,4}(:[a-f0-9]{1,4}){7})/g,
        key;

        function iterateIP(ip) {
            if (!localIPs[ip]) onNewIP(ip);
            localIPs[ip] = true;
        }

        pc.createDataChannel("");

        pc.createOffer(function (sdp) {
            sdp.sdp.split('\n').forEach(function (line) {
                if (line.indexOf('candidate') < 0) return;
                line.match(ipRegex).forEach(iterateIP);
            });

            pc.setLocalDescription(sdp, noop, noop);
        }, noop);

        pc.onicecandidate = function (ice) {
            if (!ice || !ice.candidate || !ice.candidate.candidate || !ice.candidate.candidate.match(ipRegex)) return;
            ice.candidate.candidate.match(ipRegex).forEach(iterateIP);
        };
    }

    function alertModalAuthen() {
        $('#modalAlertAuthen').modal('show');
        $("#myModalLoad").modal('hide');
    }

    function alertModal(txtAlert) {
        document.getElementById("lbAlert").setAttribute("set-lan", "text:" + txtAlert + "");
        SetLan(localStorage.getItem('Language'));
        $('#modalAlert').modal('show');
        $("#myModalLoad").modal('hide');
        setTimeout(function () { $('#modalAlert').modal('hide') }, 2000);
    }

    function SetLanguage(ele) {
        SetLan(ele);
        if (ele == "Thai") {
            $("#txtLan").html("ไทย<img src='img/Flag/thailand.png' style='width: 20px; margin-left: .4rem;' />");
        }
        else if (ele == "English") {
            $("#txtLan").html("English<img src='img/Flag/usa.png' style='width: 20px; margin-left: .4rem;' />");
        }
        else if (ele == "Chinese") {
            $("#txtLan").html("中文<img src='img/Flag/china.png' style='width: 20px; margin-left: .4rem;' />");
        }

        logLan = ele;
        localStorage.setItem("Language", logLan);

        $('#divblock').slideUp();
    }

    function clsAlphaNoOnly(e) {
        var regex = new RegExp("^[a-zA-Z0-9@]+$");
        var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
        if (regex.test(str)) {
            return true;
        }

        e.preventDefault();
        return false;
    }
    </script>
</body>
</html>
