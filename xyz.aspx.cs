using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text.RegularExpressions;

public partial class Ashok_xyz : System.Web.UI.Page
{
    DbFunctions objfun = new DbFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)  //Data show in Dropdown 
        {
            objfun.FillDropdownlist(ddlCity, "CityName", "CityId", "Select CityId,CityName from City", "--select--");
            objfun.FillDropdownlist(ddlCourses, "CoursesName", "CoursesId", "Select CoursesId,CoursesName from Courses", "--select--");
            Fillgrid();
        }
    }


    protected void btnregister_Click(object sender, EventArgs e)
    {

        if (txtRollno.Text == "")
        {
            objfun.MsgBox("Please Enter Roll Number", this);
            txtRollno.Focus();
            return;
        }

        if (txtStudentName.Text == "")
        {
            objfun.MsgBox("Please Enter Student Name", this);
            txtStudentName.Focus();
            return;
        }

        if (txtFatherName.Text == "")
        {
            objfun.MsgBox("Please Enter Father Name", this);
            txtFatherName.Focus();
            return;
        }


        if (txtmobileNo.Text == "")
        {
            objfun.MsgBox("Please Enter Mobile No.", this);
            txtmobileNo.Focus();
            return;
        }

        if (!Regex.IsMatch(txtEmailId.Text, @"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"))
        {
            objfun.MsgBox("Please Enter Valid Email ", this);
            txtEmailId.Focus();
            return;
        }

        if (txtEmailId.Text == "")
        {
            objfun.MsgBox("Please Enter Email", this);
            txtEmailId.Focus();
            return;
        }


        if (ddlCity.Text == "")
        {
            objfun.MsgBox("Please Enter Select City", this);
            ddlCity.Focus();
            return;
        }

        if (txtAddress.Text == "")
        {
            objfun.MsgBox("Please Enter Address", this);
            txtAddress.Focus();
            return;
        }

        if (txtPassword.Text == "")
        {
            objfun.MsgBox("Please Enter Password", this);
            txtPassword.Focus();
            return;
        }

        if (btnregister.Text == "Register")
        {
            string stu = objfun.Get_details("select Studentname from StudentRegistration where Rollnumber = '" + txtRollno.Text + "' ");
            int cont = Convert.ToInt32(objfun.Get_details("select count(*) from StudentRegistration where Rollnumber='" + txtRollno.Text + "'"));
            if (cont > 0)
            {
                Fillgrid();
                objfun.MsgBox("This Roll Number alredy assign by:" + stu + "", this);
                txtRollno.Text = "";
                return;
            }
            {
                string mob = objfun.Get_details("select Studentname from StudentRegistration where Mobile = '" + txtmobileNo.Text + "' ");
                int con = Convert.ToInt32(objfun.Get_details("select count(*) from StudentRegistration where Mobile='" + txtmobileNo.Text + "'"));
                if (con > 0)
                {
                    Fillgrid();
                    objfun.MsgBox("This Mobile Number alredy assign by:" + mob + "", this);
                    txtmobileNo.Text = "";
                    return;
                }
                {
                    string email = objfun.Get_details("select Studentname from StudentRegistration where Email = '" + txtEmailId.Text + "' ");
                    int co = Convert.ToInt32(objfun.Get_details("select count(*) from StudentRegistration where Email ='" + txtEmailId.Text + "'"));
                    if (co > 0)
                    {
                        Fillgrid();
                        objfun.MsgBox("This Email id alredy assign by:" + email + "", this);
                        txtEmailId.Text = "";
                        return;
                    }

                    else
                    {

                        int count = objfun.ExecuteDML("insert into StudentRegistration(Rollnumber, Studentname, Fathername, Dateofbirth, Mobile, Email, City, Address, Gender , Courses, Branch, Password)Values('" + txtRollno.Text + "', '" + txtStudentName.Text + "', '" + txtFatherName.Text + "', '" + txtDateOfBirth.Text + "', '" + txtmobileNo.Text + "', '" + txtEmailId.Text + "', '" + ddlCity.SelectedValue + "', '" + txtAddress.Text + "', '" + rblGender.SelectedValue + "' , '" + ddlCourses.SelectedItem.Value + "', '" + ddlBranch.SelectedValue + "', '" + txtPassword.Text + "')");
                        if (count > 0)
                        {
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
    

        Reset();

    }

    protected void ddlCourses_SelectedIndexChanged(object sender, EventArgs e)
    {
        objfun.FillDropdownlist(ddlBranch, "branchName", "branchId", "Select branchId, branchName from Branch where CoursesId=" + ddlCourses.SelectedValue + "", "--Select--");
    }


    //ddlCourses.SelectedValue-----ID Insert 

    // ddlCourses.SelectedItem.Text------Text Save 

    //ddlCourses.SelectedIndex------ item Index

    public void Reset()
    {
        txtRollno.Text = "";
        txtStudentName.Text = "";
        txtFatherName.Text = "";
        txtDateOfBirth.Text = "";
        txtmobileNo.Text = "";
        txtEmailId.Text = "";
        ddlCity.SelectedValue = "0";
        txtAddress.Text = "";
        rblGender.ClearSelection();
        ddlCourses.SelectedValue = "0";
        ddlBranch.ClearSelection();
        txtPassword.Text = "";
        if (btnregister.Text == "Register") ;

    }

    protected void btnreset_Click(object sender, EventArgs e)
    {
        Reset();
    }

    public void Fillgrid()
    {

        DataTable sr = new DataTable();
        sr = objfun.FillDataTable("SELECT Branch.branchName, Courses.CoursesName, City.CityName, StudentRegistration.ID, StudentRegistration.Rollnumber, StudentRegistration.Studentname, StudentRegistration.Fathername, StudentRegistration.Dateofbirth, StudentRegistration.Mobile, StudentRegistration.Email, StudentRegistration.City, StudentRegistration.Address, StudentRegistration.Gender, StudentRegistration.Courses, StudentRegistration.Branch, StudentRegistration.Password FROM StudentRegistration INNER JOIN City ON StudentRegistration.City = City.CityId INNER JOIN Courses ON StudentRegistration.Courses = Courses.CoursesId INNER JOIN Branch ON StudentRegistration.Branch = Branch.branchId");

        if (sr.Rows.Count > 0)
        {
            gridview.DataSource = sr;      // jaha se data aata h
            gridview.DataBind();           // GridView me  bandh (bind) karke screen par dikha
        }
        else
        {
            gridview.DataSource = null;
            gridview.DataBind();
        }

    }

    protected void btndelete_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        GridViewRow row = (GridViewRow)btn.NamingContainer;
        string ID = gridview.DataKeys[row.RowIndex].Values[0].ToString();
        string Studentname = gridview.DataKeys[row.RowIndex].Values[1].ToString();

        if (ID != "")
        {
            int deletecount = objfun.ExecuteDML("DELETE FROM StudentRegistration WHERE ID='" + ID + "'");
            if (deletecount > 0)
            {
                Fillgrid();
                objfun.MsgBox("Student" + Studentname + " Delete Successfully", this);
            }

        }
    }

    protected void btnedit_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        GridViewRow row = (GridViewRow)btn.NamingContainer;
        string ID = gridview.DataKeys[row.RowIndex].Values[0].ToString();
        hidf.Value = ID;

        DataTable dtedit = new DataTable();
        dtedit = objfun.FillDataTable("SELECT * FROM StudentRegistration where ID= '" + ID + "'");
        if (dtedit.Rows.Count > 0)
        {
            txtRollno.Text = dtedit.Rows[0]["Rollnumber"].ToString();

            txtStudentName.Text = dtedit.Rows[0]["Studentname"].ToString();

            txtFatherName.Text = dtedit.Rows[0]["Fathername"].ToString();

            txtDateOfBirth.Text = dtedit.Rows[0]["Dateofbirth"].ToString();

            txtmobileNo.Text = dtedit.Rows[0]["Mobile"].ToString();

            txtEmailId.Text = dtedit.Rows[0]["Email"].ToString();

            ddlCity.SelectedValue = dtedit.Rows[0]["City"].ToString();

            txtAddress.Text = dtedit.Rows[0]["Address"].ToString();

            rblGender.SelectedValue = dtedit.Rows[0]["Gender"].ToString();

            ddlCourses.SelectedValue = dtedit.Rows[0]["Courses"].ToString();
            ddlCourses_SelectedIndexChanged(sender, e);

            ddlBranch.SelectedValue = dtedit.Rows[0]["Branch"].ToString();

            txtPassword.Text = dtedit.Rows[0]["Password"].ToString();

            btnregister.Text = "Update";

        }
    }

     
}


