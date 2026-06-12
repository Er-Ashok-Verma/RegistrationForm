using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;
using System.Data;


public partial class Ashok_EmployeeRegister : System.Web.UI.Page
{
    DbFunctions objfun = new DbFunctions();

    protected void Page_Load(object sender, EventArgs e)
    {



        if (!IsPostBack)
        {
            objfun.FillDropdownlist(ddldepartment, "Department", "ID", "Select ID,Department from Department", "--Select--");

            objfun.FillDropdownlist(ddldesignation, "Designation", "ID", "Select ID,Designation from Designation", "--Select--");

            objfun.FillDropdownlist(ddlbloodgroup, "Bloodgroup", "ID", "Select ID,Bloodgroup from Bloodgroup", "--Select--");

            objfun.FillDropdownlist(ddlcountry, "CountryName", "CountryId", "Select CountryId, CountryName from Country", "--Select--");

            fillgrid();

        }
    }

    protected void btnsave_Click(object sender, EventArgs e)
    {

        if (!Regex.IsMatch(txtEmployeeName.Text, @"^[a-zA-Z ]+$"))
        {
            objfun.MsgBox("Only characters allowed ", this);
            txtEmployeeName.Focus();
            return;
        }
        if (txtEmployeeName.Text == "")
        {
            objfun.MsgBox("Please Enter Employee Name", this);
            txtEmployeeName.Focus();
            return;
        }
        if (txtdob.Text == "")
        {
            objfun.MsgBox("Please Enter DOB", this);
            txtdob.Focus();
            return;
        }
        if (txtmobile.Text == "")
        {
            objfun.MsgBox("Please Enter Mobile No", this);
            txtmobile.Focus();
            return;
        }
        string mobile = txtmobile.Text.Trim();
        Regex regex = new Regex(@"^[6-9][0-9]{9}$");


        if (!regex.IsMatch(mobile))
        {
            objfun.MsgBox("Please Enter Valid 10-digit Mobile Number", this);
            txtmobile.Focus();
            return;
        }

        if (!Regex.IsMatch(txtmobile.Text, @"^[0-9]+$"))
        {
            objfun.MsgBox("Only numbers allowed", this);
            txtmobile.Focus();
            return;
        }

        if (!Regex.IsMatch(txtemail.Text, @"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"))
        {
            objfun.MsgBox("Please Enter Valid Email ", this);
            txtemail.Focus();
            return;
        }

        if (txtemail.Text == "")
        {
            objfun.MsgBox("Please Enter Email Id", this);
            txtemail.Focus();
            return;
        }


        if (txtjoiningdate.Text == "")
        {
            objfun.MsgBox("Please Enter Joining Date", this);
            txtjoiningdate.Focus();
            return;
        }

        if (ddldepartment.SelectedItem.Text == "--Select--")
        {
            objfun.MsgBox("Please Select Department", this);
            ddldepartment.Focus();
            return;
        }

        if (ddldesignation.SelectedItem.Text == "--Select--")
        {
            objfun.MsgBox("Please Select Designation", this);
            ddldesignation.Focus();
            return;
        }
        if (ddlbloodgroup.SelectedItem.Text == "--Select--")
        {
            objfun.MsgBox("Please Select Blood Group", this);
            ddlbloodgroup.Focus();
            return;
        }

        if (rblgender.Text == "")
        {
            objfun.MsgBox("Please Select Gender", this);
            rblgender.Focus();
            return;
        }

        if (RadioButtonList1.Text == "")
        {
            objfun.MsgBox("Please Select Employee ID", this);
            RadioButtonList1.Focus();
            return;
        }

        if (cblLocation.SelectedItem == null)
        {
            objfun.MsgBox("Please Select Location", this);
            cblLocation.Focus();
            return;
        }

        if (txtEmployeeCode.Text == "")
        {
            objfun.MsgBox("Please Enter Employee Code", this);
            txtEmployeeCode.Focus();
            return;
        }

        if (btnsave.Text == "Save")
        {
            string EmployeeName = objfun.Get_details("select EmployeeName from EmployeeRegistration where MobileNo='" + txtmobile.Text + "'");

            int mobcount = Convert.ToInt32(objfun.Get_details("select count(*) from EmployeeRegistration where MobileNo='" + txtmobile.Text + "'"));

            if (mobcount > 0)
            {
                fillgrid();
                objfun.MsgBox("This Moblie No alredy assign.", this);
                txtmobile.Text = "";
                return;
            }

            {
                string empname = objfun.Get_details("select EmployeeName from EmployeeRegistration where Email='" + txtemail.Text + "'");

                int emailcount = Convert.ToInt32(objfun.Get_details("select count(*) from EmployeeRegistration where Email='" + txtemail.Text + "'"));

                if (emailcount > 0)
                {
                    fillgrid();
                    objfun.MsgBox("This Email alredy assign. Employee Name:" + empname + "", this);
                    txtmobile.Text = "";
                    return;
                }

                else
                {

                    string emp = objfun.Get_details("select EmployeeName from EmployeeRegistration where Email='" + txtEmployeeCode.Text + "'");
                    int count = Convert.ToInt32(objfun.Get_details("select count(*) from EmployeeRegistration where EmployeeCode='" + txtEmployeeCode.Text + "'"));
                    
                    if (count > 0)
                    {
                        fillgrid();
                        objfun.MsgBox("This Code alredy assign. Employee Name:" + emp + "", this);
                        txtEmployeeCode.Text = "";
                        return;
                    }
                    else
                    {
                        int CountInsert = objfun.ExecuteDML("insert into EmployeeRegistration(EmployeeName, DOB, MobileNo, Email, JoiningDate, Department, Designation, BloodGroup, Country, State, City, Gender, EmployeeID, Location, EmployeeCode) Values('" + txtEmployeeName.Text + "','" + txtdob.Text + "', '" + txtmobile.Text + "', '" + txtemail.Text + "', '" + txtjoiningdate.Text + "', '" + ddldepartment.SelectedValue + "', '" + ddldesignation.SelectedValue + "', '" + ddlbloodgroup.SelectedValue + "', '" + ddlcountry.SelectedValue + "', '" + ddlstate.SelectedValue + "', '" + ddlcity.SelectedValue + "', '" + rblgender.SelectedValue + "', '" + RadioButtonList1.SelectedValue + "', '" + cblLocation.SelectedValue + "', '" + txtEmployeeCode.Text + "')");
                        if (CountInsert > 0)
                        {
                            fillgrid();
                            objfun.MsgBox("Data Saved Successfully...", this);
                        }
                        else
                        {
                            objfun.MsgBox("Data not Saved...", this);
                        }
                    }
                }
            }
        }
        else
        {
            int Updatecount = objfun.ExecuteDML("UPDATE EmployeeRegistration SET EmployeeName = '" + txtEmployeeName.Text + "', DOB = '" + txtdob.Text + "',  MobileNo = '" + txtmobile.Text + "', Email = '" + txtemail.Text + "',  JoiningDate = '" + txtjoiningdate.Text + "', Department = '" + ddldepartment.SelectedValue + "' , Designation = '" + ddldesignation.SelectedValue + "' , BloodGroup = '" + ddlbloodgroup.SelectedValue + "' , Country = '" + ddlcountry.SelectedValue + "' , State = '" + ddlstate.SelectedValue + "' , City = '" + ddlcity.SelectedValue + "' , Gender = '" + rblgender.SelectedValue + "' , EmployeeID = '" + RadioButtonList1.SelectedValue + "' , Location = '" + cblLocation.SelectedValue + "',  EmployeeCode = '" + txtEmployeeCode.Text + "' WHERE ID='" + hdnid.Value + "'");
            if (Updatecount > 0)
            {
                fillgrid();
                Reset();
                objfun.MsgBox("Data Update Successfully...", this);
            }
        }
        
    }

