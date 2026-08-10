using System;
using System.Data.SqlClient;
using System.Configuration;

public partial class Ashok_LoginPage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            CheckAndCreateTable();

            if (Session["Username"] != null)
            {
                ShowDashboard();
            }
            else
            {
                GenerateNewCaptcha();
            }
        }
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string username = txtUsername.Text.Trim();
        string password = txtPassword.Text.Trim();
        string enteredCaptcha = txtCaptcha.Text.Trim();

        if (string.IsNullOrEmpty(username))
        {
            ShowMessageBox("Please Enter Username!");
            txtUsername.Focus();
            return;
        }

        if (string.IsNullOrEmpty(password))
        {
            ShowMessageBox("Please Enter Password!");
            txtPassword.Focus();
            return;
        }

        if (string.IsNullOrEmpty(enteredCaptcha))
        {
            ShowMessageBox("Please Enter Valid CAPTCHA!");
            txtCaptcha.Focus();
            return;
        }

        string generatedCaptcha = "";

        if (Session["LoginCaptcha"] != null)
        {
            generatedCaptcha = Session["LoginCaptcha"].ToString();
        }

        if (string.IsNullOrEmpty(generatedCaptcha))
        {
            ShowMessageBox("CAPTCHA expired! Please refresh CAPTCHA.");
            GenerateNewCaptcha();
            txtCaptcha.Text = "";
            return;
        }

        if (!string.Equals(enteredCaptcha, generatedCaptcha, StringComparison.OrdinalIgnoreCase))
        {
            ShowMessageBox("Invalid CAPTCHA! Please enter correct CAPTCHA.");
            txtCaptcha.Text = "";
            GenerateNewCaptcha();
            txtCaptcha.Focus();
            return;
        }

        Session.Remove("LoginCaptcha");

        if (ValidateUser(username, password))
        {
            Session["Username"] = username;
            Session["LoginTime"] = DateTime.Now;
            ShowDashboard();
            ShowMessage("Login successful!", "success");
        }
        else
        {
            ShowMessageBox("Invalid Username or Password!");
            txtPassword.Text = "";
            txtCaptcha.Text = "";
            GenerateNewCaptcha();
        }
    }

    protected void btnRefreshCaptcha_Click(object sender, EventArgs e)
    {
        txtCaptcha.Text = "";
        GenerateNewCaptcha();
        txtCaptcha.Focus();
    }

    protected void btnRegister_Click(object sender, EventArgs e)
    {
        string fullName = txtFullName.Text.Trim();
        string email = txtEmail.Text.Trim();
        string username = txtRegUsername.Text.Trim();
        string password = txtRegPassword.Text.Trim();
        string confirmPassword = txtConfirmPassword.Text.Trim();

        if (string.IsNullOrEmpty(fullName) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password) || string.IsNullOrEmpty(confirmPassword))
        {
            ShowMessageBox("Please fill all fields!");
            return;
        }

        if (password != confirmPassword)
        {
            ShowMessageBox("Passwords do not match!");
            return;
        }

        if (UserExists(username))
        {
            ShowMessageBox("Username already exists!");
            return;
        }

        if (RegisterUser(fullName, email, username, password))
        {
            ClearRegistrationFields();
            pnlRegister.Visible = false;
            pnlLogin.Visible = true;
            txtCaptcha.Text = "";
            GenerateNewCaptcha();
            ShowMessage("Registration successful! Please login.", "success");
        }
        else
        {
            ShowMessageBox("Registration failed!");
        }
    }

    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session.Clear();
        Session.Abandon();
        pnlDashboard.Visible = false;
        pnlRegister.Visible = false;
        pnlLogin.Visible = true;
        txtUsername.Text = "";
        txtPassword.Text = "";
        txtCaptcha.Text = "";
        GenerateNewCaptcha();
        ShowMessage("Logged out successfully!", "success");
    }

    protected void lnkRegister_Click(object sender, EventArgs e)
    {
        pnlLogin.Visible = false;
        pnlRegister.Visible = true;
        lblMessage.Text = "";
    }

    protected void lnkLogin_Click(object sender, EventArgs e)
    {
        pnlRegister.Visible = false;
        pnlLogin.Visible = true;
        txtCaptcha.Text = "";
        GenerateNewCaptcha();
        lblMessage.Text = "";
    }

    private SqlConnection GetConnection()
    {
        string connString = ConfigurationManager.ConnectionStrings["FeesManagementConn"].ConnectionString;
        return new SqlConnection(connString);
    }

    private bool ValidateUser(string username, string password)
    {
        try
        {
            CheckAndCreateTable();

            using (SqlConnection con = GetConnection())
            {
                string query = "SELECT COUNT(*) FROM Users WHERE Username=@Username AND Password=@Password";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Username", username);
                    cmd.Parameters.AddWithValue("@Password", password);
                    con.Open();
                    int count = Convert.ToInt32(cmd.ExecuteScalar());
                    return count > 0;
                }
            }
        }
        catch (Exception ex)
        {
            ShowMessageBox("Login error: " + ex.Message);
            return false;
        }
    }

    private bool UserExists(string username)
    {
        try
        {
            CheckAndCreateTable();

            using (SqlConnection con = GetConnection())
            {
                string query = "SELECT COUNT(*) FROM Users WHERE Username=@Username";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Username", username);
                    con.Open();
                    int count = Convert.ToInt32(cmd.ExecuteScalar());
                    return count > 0;
                }
            }
        }
        catch (Exception ex)
        {
            ShowMessageBox("Error checking user: " + ex.Message);
            return false;
        }
    }

    private bool RegisterUser(string fullName, string email, string username, string password)
    {
        try
        {
            CheckAndCreateTable();

            using (SqlConnection con = GetConnection())
            {
                string query = "INSERT INTO Users (FullName,Email,Username,Password,CreatedDate) VALUES (@FullName,@Email,@Username,@Password,@CreatedDate)";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@FullName", fullName);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Username", username);
                    cmd.Parameters.AddWithValue("@Password", password);
                    cmd.Parameters.AddWithValue("@CreatedDate", DateTime.Now);
                    con.Open();
                    int result = cmd.ExecuteNonQuery();
                    return result > 0;
                }
            }
        }
        catch (Exception ex)
        {
            ShowMessageBox("Registration error: " + ex.Message);
            return false;
        }
    }

    private void CheckAndCreateTable()
    {
        try
        {
            using (SqlConnection con = GetConnection())
            {
                con.Open();

                string query = "IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Users' AND xtype='U') BEGIN CREATE TABLE Users (UserID INT IDENTITY(1,1) PRIMARY KEY,FullName NVARCHAR(100) NOT NULL,Email NVARCHAR(100) NOT NULL,Username NVARCHAR(50) NOT NULL UNIQUE,Password NVARCHAR(100) NOT NULL,CreatedDate DATETIME DEFAULT GETDATE()) END";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.ExecuteNonQuery();
                }
            }
        }
        catch
        {
        }
    }

    private void ShowDashboard()
    {
        if (Session["Username"] != null)
        {
            string username = Session["Username"].ToString();

            try
            {
                using (SqlConnection con = GetConnection())
                {
                    string query = "SELECT FullName,Email FROM Users WHERE Username=@Username";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Username", username);
                        con.Open();

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                lblUserName.Text = "Welcome, " + reader["FullName"].ToString();
                                lblUserEmail.Text = "Email: " + reader["Email"].ToString();
                            }
                        }
                    }
                }
            }
            catch
            {
                lblUserName.Text = "Welcome, " + username;
                lblUserEmail.Text = "";
            }

            pnlLogin.Visible = false;
            pnlRegister.Visible = false;
            pnlDashboard.Visible = true;
        }
    }

    private void GenerateNewCaptcha()
    {
        string chars = "ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        Random random = new Random(Guid.NewGuid().GetHashCode());
        string captcha = "";

        for (int i = 0; i < 6; i++)
        {
            captcha += chars[random.Next(chars.Length)];
        }

        Session["LoginCaptcha"] = captcha;
        lblCaptcha.Text = captcha;
    }

    private void ShowMessage(string message, string type)
    {
        lblMessage.Text = message;
        lblMessage.CssClass = "message " + type;
    }

    private void ShowMessageBox(string message)
    {
        string safeMessage = message.Replace("\\", "\\\\").Replace("'", "\\'").Replace("\r", "").Replace("\n", " ");
        ClientScript.RegisterStartupScript(this.GetType(), "LoginMessage", "alert('" + safeMessage + "');", true);
    }

    private void ClearRegistrationFields()
    {
        txtFullName.Text = "";
        txtEmail.Text = "";
        txtRegUsername.Text = "";
        txtRegPassword.Text = "";
        txtConfirmPassword.Text = "";
    }
}