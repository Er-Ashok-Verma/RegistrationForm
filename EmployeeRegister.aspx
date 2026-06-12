 <%@ Page Language="C#" AutoEventWireup="true" CodeFile="EmployeeRegister.aspx.cs" Inherits="Ashok_EmployeeRegister" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=yes, viewport-fit=cover">
    <title>Employee Registration | HR Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <style>
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

body{
    background: linear-gradient(135deg,#f5f7fa,#e4ecf5);
    font-family:'Segoe UI',sans-serif;
    padding:20px 12px;
    min-height:100vh;
}

/* Container */
.container{
    max-width:1200px !important;
}

/* Main Card */
.registration-card{
    background:#ffffff;
    border-radius:24px;
    overflow:hidden;
    box-shadow:0 10px 35px rgba(0,0,0,0.08);
    border:1px solid #e8e8e8;
}

/* Header */
.card-header{
    background:#0d093fe3;
    color:white;
    padding:12px;
    border:none;
}

.card-header h2{
    font-size:1.8rem;
    font-weight:700;
    margin-bottom:6px;
}

.card-header p{
    font-size:0.9rem;
    opacity:0.85;
}

/* Form Section */
.form-section{
    padding:30px 24px;
}

/* Labels */
.form-label{
    font-size:0.9rem;
    font-weight:600;
    color:#2f3640;
    margin-bottom:8px;
}

.required:after{
    content:" *";
    color:red;
}

/* Inputs */
.form-control,
.form-select{
    border-radius:14px;
    border:1.5px solid #dcdde1;
    padding:12px 14px;
    font-size:0.95rem;
    background:#fafafa;
    transition:0.3s;
}

.form-control:focus,
.form-select:focus{
    border-color:#636e72;
    box-shadow:0 0 0 4px rgba(99,110,114,0.15);
    background:white;
}

/* Radio & Checkbox */
.radio-group,
.checkbox-group{
    background:#f8f9fa;
    border:1px solid #e0e0e0;
    border-radius:14px;
    padding:12px;
}

.radio-group label,
.checkbox-group label{
    margin-right:18px;
    font-size:0.9rem;
}

/* Buttons */
.btn-save{
    background:linear-gradient(135deg,#00b894,#00cec9);
    border:none;
    color:white;
    padding:14px 30px;
    border-radius:50px;
    font-weight:600;
    font-size:1rem;
    transition:0.3s;
}

.btn-save:hover{
    transform:translateY(-2px);
    box-shadow:0 6px 20px rgba(0,184,148,0.3);
}

.btn-reset{
    background:linear-gradient(135deg,#fdcb6e,#e17055);
    border:none;
    color:white;
    padding:14px 30px;
    border-radius:50px;
    font-weight:600;
    font-size:1rem;
    transition:0.3s;
}

.btn-reset:hover{
    transform:translateY(-2px);
    box-shadow:0 6px 20px rgba(225,112,85,0.3);
}

/* Grid Section */
.grid-container{
    padding:25px;
    background:white;
}

.grid-title{
    font-size:1.4rem;
    font-weight:700;
    color:#2d3436;
    border-bottom:3px solid #636e72;
    display:inline-block;
    padding-bottom:6px;
}

/* Table */
.custom-grid{
    margin-top:20px;
    overflow:auto;
    border-radius:18px;
    box-shadow:0 5px 20px rgba(0,0,0,0.05);
}

.custom-grid table{
    width:100%;
    border-collapse:collapse;
}

.custom-grid th{
    background:#2d3436;
    color:white;
    padding:14px;
    text-align:center;
    font-size:0.85rem;
}

.custom-grid td{
    padding:12px;
    text-align:center;
    border-bottom:1px solid #f1f1f1;
    font-size:0.85rem;
}

.custom-grid tr:nth-child(even){
    background:#fafafa;
}

.custom-grid tr:hover{
    background:#f1f2f6;
}

/* Action Buttons */
.btn-action{
    border:none;
    padding:8px 14px;
    border-radius:30px;
    color:white;
    font-size:0.8rem;
    margin:2px;
}

.btn-edit{
    background:#6c5ce7;
}

.btn-delete{
    background:#d63031;
}

/* Record Badge */
.record-badge{
    background:#dfe6e9;
    color:#2d3436;
    padding:8px 16px;
    border-radius:30px;
    font-weight:600;
}

/* Mobile */
@media(max-width:768px){

    .card-header h2{
        font-size:1.4rem;
    }

    .form-section{
        padding:20px 14px;
    }

    .btn-save,
    .btn-reset{
        width:100%;
    }

    .custom-grid table{
        min-width:900px;
    }
}
</style>

    <script>
        function ValidChar(event) {
            var charCode = event.which || event.keyCode;
            if ((charCode >= 65 && charCode <= 90) ||
                (charCode >= 97 && charCode <= 122) ||
                charCode === 32) {
                return true;
            } else {
                alert("⚠️ Please enter only alphabetic characters");
                return false;
            }
        }

        function ValidNumeric(event) {
            var charCode = (event.which) ? event.which : event.keyCode;
            if (charCode >= 48 && charCode <= 57) {
                return true;
            } else {
                alert("⚠️ Please enter only numeric digits");
                return false;
            }
        }

        function validateEmail() {
            var email = document.getElementById('<%= txtemail.ClientID %>')?.value;
            if (email && (!email.includes('@') || !email.includes('.'))) {
                alert("⚠️ Please enter a valid email address");
                return false;
            }
            return true;
        }

        function validateMobile() {
            var mobile = document.getElementById('<%= txtmobile.ClientID %>')?.value;
            if (mobile && mobile.length !== 10) {
                alert("⚠️ Mobile number must be exactly 10 digits");
                return false;
            }
            return true;
        }
        
        // Mobile-friendly form validation
        function validateFormBeforeSubmit() {
            var empName = document.getElementById('<%= txtEmployeeName.ClientID %>')?.value.trim();
            var dob = document.getElementById('<%= txtdob.ClientID %>')?.value;
            var mobile = document.getElementById('<%= txtmobile.ClientID %>')?.value;
            var email = document.getElementById('<%= txtemail.ClientID %>')?.value;
            var joining = document.getElementById('<%= txtjoiningdate.ClientID %>')?.value;
            var dept = document.getElementById('<%= ddldepartment.ClientID %>')?.value;
            var desig = document.getElementById('<%= ddldesignation.ClientID %>')?.value;
            var country = document.getElementById('<%= ddlcountry.ClientID %>')?.value;

            if (!empName || !dob || !mobile || !email || !joining || !dept || !desig || !country) {
                alert('⚠️ Please fill all required fields (* marked)');
                return false;
            }

            if (mobile.length !== 10) {
                alert('⚠️ Mobile number must be exactly 10 digits');
                return false;
            }

            if (!email.includes('@') || !email.includes('.')) {
                alert('⚠️ Please enter a valid email address (e.g., name@company.com)');
                return false;
            }
            
            return true;
        }
        
        // Add loading effect on save button
        function showLoading(btn) {
            if (btn) {
                var originalText = btn.value;
                btn.value = "⏳ Saving...";
                btn.disabled = true;
                btn.classList.add('btn-loading');
                setTimeout(function() {
                    btn.disabled = false;
                    btn.value = originalText;
                    btn.classList.remove('btn-loading');
                }, 3000);
            }
        }
        
        // Ensure form validation on submit
        document.addEventListener('DOMContentLoaded', function() {
            var form = document.querySelector('form');
            var saveBtn = document.getElementById('<%= btnsave.ClientID %>');
            
            if (form && saveBtn) {
                saveBtn.addEventListener('click', function(e) {
                    if (!validateFormBeforeSubmit()) {
                        e.preventDefault();
                        e.stopPropagation();
                        return false;
                    }
                    showLoading(saveBtn);
                    return true;
                });
            }
            
            // Add scroll hint for grid on mobile
            var grid = document.querySelector('.custom-grid');
            if (grid && window.innerWidth < 768) {
                var hint = document.createElement('div');
                hint.className = 'scroll-hint';
                hint.innerHTML = '<i class="fas fa-arrow-left"></i> Swipe to view all columns <i class="fas fa-arrow-right"></i>';
                grid.parentNode.insertBefore(hint, grid.nextSibling);
            }
        });
        
        console.log("📱 Mobile-responsive Employee Registration loaded");
    </script>
</head>
<body>
    <div class="container">
        <div class="registration-card">
            <div class="card-header">
                <h2><i class="fas fa-user-plus"></i>Employee Registration Portal</h2>
                
            </div>

            <form id="form1" runat="server">
                <div class="form-section">
                    <div class="row g-3 g-md-4">
                        <!-- 1. Employee Name -->
                        <div class="col-12 col-sm-6 col-md-4">
                            <label class="form-label required"><i class="fas fa-user"></i>Employee Name</label>
                            <asp:TextBox ID="txtEmployeeName" runat="server" onkeypress="return ValidChar(event)" CssClass="form-control" placeholder="Full name" autocomplete="off"></asp:TextBox>
                        </div>

                        <!-- 2. DOB -->
                        <div class="col-12 col-sm-6 col-md-4">
                            <label class="form-label required"><i class="fas fa-calendar-alt"></i>Date of Birth</label>
                            <asp:TextBox ID="txtdob" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                        </div>

                        <!-- 3. Mobile -->
                        <div class="col-12 col-sm-6 col-md-4">
                            <label class="form-label required"><i class="fas fa-phone-alt"></i>Mobile Number</label>
                            <asp:TextBox ID="txtmobile" runat="server" MaxLength="10" onkeypress="return ValidNumeric(event)" CssClass="form-control" placeholder="10-digit number" inputmode="numeric"></asp:TextBox>
                        </div>

                        <!-- 4. Email -->
                        <div class="col-12 col-sm-6 col-md-4">
                            <label class="form-label required"><i class="fas fa-envelope"></i>Email Address</label>
                            <asp:TextBox ID="txtemail" runat="server" CssClass="form-control" placeholder="example@company.com" inputmode="email"></asp:TextBox>
                        </div>

                        <!-- 5. Joining Date -->
                        <div class="col-12 col-sm-6 col-md-4">
                            <label class="form-label required"><i class="fas fa-calendar-check"></i>Joining Date</label>
                            <asp:TextBox ID="txtjoiningdate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                        </div>

                        <!-- 6. Department -->
                        <div class="col-12 col-sm-6 col-md-4">
                            <label class="form-label required"><i class="fas fa-building"></i>Department</label>
                            <asp:DropDownList ID="ddldepartment" runat="server" CssClass="form-select">
                                <asp:ListItem Text="-- Select Department --" Value=""></asp:ListItem>
                                <asp:ListItem Text="IT" Value="IT"></asp:ListItem>
                                <asp:ListItem Text="HR" Value="HR"></asp:ListItem>
                                <asp:ListItem Text="Finance" Value="Finance"></asp:ListItem>
                                <asp:ListItem Text="Marketing" Value="Marketing"></asp:ListItem>
                                <asp:ListItem Text="Operations" Value="Operations"></asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <!-- 7. Designation -->
                        <div class="col-12 col-sm-6 col-md-4">
                            <label class="form-label required"><i class="fas fa-briefcase"></i>Designation</label>
                            <asp:DropDownList ID="ddldesignation" runat="server" CssClass="form-select">
                                <asp:ListItem Text="-- Select Designation --" Value=""></asp:ListItem>
                                <asp:ListItem Text="Software Engineer" Value="Software Engineer"></asp:ListItem>
                                <asp:ListItem Text="Senior Developer" Value="Senior Developer"></asp:ListItem>
                                <asp:ListItem Text="Project Manager" Value="Project Manager"></asp:ListItem>
                                <asp:ListItem Text="HR Executive" Value="HR Executive"></asp:ListItem>
                                <asp:ListItem Text="Accountant" Value="Accountant"></asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <!-- 8. Blood Group -->
                        <div class="col-12 col-sm-6 col-md-4">
                            <label class="form-label required"><i class="fas fa-tint"></i>Blood Group</label>
                            <asp:DropDownList ID="ddlbloodgroup" runat="server" CssClass="form-select">
                                <asp:ListItem Text="-- Select --" Value=""></asp:ListItem>
                                <asp:ListItem Text="A+" Value="A+"></asp:ListItem>
                                <asp:ListItem Text="A-" Value="A-"></asp:ListItem>
                                <asp:ListItem Text="B+" Value="B+"></asp:ListItem>
                                <asp:ListItem Text="B-" Value="B-"></asp:ListItem>
                                <asp:ListItem Text="O+" Value="O+"></asp:ListItem>
                                <asp:ListItem Text="O-" Value="O-"></asp:ListItem>
                                <asp:ListItem Text="AB+" Value="AB+"></asp:ListItem>
                                <asp:ListItem Text="AB-" Value="AB-"></asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <!-- 9. Country -->
                        <div class="col-12 col-sm-6 col-md-4">
                            <label class="form-label required"><i class="fas fa-globe"></i>Country</label>
                            <asp:DropDownList ID="ddlcountry" runat="server" CssClass="form-select" OnSelectedIndexChanged="ddlcountry_SelectedIndexChanged" AutoPostBack="true">
                                <asp:ListItem Text="-- Select Country --" Value=""></asp:ListItem>
                                <asp:ListItem Text="India" Value="India"></asp:ListItem>
                                <asp:ListItem Text="USA" Value="USA"></asp:ListItem>
                                <asp:ListItem Text="UK" Value="UK"></asp:ListItem>
                                <asp:ListItem Text="Canada" Value="Canada"></asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <!-- 10. State -->
                        <div class="col-12 col-sm-6 col-md-4">
                            <label class="form-label required"><i class="fas fa-map-marker-alt"></i>State</label>
                            <asp:DropDownList ID="ddlstate" runat="server" CssClass="form-select" OnSelectedIndexChanged="ddlstate_SelectedIndexChanged" AutoPostBack="true">
                                <asp:ListItem Text="-- Select State --" Value=""></asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <!-- 11. City -->
                        <div class="col-12 col-sm-6 col-md-4">
                            <label class="form-label required"><i class="fas fa-city"></i>City</label>
                            <asp:DropDownList ID="ddlcity" runat="server" CssClass="form-select">
                                <asp:ListItem Text="-- Select City --" Value=""></asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <!-- 12. Gender -->
                        <div class="col-12 col-sm-6 col-md-4">
                            <label class="form-label required"><i class="fas fa-venus-mars"></i>Gender</label>
                            <div class="radio-group">
                                <asp:RadioButtonList ID="rblgender" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Text="👨 Male" Value="Male"></asp:ListItem>
                                    <asp:ListItem Text="👩 Female" Value="Female"></asp:ListItem>
                                    <asp:ListItem Text="👤 Other" Value="Other"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                        </div>

                        <!-- 13. ID Proof -->
                        <div class="col-12 col-sm-6 col-md-4">
                            <label class="form-label required"><i class="fas fa-id-card"></i>ID Proof Type</label>
                            <div class="radio-group">
                                <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Text="🪪 Aadhar" Value="Aadhar Card"></asp:ListItem>
                                    <asp:ListItem Text="💳 PAN" Value="Pan Card"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                        </div>

                        <!-- 14. Location -->
                        <div class="col-12 col-sm-6 col-md-4">
                            <label class="form-label required"><i class="fas fa-location-dot"></i>Preferred Location</label>
                            <div class="checkbox-group">
                                <asp:CheckBoxList ID="cblLocation" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Text="Delhi" Value="Delhi" />
                                    <asp:ListItem Text="Mumbai" Value="Mumbai" />
                                    <asp:ListItem Text="Jaipur" Value="Jaipur" />
                                    <asp:ListItem Text="UP" Value="Uttar Pradesh" />
                                </asp:CheckBoxList>
                            </div>
                        </div>

                        <!-- 15. Employee Code -->
                        <div class="col-12 col-sm-6 col-md-4">
                            <label class="form-label required"><i class="fas fa-qrcode"></i>Employee Code</label>
                            <asp:TextBox ID="txtEmployeeCode" runat="server" onkeypress="return ValidNumeric(event)" TextMode="Number" CssClass="form-control" placeholder="Unique code" inputmode="numeric"></asp:TextBox>
                        </div>
                    </div>

                    <!-- Action Buttons - Mobile optimized -->
                    <div class="row mt-4 mt-md-5">
                        <div class="col-12 text-center d-flex flex-column flex-sm-row justify-content-center gap-2 gap-sm-3">
                            <asp:Button ID="btnsave" CssClass="btn btn-save" runat="server" Text="💾 Save Employee" OnClick="btnsave_Click" />
                            <asp:Button ID="btnreset" CssClass="btn btn-reset" runat="server" Text="🔄 Reset Form" OnClick="btnreset_Click" />
                        </div>
                    </div>
                </div>

                <!-- Grid Section with horizontal scroll on mobile -->
                <div class="grid-container">
                    <div class="d-flex justify-content-between align-items-center flex-wrap" style="gap: 12px;">
                        <div class="grid-title">
                            <i class="fas fa-users"></i>Employee Directory
                        </div>
                        <span class="record-badge badge bg-info text-dark p-2 rounded-pill">
                            <i class="fas fa-database"></i>Total: 
                            <asp:Label ID="lblRecordCount" runat="server" Text="0" ForeColor="blue" Font-Bold="true"></asp:Label>
                        </span>
                    </div>

                    <div class="custom-grid mt-3">
                        <asp:GridView ID="grdEmpReg" runat="server" AutoGenerateColumns="false" DataKeyNames="ID,EmployeeName" 
                            CssClass="table table-hover" GridLines="None" EmptyDataText="📋 No employee records found. Tap 'Save' to add first record.">
                            <Columns>

                                <asp:TemplateField HeaderText="Sr.No">
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex + 1 %>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:BoundField HeaderText="👤 Employee" DataField="EmployeeName" />
                                <asp:BoundField HeaderText="🎂 DOB" DataField="DOB" DataFormatString="{0:yyyy-MM-dd}" />
                                <asp:BoundField HeaderText="📱 Mobile" DataField="MobileNo" />
                                <asp:BoundField HeaderText="✉️ Email" DataField="Email" />
                                <asp:BoundField HeaderText="📅 Joining" DataField="JoiningDate" DataFormatString="{0:yyyy-MM-dd}" />
                                <asp:BoundField HeaderText="🏢 Dept" DataField="DepartmentName" />
                                <asp:BoundField HeaderText="💼 Designation" DataField="DesignationName" />
                                <asp:BoundField HeaderText="🌍 Country" DataField="CountryName" />
                                <asp:BoundField HeaderText="🗺️ State" DataField="StateName" />
                                <asp:BoundField HeaderText="🏙️ City" DataField="CityName" />
                                <asp:BoundField HeaderText="🩸 Blood" DataField="BloodgroupName" />
                                <asp:BoundField HeaderText="🆔 ID Proof" DataField="EmployeeID" />
                                <asp:BoundField HeaderText="⚧ Gender" DataField="Gender" />
                                <asp:BoundField HeaderText="📍 Location" DataField="Location" />
                                <asp:BoundField HeaderText="🔢 Emp Code" DataField="EmployeeCode" />

                                <asp:TemplateField HeaderText="⚙️ Actions">
                                    <ItemTemplate>
                                        <asp:Button ID="btnEdit" runat="server" Text="✏️ Edit" CssClass="btn-action btn-edit" OnClick="btnEdit_Click" />
                                        <asp:Button ID="btndelete" CssClass="btn-action btn-delete" runat="server" Text="🗑️ Delete" OnClick="btndelete_Click" />
                                    </ItemTemplate>
                                    <ItemStyle Width="140px" />
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle BackColor="#2C3E50" ForeColor="White" Font-Bold="True" />
                            <RowStyle BackColor="White" />
                            <AlternatingRowStyle BackColor="#F8F9FA" />
                        </asp:GridView>
                    </div>
                    <asp:HiddenField ID="hdnid" runat="server" />
                </div>
            </form>
        </div>
    </div>
</body>
</html>
 