    protected void ddlcountry_SelectedIndexChanged(object sender, EventArgs e)
    {
        objfun.FillDropdownlist(ddlstate, "StateName", "StateId", "Select StateId, StateName from State where CountryId=" + ddlcountry.SelectedValue + " ", "--Select--");

        // string abhi = ddlcountry.SelectedValue;    value 
        //  astringbhi1 = ddlcountry.SelectedItem.Text; text

    }

    protected void ddlstate_SelectedIndexChanged(object sender, EventArgs e)
    {
        objfun.FillDropdownlist(ddlcity, "CityName", "CityId", "Select CityId, CityName from City where StateId=" + ddlstate.SelectedValue + " ", "--Select--");
    }


    public void Reset()
    {
        txtEmployeeName.Text = string.Empty;
        txtdob.Text = "";
        txtmobile.Text = "";
        txtemail.Text = "";
        txtjoiningdate.Text = "";
        ddldepartment.SelectedValue = "0";
        ddldesignation.SelectedValue = "0";
        ddlbloodgroup.SelectedValue = "0";
        ddlcountry.SelectedValue = "0";
        ddlstate.SelectedValue = "0";
        ddlcity.SelectedValue = "0";
        rblgender.ClearSelection();
        RadioButtonList1.ClearSelection();
        cblLocation.ClearSelection();
        txtEmployeeCode.Text = "";
        btnsave.Text = "Save";

    }

