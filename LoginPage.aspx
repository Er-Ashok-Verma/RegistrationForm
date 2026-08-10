 <%@ Page Language="C#" AutoEventWireup="true" CodeFile="LoginPage.aspx.cs" Inherits="Ashok_LoginPage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>ESIM Campus · Evaluation Portal</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
    <style>
        *{margin:0;padding:0;box-sizing:border-box}
        html,body{width:100%;height:100%;margin:0;padding:0;overflow:hidden}
        body{font-family:'Segoe UI',Arial,sans-serif;width:100%;height:100vh;display:flex;justify-content:center;align-items:center;padding:10px;background:#f8f9f8;color:#173b63;overflow:hidden}
        form{width:100%;height:100%;margin:0;padding:0;overflow:hidden}
        .login-wrapper{width:100%;max-width:510px;height:100vh;max-height:100vh;margin:auto;display:flex;flex-direction:column;justify-content:center;position:relative;z-index:2;overflow:hidden}
        .top-logo{width:100%;text-align:center;margin-bottom:4px;background:#e8edf4 ;border-radius:29px}
        .top-logo img{width:145px;max-width:55%;height:auto;display:inline-block;background:transparent;mix-blend-mode:multiply}
        .portal-title{text-align:center;font-size:19px;font-weight:400;color:#244b78;margin-bottom:15px}
        .login-card{width:100%;background:#e1e7ef;border-radius:40px;padding:25px 38px 23px;box-shadow:15px 15px 35px rgba(100,110,125,.22),-12px -12px 30px rgba(255,255,255,.95)}
        .signin-title{text-align:center;color:#243b5a;font-size:27px;font-weight:600;margin-bottom:19px}
        .signin-title i{color:#f04f5f;font-size:25px;margin-right:10px}
        .form-group{margin-bottom:13px}
        .form-label{display:block;margin-bottom:5px;color:#24476d;font-size:14px;font-weight:600}
        .form-label i{width:20px;margin-right:4px;color:#456887}
        .input-wrapper{position:relative;width:100%}
        .input-field{width:100%;height:49px;border:none;outline:none;border-radius:28px;padding:0 23px;background:#e3e8ef;color:#24476d;font-size:15px;box-shadow:inset 7px 7px 14px rgba(120,130,145,.18),inset -7px -7px 14px rgba(255,255,255,.95);transition:all .25s ease}
        .input-field:focus{box-shadow:inset 4px 4px 9px rgba(120,130,145,.18),inset -4px -4px 9px rgba(255,255,255,.95),0 0 0 2px rgba(62,96,130,.10)}
        .input-field::placeholder{color:#9aabc0}
        .password-wrapper .input-field{padding-right:65px}
        .password-toggle{position:absolute;right:8px;top:50%;transform:translateY(-50%);width:40px;height:40px;border:none;border-radius:50%;background:#e3e8ef;color:#496b8c;cursor:pointer;box-shadow:5px 5px 10px rgba(120,130,145,.15),-5px -5px 10px rgba(255,255,255,.9);transition:.2s ease}
        .password-toggle:hover{color:#173b63}
        .session-wrapper{position:relative;width:100%}
        .session-select{appearance:none;-webkit-appearance:none;width:100%;height:49px;border:none;outline:none;border-radius:28px;padding:0 48px 0 23px;background:#e3e8ef;color:#24476d;font-size:15px;box-shadow:inset 7px 7px 14px rgba(120,130,145,.18),inset -7px -7px 14px rgba(255,255,255,.95);cursor:pointer}
        .session-arrow{position:absolute;right:18px;top:50%;transform:translateY(-50%);pointer-events:none;color:#607890;font-size:12px}
        .captcha-row{width:100%;display:flex;align-items:center;gap:12px}
        .captcha-box{flex:1;height:58px;border-radius:29px;background:#e3e8ef;display:flex;align-items:center;justify-content:center;box-shadow:inset 7px 7px 14px rgba(120,130,145,.18),inset -7px -7px 14px rgba(255,255,255,.95)}
        .captcha-text{font-size:25px;font-weight:700;color:#24476d;letter-spacing:8px;user-select:none}
        .captcha-refresh{width:52px;height:52px;flex-shrink:0;border:none;border-radius:50%;background:#e3e8ef;color:#456887;font-size:23px;font-weight:bold;cursor:pointer;box-shadow:6px 6px 12px rgba(120,130,145,.18),-6px -6px 12px rgba(255,255,255,.9);transition:.3s}
        .captcha-refresh:hover{transform:rotate(180deg);color:#173b63}
        .captcha-input{margin-top:10px}
        .login-button{width:100%;height:53px;margin-top:3px;border:none;border-radius:30px;background:#e1e7ef;color:#173b63;font-size:20px;font-weight:600;cursor:pointer;box-shadow:9px 9px 18px rgba(105,115,130,.22),-9px -9px 18px rgba(255,255,255,.95);transition:all .25s ease}
        .login-button:hover{transform:translateY(-2px);box-shadow:12px 12px 22px rgba(105,115,130,.25),-10px -10px 20px rgba(255,255,255,.95)}
        .login-button:active{transform:translateY(1px);box-shadow:inset 5px 5px 10px rgba(105,115,130,.18),inset -5px -5px 10px rgba(255,255,255,.9)}
        .register-link{text-align:center;margin-top:10px}
        .register-link a{color:#456887;text-decoration:none;font-size:13px}
        .register-link a:hover{color:#173b63}
        .message{display:block;text-align:center;margin-top:7px;padding:4px 10px;border-radius:20px;font-size:13px;color:#24476d}
        .message.error{color:#c53d4d}
        .message.success{color:#21865a}
        .footer-card{margin-top:13px;min-height:55px;border-radius:32px;background:#e1e7ef;display:flex;align-items:center;justify-content:center;gap:12px;padding:6px 18px;box-shadow:10px 10px 25px rgba(100,110,125,.20),-10px -10px 25px rgba(255,255,255,.95)}
        .footer-logo-left{width:70px;height:auto}
        .footer-logo-right{width:78px;height:auto}
        .copyright{font-size:11px;color:#294d72;white-space:nowrap}
        .dashboard-box{text-align:center}
        .dashboard-icon{font-size:52px;color:#456887;margin-bottom:8px}
        .dashboard-name{display:block;font-size:21px;font-weight:600;color:#243b5a}
        .dashboard-email{display:block;margin-top:4px;color:#607890;font-size:13px}
        @media(max-height:750px){
            .top-logo img{width:115px}
            .portal-title{font-size:15px;margin-bottom:8px}
            .login-card{padding:18px 32px 16px}
            .signin-title{font-size:22px;margin-bottom:10px}
            .signin-title i{font-size:21px}
            .form-group{margin-bottom:7px}
            .form-label{margin-bottom:2px;font-size:12px}
            .input-field,.session-select{height:41px;font-size:13px}
            .password-toggle{width:34px;height:34px}
            .captcha-box{height:46px}
            .captcha-text{font-size:21px}
            .captcha-refresh{height:42px;width:42px;font-size:18px}
            .captcha-input{margin-top:5px}
            .login-button{height:44px;font-size:17px}
            .register-link{margin-top:5px}
            .footer-card{margin-top:7px;min-height:43px}
            .footer-logo-left{width:58px}
            .footer-logo-right{width:65px}
            .copyright{font-size:9px}
        }
        @media(max-width:600px){
            body{padding:8px}
            .login-wrapper{max-width:470px}
            .top-logo img{width:125px}
            .portal-title{font-size:16px;margin-bottom:10px}
            .login-card{padding:21px 22px 19px;border-radius:34px}
            .signin-title{font-size:24px;margin-bottom:14px}
            .form-group{margin-bottom:10px}
            .form-label{font-size:13px}
            .input-field,.session-select{height:45px;font-size:14px}
            .captcha-box{height:51px}
            .captcha-text{font-size:22px}
            .captcha-refresh{width:47px;height:47px}
            .login-button{height:48px;font-size:19px}
            .footer-card{margin-top:9px;min-height:48px;gap:7px;padding:5px 10px}
            .footer-logo-left{width:57px}
            .footer-logo-right{width:65px}
            .copyright{font-size:9px}
        }
        @media(max-width:400px){
            body{padding:5px}
            .top-logo img{width:105px}
            .portal-title{font-size:14px;margin-bottom:7px}
            .login-card{padding:17px 15px;border-radius:29px}
            .signin-title{font-size:21px;margin-bottom:10px}
            .signin-title i{font-size:19px}
            .form-group{margin-bottom:7px}
            .form-label{font-size:11px}
            .input-field,.session-select{height:40px;font-size:12px;padding-left:18px}
            .captcha-box{height:43px}
            .captcha-text{font-size:18px;letter-spacing:5px}
            .captcha-refresh{width:40px;height:40px}
            .login-button{height:43px;font-size:17px}
            /*.footer-card{min-height:60px;padding-left:20px; padding-right:20px;}*/
            .footer-logo-left{width:50px}
            .footer-logo-right{width:58px}
            .copyright{font-size:8px}
        }
    </style>
    <script type="text/javascript">
        function togglePassword() { var txt = document.getElementById('<%= txtPassword.ClientID %>'); var icon = document.getElementById('passwordIcon'); if (txt.type === 'password') { txt.type = 'text'; icon.className = 'fas fa-eye' } else { txt.type = 'password'; icon.className = 'fas fa-eye-slash' } }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-wrapper">
            <div class="top-logo"><img src="MKT_Softwares.png" alt="MKT Softwares" /></div>
            <div class="portal-title">ESIM Campus · Evaluation Portal</div>
            <div class="login-card">
                <asp:Panel ID="pnlLogin" runat="server">
                    <div class="signin-title"><i class="fas fa-user-graduate"></i>Sign In</div>
                    <div class="form-group">
                        <label class="form-label"><i class="fas fa-calendar-alt"></i>Session</label>
                        <div class="session-wrapper">
                            <select id="ddlSession" class="session-select"><option value="2026-2027">2026-2027</option></select>
                            <i class="fas fa-chevron-down session-arrow"></i>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="form-label"><i class="fas fa-user"></i>Username</label>
                        <div class="input-wrapper"><asp:TextBox ID="txtUsername" runat="server" CssClass="input-field" autocomplete="off" placeholder="Enter username or email"></asp:TextBox></div>
                    </div>
                    <div class="form-group">
                        <label class="form-label"><i class="fas fa-lock"></i>Password</label>
                        <div class="input-wrapper password-wrapper">
                            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="input-field" autocomplete="off" placeholder="Enter password"></asp:TextBox>
                            <button type="button" class="password-toggle" onclick="togglePassword();"><i id="passwordIcon" class="fas fa-eye-slash"></i></button>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="form-label"><i class="fas fa-shield-alt"></i>CAPTCHA</label>
                        <div class="captcha-row">
                            <div class="captcha-box"><asp:Label ID="lblCaptcha" runat="server" CssClass="captcha-text"></asp:Label></div>
                            <asp:Button ID="btnRefreshCaptcha" runat="server" Text="↻" CssClass="captcha-refresh" CausesValidation="false" OnClick="btnRefreshCaptcha_Click" />
                        </div>
                        <div class="input-wrapper captcha-input"><asp:TextBox ID="txtCaptcha" runat="server" CssClass="input-field" MaxLength="10" autocomplete="off" placeholder="Enter CAPTCHA"></asp:TextBox></div>
                    </div>
                    <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="login-button" OnClick="btnLogin_Click" />
                    <div class="register-link"><asp:LinkButton ID="lnkRegister" runat="server" OnClick="lnkRegister_Click"><i class="fas fa-user-plus"></i> New user? Create account</asp:LinkButton></div>
                </asp:Panel>
                <asp:Panel ID="pnlRegister" runat="server" Visible="false">
                    <div class="signin-title"><i class="fas fa-user-plus"></i>Create Account</div>
                    <div class="form-group">
                        <label class="form-label"><i class="fas fa-user"></i>Full Name</label>
                        <asp:TextBox ID="txtFullName" runat="server" CssClass="input-field" autocomplete="off" placeholder="Enter full name"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label class="form-label"><i class="fas fa-envelope"></i>Email</label>
                        <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="input-field" autocomplete="off" placeholder="Enter email address"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label class="form-label"><i class="fas fa-user-circle"></i>Username</label>
                        <asp:TextBox ID="txtRegUsername" runat="server" CssClass="input-field" autocomplete="off" placeholder="Choose username"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label class="form-label"><i class="fas fa-key"></i>Password</label>
                        <asp:TextBox ID="txtRegPassword" runat="server" TextMode="Password" CssClass="input-field" autocomplete="new-password" placeholder="Create password"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label class="form-label"><i class="fas fa-check-circle"></i>Confirm Password</label>
                        <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="input-field" autocomplete="new-password" placeholder="Confirm password"></asp:TextBox>
                    </div>
                    <asp:Button ID="btnRegister" runat="server" Text="Create Account" CssClass="login-button" OnClick="btnRegister_Click" />
                    <div class="register-link"><asp:LinkButton ID="lnkLogin" runat="server" OnClick="lnkLogin_Click"><i class="fas fa-arrow-left"></i> Back to Login</asp:LinkButton></div>
                </asp:Panel>
                <asp:Panel ID="pnlDashboard" runat="server" Visible="false">
                    <div class="dashboard-box">
                        <div class="dashboard-icon"><i class="fas fa-user-circle"></i></div>
                        <asp:Label ID="lblUserName" runat="server" CssClass="dashboard-name"></asp:Label>
                        <asp:Label ID="lblUserEmail" runat="server" CssClass="dashboard-email"></asp:Label>
                        <asp:Button ID="btnLogout" runat="server" Text="Sign Out" CssClass="login-button" style="margin-top:20px;" OnClick="btnLogout_Click" />
                    </div>
                </asp:Panel>
                <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>
            </div>
           <%-- <div class="footer-card">
                <img src="MKT_Softwares.png" class="footer-logo-left" alt="MKT Softwares" />
                <div class="copyright">© MKT Softwares Pvt. Ltd</div>
            </div>--%>
        </div>
    </form>
</body>
</html>