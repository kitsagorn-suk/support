<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Authen.aspx.cs" Inherits="Support_Project.Authen" %>
  
<!DOCTYPE html>  
  
<html xmlns="http://www.w3.org/1999/xhtml">  
<head runat="server">  
    <title></title>  
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />  
</head>  
<body>  
    <form id="form1" runat="server">  
        <div class="container">  
            <div class="jumbotron">  
                <h2 class="text-info text-center">กรุณายืนยันตัวตน</h2>  
                <div class="row text-center" style="margin-top: 20px;"><asp:Image ID="imgQrCode" runat="server" />  </div>
                <div class="row text-center" style="margin-top: 20px;">  
                    <div  style="display: inline-flex;">
                        <div class="form-group">  
                            <asp:TextBox runat="server" CssClass="form-control" ID="txtSecurityCode" MaxLength="20" style="width: 200px;" ToolTip="Please enter security code you get on your authenticator application">  
                            </asp:TextBox>  
                        </div>  
                        <asp:Button ID="btnValidate" OnClick="btnValidate_Click" CssClass="btn btn-primary" runat="server" Text="ยืนยัน" style="margin-left: 5px; height: 34px;" />  
                        </div>
                </div>  
                <div class="row text-center"><asp:Label ID="lblResult" runat="server" Text=""></asp:Label>  </div>
            </div>  
        </div>  
    </form>  
</body>  
</html>
