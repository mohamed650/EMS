<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/EmployeeList.css">
<link rel="stylesheet" href="/css/Cssboot.css">
<link rel="stylesheet" href="/css/common.css">
<link rel="stylesheet" href="/css/Tabulator.css">
<script src="/js/fontAwesome.js"></script>
<script src="/js/jquery.js"></script>
<script src="/js/Jquery1.16.0.js"></script>
<script src="/js/jquery3.3.1.js"></script>
<script src="/js/Tabulator.js"></script>
<script src="/js/NoConnection.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<jsp:include page="common/header.jsp"></jsp:include>
<script src="/js/common.js"></script>
</head>
<body>
<div class="employeecontainer">
	<div  class="employee-title">
		<p>List of Employees</p>
	</div>
	<div class="employeesearchdiv">
		<fieldset class="schedular-border">
			<legend class="schedular-border" id="legend-title">Search Condition</legend>
			<div class="employeename-div">
				<label>Employee Name:</label>
				<input type="text" id="SearchEmployeeName"/>
			</div>
			<div class="department-div">
				<label>Department:</label>
				<select id="SelectDepartment"></select>
			</div>
			<div class="batch-div">
				<label>Batch:</label>
				<select id="SelectBatch"></select>
			</div>
			<div class="searchbtn-div">
				 <input type="button" id="SearchButton" onclick="searchTabulator()" value="Search"/>
			</div>
		</fieldset>
	</div>
	<div id="tabulator-div">
		<div id="employeeTabulator"></div>
	</div>
	
	<div class="modal fade" id="EmployeeUpdate" tabindex="-1" aria-labelledby="EmployeeUpdateLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
  		<div class="modal-dialog modal-lg modal-dialog-scrollable">
    		<div class="modal-content">
      			<div class="modal-header">
        			<h1 class="modal-title fs-5" id="EmployeeUpdateLabel">Update Employee</h1>
        			<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      			</div>
      			<div class="modal-body">
        			<div class="registerdiv">
						<form>
							<div class="row g-0">
								<div class="col-md-3 title">
									<p>Employee ID</p>
								</div>
								<div class="col-md-9 title-box">
									<input type="text" id="Employee_Id" style="width: 230px;"/>
									<span>&#42</span>
								</div>
							</div>
							<div class="row g-0" style="margin-top: 2px;">
								<div class="col-md-3 title">
									<p>First Name</p>
								</div>
								<div class="col-md-9 title-box">
									<input type="text" id="FirstName" style="width: 430px;"/>
									<span>&#42</span>
								</div>
							</div>
							<div class="row g-0" style="margin-top: 2.5px;">
								<div class="col-md-3 title">
									<p>Last Name</p>
								</div>
								<div class="col-md-9 title-box">
									<input type="text" id="LastName" style="width: 430px;"/>
								</div>
							</div>
							<div class="row g-0" style="margin-top: 2px;">
								<div class="col-md-3 title">
									<p>Gender</p>
								</div>
								<div class="col-md-9 title-box">
									<label>Male</label><input type="radio" name="gender" id="Male" value="Male"/>
									<label>Female</label><input type="radio" name="gender" id="Female" value="Female"/>
								</div>
							</div>
							<div class="row g-0" style="margin-top: 2px;">
								<div class="col-md-3 title">
									<p>Date Of Birth</p>
								</div>
								<div class="col-md-9 title-box">
									<input type="date" id="DateofBirth" style="width: 170px;"/>
								</div>
							</div>
							<div class="row g-0" style="margin-top: 2.5px;">
								<div class="col-md-3 title">
									<p>Address</p>
								</div>
								<div class="col-md-9 title-box">
									<input type="text" id="Address" style="width: 430px;"/>
									<span>&#42</span>
								</div>
							</div>
							<div class="row g-0" style="margin-top: 2px;">
								<div class="col-md-3 title">
									<p>Email ID</p>
								</div>
								<div class="col-md-9 title-box">
									<input type="email" id="Email_Id" style="width: 430px;"/>
								</div>
							</div>
							<div class="row g-0" style="margin-top: 2px;">
								<div class="col-md-3 title">
									<p>Contact Number</p>
								</div>
								<div class="col-md-9 title-box">
									<input type="text" id="IndianPhoneNo" style="width: 40px" value="+91" disabled/>
									<input type="tel" id="ContactNumber" maxlength=10 style="width: 230px;"/>
									<span>&#42</span>
								</div>
							</div>
							<div class="row g-0" style="margin-top: 2px;">
								<div class="col-md-3 title">
									<p>Batch</p>
								</div>
								<div class="col-md-9 title-box">
									<select id="BatchUpdate" style="width: 170px;"></select>
								</div>
							</div>
							<div class="row g-0" style="margin-top: 2px;">
								<div class="col-md-3 title">
									<p>Date of Joining</p>
								</div>
								<div class="col-md-9 title-box">
									<input type="date" id="DateofJoining" style="width: 170px;"/>
									<span>&#42</span>
								</div>
							</div>
							<div class="row g-0" style="margin-top: 2px;">
								<div class="col-md-3 title">
									<p>Date of Relieving</p>
								</div>
								<div class="col-md-9 title-box">
									<input type="date" id="DateofLeaving" style="width: 170px;"/>
								</div>
							</div>
							<div class="row g-0" style="margin-top: 2px;">
								<div class="col-md-3 title">
									<p>Department Name</p>
								</div>
								<div class="col-md-9 title-box">
									<select id="DepartmentNameList" style="width: 280px;"></select>
								</div>
							</div>
							<div class="row g-0" style="margin-top: 2px;">
								<div class="col-md-3 title">
									<p>Designation</p>
								</div>
								<div class="col-md-9 title-box">
									<select id="DesignationList" style="width: 280px;"></select>
								</div>
							</div>
							<div class="row g-0" style="margin-top: 2.5px;">
								<div class="col-md-3 title">
									<p>Account Number</p>
								</div>
								<div class="col-md-9 title-box">
									<select id="bankOption">
										<option value="1">SBI</option>
										<option value="2">IDBI</option>
									</select>
									<input type="text" id="AccountNumber" style="width: 280px;" maxlength="11"/>
								</div>
							</div>
							<div class="row g-0" style="margin-top: 2px;">
								<div class="col-md-3 title">
									<p>PF Account Number</p>
								</div>
								<div class="col-md-9 title-box">
									<input type="text" id="PFAccountNo" style="width: 120px;" value="KN/PNY/XXXXX/" disabled/>
									<input type="text" id="PFAccountNumber" style="width: 150px;" maxlength="4"/>
								</div>
							</div>
							<div class="row g-0" style="margin-top: 2.5px;">
								<div class="col-md-3 title">
									<p>PAN</p>
								</div>
								<div class="col-md-9 title-box">
									<input type="text" id="PAN" style="width: 280px;" maxlength="10"/>
								</div>
							</div>
							<div class="row g-0" style="margin-top: 2px;">
								<div class="col-md-3 title">
									<p>Discontinued</p>
								</div>
								<div class="col-md-9 title-box">
									<input type="checkbox" id="Discontinued"/>
								</div>
							</div>
						</form>
					</div>
      			</div>
      			<div class="modal-footer">
        			<button type="button" class="btn btn-outline-info waves-effect" data-bs-dismiss="modal">Close</button>
        			<button type="button" class="btn btn-info" onclick="updateEmployeeDetails()">Save</button>
      			</div>
    		</div>
  		</div>
	</div>
	
	<div class="modal fade" id="SalaryModal" tabindex="-1" aria-labelledby="SalaryModalLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
  		<div class="modal-dialog modal-lg">
    		<div class="modal-content">
      			<div class="modal-header">
        			<h1 class="modal-title fs-5" id="SalaryModalLabel">Salary Details</h1>
        			<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="closeSalaryModal()"></button>
      			</div>
      			<div class="modal-body">
        			<div class="registerdiv">
						<form>
							<div class="row g-0">
								<div class="col-md-3 title">
									<p>Employee ID</p>
								</div>
								<div class="col-md-9 title-box">
									<input type="text" id="Salary_Employee_Id" style="width: 230px;"/>
								</div>
							</div>
							<div class="row g-0" style="margin-top: 2px;">
								<div class="col-md-3 title">
									<p>Date</p>
								</div>
								<div class="col-md-9 title-box">
									<label>Month</label>
									<select id="Salary_Month" style="width: 100px;"></select>
									<label>Year</label>
									<select id="Salary_Year" style="width: 100px;"></select>
									<input type="button" id="CheckDate" style="margin-left: 8px; width: 85px;" value="Check"/>
								</div>
							</div>
							<div class="row g-0" style="margin-top: 2.5px;">
								<div class="col-md-3 title">
									<p>Basic Salary</p>
								</div>
								<div class="col-md-9 title-box">
									<input type="text" id="Basic_Salary" style="width: 200px;"/>
									<span>&#42</span>
								</div>
							</div>
							<div class="row g-0" style="margin-top: 2px;">
								<div class="col-md-3 title">
									<p>Worked Days</p>
								</div>
								<div class="col-md-9 title-box">
									<input type="text" id="Worked_Days" style="width: 200px;"/>
									<span>&#42</span>
								</div>
							</div>
							<div class="row g-0" style="margin-top: 2px;">
								<div class="col-md-3 title">
									<p>Sick Leave</p>
								</div>
								<div class="col-md-9 title-box">
									<input type="text" id="Sick_Leave" style="width: 200px;"/>
								</div>
								<div class="col-md-3 title">
									<p>Used Sick Leave</p>
								</div>
								<div class="col-md-9 title-box">
									<input type="text" id="Used_Sick_Leave" style="width: 200px;"/>
								</div>
							</div>
							<div class="row g-0" style="margin-top: 2.5px;">
								<div class="col-md-3 title">
									<p>Earned Leave</p>
								</div>
								<div class="col-md-9 title-box">
									<input type="text" id="Earned_Leave" style="width: 200px;"/>
								</div>
								<div class="col-md-3 title">
									<p>Earned Leave</p>
								</div>
								<div class="col-md-9 title-box">
									<input type="text" id="Used_Earned_Leave" style="width: 200px;"/>
								</div>
							</div>
						</form>
					</div>
      			</div>
      			<div class="modal-footer">
        			<button type="button" class="btn btn-outline-info waves-effect" data-bs-dismiss="modal" onclick="closeSalaryModal()">Close</button>
        			<button type="button" class="btn btn-info" id="insertSalaryBtn" onclick="insertSalaryDetails()">Save</button>
      			</div>
    		</div>
  		</div>
	</div>
</div>
<script src="/js/EmployeeList.js"></script>
<script src="/js/Register.js"></script>
</body>
</html>