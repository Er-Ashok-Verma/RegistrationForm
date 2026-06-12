<%@ Page Language="C#" AutoEventWireup="true" CodeFile="xyz.aspx.cs" Inherits="Ashok_xyz" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Student Registration</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" />
    
    <style>

    .mandatoryfields {
        color: red;
    }

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        background: white;
        min-height: 100vh;
        font-family: 'Segoe UI', sans-serif;
        padding: 20px;
    }

    /* MAIN CARD */
    .main-card {
        background: white;
        border-radius: 25px;
        padding: 35px;
        box-shadow: 0 10px 35px rgba(0,0,0,0.25);
        border: 1px solid rgba(255,255,255,0.2);
        margin-top: 20px;
    }

    /* TITLE */
    .title {
        background-color: #243b55;
        padding: 10px;
        border-radius: 2px;
        text-align: center;
        font-size: 30px;
        font-weight: 700;
        color: white;
        margin-bottom: 35px;
        text-shadow: 2px 2px 8px rgba(0,0,0,0.3);
    }

    .title i {
        color: #ffd43b;
        margin-right: 10px;
    }

    /* FORM LABEL */
    .form-label {
        font-weight: 600;
        color: black;
        margin-bottom: 7px;
        letter-spacing: 0.5px;
    }

    /* INPUT DESIGN */
    .form-control,
    .form-select {
        border-radius: 4px;
        height: 38px;
        border: 2px solid;
        padding-left: 15px;
        background: rgba(255,255,255,0.9);
        transition: 0.3s;
        font-size: 15px;
    }

    .form-control:focus,
    .form-select:focus {
        transform: translateY(-2px);
        box-shadow: 0px 0px 15px rgba(255,255,255,0.7);
        background: white;
    }

    /* RADIO BOX */
    .radio-box {
        background: rgba(255,255,255,0.9);
        padding: 12px;
        height: 50px;
        display: flex;
        align-items: center;
    }

    /* BUTTON */
    .btn-register,
    .btn-black {
        border: none;
        color: white;
        border-radius: 50px;
        font-size: 18px;
        font-weight: bold;
        transition: 0.4s;
        box-shadow: 0px 6px 18px rgba(0,0,0,0.3);
    }

    .btn-register {
        background: linear-gradient(45deg,#ff512f,#dd2476);
        padding: 10px 20px;
    }

    .btn-black {
        background: black;
        padding: 10px 28px;
    }

    .btn-register:hover,
    .btn-black:hover {
        transform: scale(1.06);
        box-shadow: 0px 10px 25px rgba(0,0,0,0.4);
    }

    /* GRID BOX */
    .grid-box {
        background: rgba(255,255,255,0.12);
        border-radius: 25px;
        padding: 25px;
        margin-top: 30px;
        overflow-x: auto;
        box-shadow: 0px 10px 30px rgba(0,0,0,0.25);
    }

    /* TABLE */
    .table {
        min-width: 1200px;
        border-radius: 15px;
        overflow: hidden;
        background: white;
    }

    .table th {
        background: linear-gradient(45deg,#141e30,#243b55);
        color: white;
        text-align: center;
        padding: 14px;
        font-size: 15px;
        white-space: nowrap;
    }

    .table td {
        text-align: center;
        vertical-align: middle;
        padding: 12px;
        white-space: nowrap;
    }

    .table tr:hover {
        background-color: #f1f5ff;
        transition: 0.3s;
    }

    /* GRID BUTTONS */
    .btn-danger,
    .btn-success {
        border-radius: 20px;
        padding: 5px 15px;
        font-weight: 600;
    }

    /* MOBILE RESPONSIVE */
    @media(max-width:768px) {

        body {
            padding: 10px;
        }

        .main-card {
            padding: 20px;
            border-radius: 20px;
        }

        .title {
            font-size: 28px;
            line-height: 40px;
        }

        .btn-register,
        .btn-black {
            width: 100%;
            font-size: 17px;
        }

        .form-control,
        .form-select {
            height: 48px;
        }

        .radio-box {
            height: auto;
            padding: 10px;
        }

        .table {
            min-width: 1000px;
        }
    }

    /* ANIMATION */
    .main-card,
    .grid-box {
        animation: fadeIn 0.8s ease-in-out;
    }

    @keyframes fadeIn {
        from {
            opacity: 0;
            transform: translateY(20px);
        }

        to {
            opacity: 1;
            transform: translateY(0px);
        }
    }

</style>

    <script>

        function validchar() {
            var char = event.keyCode;

            if ((char >= 65 && char <= 90) ||
                (char >= 97 && char <= 122) ||
                char == 32) {
                return true;
            }
            else {
                return false;
            }
        }

        function validnum() {
            var num = event.keyCode;

            if (num >= 48 && num <= 57) {
                return true;
            }
            else {
                return false;
            }
        }

    </script>

</head>

<body>

    <form id="form1" runat="server">

        <div class="container">

            <!-- FORM CARD -->
            <div class="main-card">

                <div class="title">
                    <i class="fa-solid fa-user-graduate"></i>
                    Student Registration
                </div>

                <div class="row g-3">

                    <!-- Roll Number -->
                    <div class="col-lg-4 col-md-6 col-12">
                        <label class="form-label">1. Roll Number</label> <span class="mandatoryfields">*</span>
                        <asp:TextBox ID="txtRollno" runat="server"
                            CssClass="form-control"
                            MaxLength="8"
                            onkeypress="return validnum()"
                            placeholder="Enter Roll Number">
                        </asp:TextBox>
                    </div>

                    <!-- Student Name -->
                    <div class="col-lg-4 col-md-6 col-12">
                        <label class="form-label">2. Student Name</label><span class="mandatoryfields">*</span>
                        <asp:TextBox ID="txtStudentName" runat="server"
                            CssClass="form-control"
                            onkeypress="return validchar()"
                            placeholder="Enter Student Name">
                        </asp:TextBox>
                    </div>

                    <!-- Father Name -->
                    <div class="col-lg-4 col-md-6 col-12">
                        <label class="form-label">3. Father's Name</label><span class="mandatoryfields">*</span>
                        <asp:TextBox ID="txtFatherName" runat="server"
                            CssClass="form-control"
                            onkeypress="return validchar()"
                            placeholder="Enter Father Name">
                        </asp:TextBox>
                    </div>

                    <!-- DOB -->
                    <div class="col-lg-4 col-md-6 col-12">
                        <label class="form-label">4. Date Of Birth</label><span class="mandatoryfields">*</span>
                        <asp:TextBox ID="txtDateOfBirth" runat="server"
                            CssClass="form-control"
                            TextMode="Date">
                        </asp:TextBox>
                    </div>

                    <!-- Mobile -->
                    <div class="col-lg-4 col-md-6 col-12">
                        <label class="form-label">5. Mobile Number</label><span class="mandatoryfields">*</span>
                        <asp:TextBox ID="txtmobileNo" runat="server"
                            CssClass="form-control"
                            MaxLength="10"
                            onkeypress="return validnum()"
                            placeholder="Enter Mobile Number">
                        </asp:TextBox>
                    </div>

                    <!-- Email -->
                    <div class="col-lg-4 col-md-6 col-12">
                        <label class="form-label">6. Email ID</label><span class="mandatoryfields">*</span>
                        <asp:TextBox ID="txtEmailId" runat="server"
                            CssClass="form-control"
                            TextMode="Email"
                            placeholder="Enter Email">
                        </asp:TextBox>
                    </div>

                    <!-- City -->
                    <div class="col-lg-4 col-md-6 col-12">
                        <label class="form-label">7. City</label><span class="mandatoryfields">*</span>
                        <asp:DropDownList ID="ddlCity" runat="server"
                            CssClass="form-select">
                        </asp:DropDownList>
                    </div>

                    <!-- Address -->
                    <div class="col-lg-4 col-md-6 col-12">
                        <label class="form-label">8. Address</label><span class="mandatoryfields">*</span>
                        <asp:TextBox ID="txtAddress" runat="server"
                            CssClass="form-control"
                            placeholder="Enter Address">
                        </asp:TextBox>
                    </div>

                    <!-- Gender -->
                    <div class="col-lg-4 col-md-6 col-12">
                        <label class="form-label">9. Gender</label><span class="mandatoryfields">*</span>

                        <div class="radio-box">
                            <asp:RadioButtonList ID="rblGender" CssClass=" height: 38px;"
                                runat="server"
                                RepeatDirection="Horizontal">
                                <asp:ListItem Text="Male"></asp:ListItem>
                                <asp:ListItem Text="Female"></asp:ListItem>
                                <asp:ListItem Text="Other"></asp:ListItem>
                            </asp:RadioButtonList>
                        </div>
                    </div>

                    <!-- Course -->
                    <div class="col-lg-4 col-md-6 col-12">
                        <label class="form-label">10. Courses</label>

                        <asp:DropDownList ID="ddlCourses"
                            runat="server"
                            CssClass="form-select"
                            AutoPostBack="true"
                            OnSelectedIndexChanged="ddlCourses_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>

                    <!-- Branch -->
                    <div class="col-lg-4 col-md-6 col-12">
                        <label class="form-label">11. Branch</label>

                        <asp:DropDownList ID="ddlBranch"
                            runat="server"
                            CssClass="form-select">
                        </asp:DropDownList>
                    </div>

                    <!-- Password -->
                    <div class="col-lg-4 col-md-6 col-12">
                        <label class="form-label">12. Password</label><span class="mandatoryfields">*</span>

                        <asp:TextBox ID="txtPassword"
                            runat="server"
                            CssClass="form-control"
                            TextMode="Password"
                            placeholder="Enter Password">
                        </asp:TextBox>
                    </div>

                    <!-- Button -->
                    <div class="col-12 text-center mt-4">

                        <asp:Button ID="btnregister"
                            runat="server"
                            Text="Register"
                            CssClass="btn-register"
                            OnClick="btnregister_Click" />

                         <asp:Button ID="btnreset"
                            runat="server"
                            Text="Reset"
                            CssClass="btn-black"
                            OnClick="btnreset_Click"/>
                    </div>
                       

                </div>

            </div>

            <!-- GRIDVIEW -->
            <div class="grid-box">

                <asp:GridView ID="gridview"
                    runat="server"
                    AutoGenerateColumns="false"
                    DataKeyNames="ID,Studentname"
                    CssClass="table table-bordered table-hover">

                    <Columns>

                        <asp:TemplateField HeaderText="Sr.No">
                            <ItemTemplate>
                                <%# Container.DataItemIndex + 1 %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField HeaderText="Roll No" DataField="Rollnumber" />
                        <asp:BoundField HeaderText="Student Name" DataField="Studentname" />
                        <asp:BoundField HeaderText="Father Name" DataField="Fathername" />
                        <asp:BoundField HeaderText="DOB" DataField="Dateofbirth" />
                        <asp:BoundField HeaderText="Mobile" DataField="Mobile" />
                        <asp:BoundField HeaderText="Email" DataField="Email" />
                        <asp:BoundField HeaderText="City" DataField="CityName" />
                        <asp:BoundField HeaderText="Address" DataField="Address" />
                        <asp:BoundField HeaderText="Gender" DataField="Gender" />
                        <asp:BoundField HeaderText="Course" DataField="CoursesName" />
                        <asp:BoundField HeaderText="Branch" DataField="BranchName" />


                        <asp:TemplateField HeaderText="Delete">
                            <ItemTemplate>

                                <asp:Button ID="btndelete"
                                    runat="server"
                                    Text="Delete"
                                    CssClass="btn btn-danger btn-sm"
                                    OnClick="btndelete_Click" />

                            </ItemTemplate>
                        </asp:TemplateField>


                        <asp:TemplateField HeaderText="Edit">
                            <ItemTemplate>

                                <asp:Button ID="btnedit"
                                    runat="server"
                                    Text="Edit"
                                    CssClass="btn btn-success btn-sm"
                                    OnClick="btnedit_Click" />

                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>

                </asp:GridView>

                <asp:HiddenField ID="hidf" runat="server" />

            </div>

        </div>

    </form>

</body>
</html>
