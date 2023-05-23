<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="icon" type="image/x-icon" href="/images/scii-icon.jpg" />
<title><spring:message code="ems.label.employeeList.title"/></title>
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
		<p><spring:message code="ems.label.employeeList.listofEmployees"/></p>
	</div>
	<div class="employeesearchdiv">
		<fieldset class="schedular-border">
			<legend class="schedular-border" id="legend-title"><spring:message code="ems.label.employeeList.searchCondition"/></legend>
			<div class="employeename-div">
				<label><spring:message code="ems.label.employeeName"/></label>
				<input type="text" id="SearchEmployeeName"/>
			</div>
			<div class="department-div">
				<label><spring:message code="ems.label.department"/></label>
				<select id="SelectDepartment"></select>
			</div>
			<div class="batch-div">
				<label><spring:message code="ems.label.batch"/></label>
				<select id="SelectBatch"></select>
			</div>
			<div class="searchbtn-div">
				 <input type="button" id="SearchButton" onclick="searchTabulator()" value=<spring:message code="ems.button.search"/> />
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
        			<h1 class="modal-title fs-5" id="EmployeeUpdateLabel"><spring:message code="ems.label.employeeList.modalUpdate"/></h1>
        			<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      			</div>
      			<div class="modal-body">
        			<div class="registerdiv">
						<form>
							<div class="row g-0">
								<div class="col-md-3 title">
									<p><spring:message code="ems.label.employeeId"/></p>
								</div>
								<div class="col-md-9 title-box">
									<input type="text" id="Employee_Id" style="width: 230px;"/>
									<span><spring:message code="ems.label.asterisk"/></span>
								</div>
							</div>
							<div class="row g-0" style="margin-top: 2px;">
								<div class="col-md-3 title">
									<p><spring:message code="ems.label.firstName"/></p>
								</div>
								<div class="col-md-9 title-box">
									<input type="text" id="FirstName" style="width: 430px;" onkeypress="return onlyAlphabets(event)"/>
									<span><spring:message code="ems.label.asterisk"/></span>
								</div>
							</div>
							<div class="row g-0" style="margin-top: 2.5px;">
								<div class="col-md-3 title">
									<p><spring:message code="ems.label.lastName"/></p>
								</div>
								<div class="col-md-9 title-box">
									<input type="text" id="LastName" style="width: 430px;" onkeypress="return onlyAlphabets(event)"/>
								</div>
							</div>
							<div class="row g-0" style="margin-top: 2px;">
								<div class="col-md-3 title">
									<p><spring:message code="ems.label.gender"/></p>
								</div>
								<div class="col-md-9 title-box">
									<label><spring:message code="ems.label.genderMale"/></label><input type="radio" name="gender" id="Male" value="Male"/>
									<label><spring:message code="ems.label.genderFemale"/></label><input type="radio" name="gender" id="Female" value="Female"/>
								</div>
							</div>
							<div class="row g-0" style="margin-top: 2px;">
								<div class="col-md-3 title">
									<p><spring:message code="ems.label.dateofBirth"/></p>
								</div>
								<div class="col-md-9 title-box">
									<input type="date" id="DateofBirth" style="width: 170px;"/>
								</div>
							</div>
							<div class="row g-0" style="margin-top: 2.5px;">
								<div class="col-md-3 title">
									<p><spring:message code="ems.label.address"/></p>
								</div>
								<div class="col-md-9 title-box">
									<input type="text" id="Address" style="width: 430px;"/>
									<span><spring:message code="ems.label.asterisk"/></span>
								</div>
							</div>
							<div class="row g-0" style="margin-top: 2px;">
								<div class="col-md-3 title">
									<p><spring:message code="ems.label.email"/></p>
								</div>
								<div class="col-md-9 title-box">
									<input type="email" id="Email_Id" style="width: 430px;"/>
									<span><spring:message code="ems.label.asterisk"/></span>
								</div>
							</div>
							<div class="row g-0" style="margin-top: 2px;">
								<div class="col-md-3 title">
									<p><spring:message code="ems.label.contactNumber"/></p>
								</div>
								<div class="col-md-9 title-box">
									<input type="text" id="IndianPhoneNo" style="width: 40px" value="+91" disabled/>
									<input type="tel" id="ContactNumber" maxlength=10 style="width: 230px;" onkeypress="return onlyNumbers(event)"/>
									<span><spring:message code="ems.label.asterisk"/></span>
								</div>
							</div>
							<div class="row g-0" style="margin-top: 2px;">
								<div class="col-md-3 title">
									<p><spring:message code="ems.label.batch"/></p>
								</div>
								<div class="col-md-9 title-box">
									<select id="BatchUpdate" style="width: 170px;"></select>
								</div>
							</div>
							<div class="row g-0" style="margin-top: 2px;">
								<div class="col-md-3 title">
									<p><spring:message code="ems.label.dateofJoining"/></p>
								</div>
								<div class="col-md-9 title-box">
									<input type="date" id="DateofJoining" style="width: 170px;"/>
									<span><spring:message code="ems.label.asterisk"/></span>
								</div>
							</div>
							<div class="row g-0" style="margin-top: 2px;">
								<div class="col-md-3 title">
									<p><spring:message code="ems.label.dateofRelieving"/></p>
								</div>
								<div class="col-md-9 title-box">
									<input type="date" id="DateofLeaving" style="width: 170px;"/>
								</div>
							</div>
							<div class="row g-0" style="margin-top: 2px;">
								<div class="col-md-3 title">
									<p><spring:message code="ems.label.departmentName"/></p>
								</div>
								<div class="col-md-9 title-box">
									<select id="DepartmentNameList" style="width: 280px;"></select>
								</div>
							</div>
							<div class="row g-0" style="margin-top: 2px;">
								<div class="col-md-3 title">
									<p><spring:message code="ems.label.designation"/></p>
								</div>
								<div class="col-md-9 title-box">
									<select id="DesignationList" style="width: 280px;"></select>
								</div>
							</div>
							<div class="row g-0" style="margin-top: 2.5px;">
								<div class="col-md-3 title">
									<p><spring:message code="ems.label.accountNumber"/></p>
								</div>
								<div class="col-md-9 title-box">
									<select id="bankOption">
										<option value="1"><spring:message code="ems.label.accountOption1"/></option>
										<option value="2"><spring:message code="ems.label.accountOption2"/></option>
									</select>
									<input type="text" id="AccountNumber" style="width: 280px;" maxlength="11"/>
								</div>
							</div>
							<div class="row g-0" style="margin-top: 2px;">
								<div class="col-md-3 title">
									<p><spring:message code="ems.label.pfAccountNumber"/></p>
								</div>
								<div class="col-md-9 title-box">
									<input type="text" id="PFAccountNo" style="width: 120px;" value=<spring:message code="ems.label.pfAccountValue"/> disabled/>
									<input type="text" id="PFAccountNumber" style="width: 150px;" maxlength="4"/>
								</div>
							</div>
							<div class="row g-0" style="margin-top: 2.5px;">
								<div class="col-md-3 title">
									<p><spring:message code="ems.label.pan"/></p>
								</div>
								<div class="col-md-9 title-box">
									<input type="text" id="PAN" style="width: 280px;" maxlength="10"/>
								</div>
							</div>
							<div class="row g-0" style="margin-top: 2px;">
								<div class="col-md-3 title">
									<p><spring:message code="ems.label.discontinued"/></p>
								</div>
								<div class="col-md-9 title-box">
									<input type="checkbox" id="Discontinued"/>
								</div>
							</div>
						</form>
					</div>
      			</div>
      			<div class="modal-footer">
        			<button type="button" class="btn btn-outline-info waves-effect" data-bs-dismiss="modal"><spring:message code="ems.button.modalClose"/></button>
        			<button type="button" class="btn btn-info" onclick="updateEmployeeDetails()"><spring:message code="ems.button.modalSave"/></button>
      			</div>
    		</div>
  		</div>
	</div>
	
	<div class="modal fade" id="SalaryModal" tabindex="-1" aria-labelledby="SalaryModalLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
  		<div class="modal-dialog modal-lg">
    		<div class="modal-content">
      			<div class="modal-header">
        			<h1 class="modal-title fs-5" id="SalaryModalLabel"><spring:message code="ems.label.employeeList.modalSalary"/></h1>
        			<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="closeSalaryModal()"></button>
      			</div>
      			<div class="modal-body">
        			<div class="registerdiv">
						<form>
							<div class="row g-0">
								<div class="col-md-3 title">
									<p><spring:message code="ems.label.employeeId"/></p>
								</div>
								<div class="col-md-9 title-box">
									<input type="text" id="Salary_Employee_Id" style="width: 230px;"/>
								</div>
							</div>
							<div class="row g-0" style="margin-top: 2px;">
								<div class="col-md-3 title">
									<p><spring:message code="ems.label.date"/></p>
								</div>
								<div class="col-md-9 title-box">
									<label><spring:message code="ems.label.month"/></label>
									<select id="Salary_Month" style="width: 100px;"></select>
									<label><spring:message code="ems.label.year"/></label>
									<select id="Salary_Year" style="width: 100px;"></select>
									<input type="button" id="CheckDate" style="margin-left: 8px; width: 85px;" value=<spring:message code="ems.button.employeeList.salaryCheck"/>/>
								</div>
							</div>
							<div class="row g-0" style="margin-top: 2.5px;">
								<div class="col-md-3 title">
									<p><spring:message code="ems.label.basicSalary"/></p>
								</div>
								<div class="col-md-9 title-box">
									<input type="text" id="Basic_Salary" style="width: 200px;" onkeypress="return onlyNumbers(event)"/>
									<span><spring:message code="ems.label.asterisk"/></span>
								</div>
							</div>
							<div class="row g-0" style="margin-top: 2px;">
								<div class="col-md-3 title">
									<p><spring:message code="ems.label.workedDays"/></p>
								</div>
								<div class="col-md-9 title-box">
									<input type="text" id="Worked_Days" style="width: 200px;" onkeypress="return onlyNumbers(event)"/>
									<span><spring:message code="ems.label.asterisk"/></span>
								</div>
							</div>
							<div class="row g-0" style="margin-top: 2px;">
								<div class="col-md-3 title">
									<p><spring:message code="ems.label.sickLeave"/></p>
								</div>
								<div class="col-md-9 title-box">
									<input type="text" id="Sick_Leave" style="width: 200px;" onkeypress="return onlyNumbers(event)"/>
								</div>
								<div class="col-md-3 title">
									<p><spring:message code="ems.label.usedSickLeave"/></p>
								</div>
								<div class="col-md-9 title-box">
									<input type="text" id="Used_Sick_Leave" style="width: 200px;" onkeypress="return onlyNumbers(event)"/>
								</div>
							</div>
							<div class="row g-0" style="margin-top: 2.5px;">
								<div class="col-md-3 title">
									<p><spring:message code="ems.label.earnedLeave"/></p>
								</div>
								<div class="col-md-9 title-box">
									<input type="text" id="Earned_Leave" style="width: 200px;" onkeypress="return onlyNumbers(event)"/>
								</div>
								<div class="col-md-3 title">
									<p><spring:message code="ems.label.usedEarnedLeave"/></p>
								</div>
								<div class="col-md-9 title-box">
									<input type="text" id="Used_Earned_Leave" style="width: 200px;" onkeypress="return onlyNumbers(event)"/>
								</div>
							</div>
						</form>
					</div>
      			</div>
      			<div class="modal-footer">
        			<button type="button" class="btn btn-outline-info waves-effect" data-bs-dismiss="modal" onclick="closeSalaryModal()"><spring:message code="ems.button.modalClose"/></button>
        			<button type="button" class="btn btn-info" id="insertSalaryBtn" onclick="insertSalaryDetails()"><spring:message code="ems.button.modalSave"/></button>
      			</div>
    		</div>
  		</div>
	</div>
</div>
<script src="/js/EmployeeList.js"></script>
<script src="/js/Register.js"></script>
</body>
</html>