    protected void btnreset_Click(object sender, EventArgs e)
    {
        Reset();
    }

    public void fillgrid()
    {
        DataTable dt = new DataTable();

        dt = objfun.FillDataTable("SELECT EmployeeRegistration.*, Department.Department AS DepartmentName, Bloodgroup.BloodGroup AS BloodGroupName, Designation.Designation AS DesignationName, Country.CountryName, State.StateName, City.CityName FROM EmployeeRegistration INNER JOIN Department ON EmployeeRegistration.Department = Department.ID INNER JOIN Designation ON EmployeeRegistration.Designation = Designation.ID INNER JOIN Bloodgroup ON EmployeeRegistration.BloodGroup = Bloodgroup.ID INNER JOIN Country ON EmployeeRegistration.Country = Country.CountryId INNER JOIN State ON EmployeeRegistration.State = State.StateId INNER JOIN City ON EmployeeRegistration.City = City.CityId");
        if (dt.Rows.Count > 0)
        {
            grdEmpReg.DataSource = dt;
            grdEmpReg.DataBind();
            lblRecordCount.Text = dt.Rows.Count.ToString();
        }
        else
        {
            grdEmpReg.DataSource = null;
            grdEmpReg.DataBind();
            return;
        }
    }



    protected void btndelete_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        GridViewRow row = (GridViewRow)btn.NamingContainer;
        string ID = grdEmpReg.DataKeys[row.RowIndex].Values[0].ToString();
        string EmployeeName = grdEmpReg.DataKeys[row.RowIndex].Values[1].ToString();



        if (ID != "")
        {
            int deletecount = objfun.ExecuteDML("DELETE FROM EmployeeRegistration WHERE ID='" + ID + "'");
            if (deletecount > 0)
            {
                fillgrid();
                objfun.MsgBox("Employee " + EmployeeName + " Delete Successfully", this);
            }

        }

    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        GridViewRow row = (GridViewRow)btn.NamingContainer;

        string ID = grdEmpReg.DataKeys[row.RowIndex].Values[0].ToString();
        hdnid.Value = ID;

        DataTable dtedit = new DataTable();

        dtedit = objfun.FillDataTable("Select * from EmployeeRegistration where ID='" + ID + "' ");
        if (dtedit.Rows.Count > 0)
        {
            // textbox me data fill karna
            txtEmployeeName.Text = dtedit.Rows[0]["EmployeeName"].ToString();

            txtdob.Text = dtedit.Rows[0]["DOB"].ToString();

            txtmobile.Text = dtedit.Rows[0]["MobileNo"].ToString();

            txtemail.Text = dtedit.Rows[0]["Email"].ToString();

            txtjoiningdate.Text = dtedit.Rows[0]["JoiningDate"].ToString();

            ddldepartment.Text = dtedit.Rows[0]["Department"].ToString();

            ddldesignation.Text = dtedit.Rows[0]["Designation"].ToString();

            ddlbloodgroup.Text = dtedit.Rows[0]["BloodGroup"].ToString();

            ddlcountry.SelectedValue = dtedit.Rows[0]["Country"].ToString();
            ddlcountry_SelectedIndexChanged(sender, e);

            ddlstate.SelectedValue = dtedit.Rows[0]["State"].ToString();
            ddlstate_SelectedIndexChanged(sender, e);

            ddlcity.SelectedValue = dtedit.Rows[0]["City"].ToString();

            rblgender.SelectedValue = dtedit.Rows[0]["Gender"].ToString();

            RadioButtonList1.SelectedValue = dtedit.Rows[0]["EmployeeID"].ToString();

            cblLocation.SelectedValue = dtedit.Rows[0]["Location"].ToString();

            txtEmployeeCode.Text = dtedit.Rows[0]["EmployeeCode"].ToString();

            btnsave.Text = "Update";
        }


    }

}

