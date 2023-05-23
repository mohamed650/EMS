<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="icon" type="image/x-icon" href="/images/scii-icon.jpg" />
<title><spring:message code="ems.label.register.title"/></title>
<link rel="stylesheet" href="/css/Register.css">
<link rel="stylesheet" href="/css/Cssboot.css">
<link rel="stylesheet" href="/css/common.css">
<script src="/js/fontAwesome.js"></script>
<script src="/js/jquery.js"></script>
<script src="/js/Jquery1.16.0.js"></script>
<script src="/js/NoConnection.js"></script>
<jsp:include page="common/header.jsp"></jsp:include>
<script src="/js/common.js"></script>
</head>
<body>
<div class="registercontainer">
	<div class="register-title">
		<p><spring:message code="ems.label.register.registerHeader"/></p>
	</div>
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
					<select id="Batch" style="width: 170px;"></select>
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
					<p><spring:message code="ems.label.departmentName"/></p>
				</div>
				<div class="col-md-9 title-box">
					<select id="DepartmentName" style="width: 280px;"></select>
				</div>
			</div>
			<div class="row g-0" style="margin-top: 2px;">
				<div class="col-md-3 title">
					<p><spring:message code="ems.label.designation"/></p>
				</div>
				<div class="col-md-9 title-box">
					<select id="Designation" style="width: 280px;"></select>
				</div>
			</div>
			<div class="row g-0" style="margin-top: 2.5px;">
				<div class="col-md-3 title">
					<p><spring:message code="ems.label.accountNumber"/></p>
				</div>
				<div class="col-md-9 title-box">
					<select id="bankoption">
						<option value="1"><spring:message code="ems.label.accountOption1"/></option>
						<option value="2"><spring:message code="ems.label.accountOption2"/></option>
					</select>
					<input type="text" id="AccountNumber" style="width: 280px;" maxlength=11/>
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
			<div class="row g-0" style="margin-top: 18px; margin-bottom: 20px;">
				<div class="col-md-4 form-btn1">
					<input type="button" id="submitbtn" value=<spring:message code="ems.button.register"/> onclick="registerEmployee()"/>
				</div>
				<div class="col-md-8 form-btn2">
					<input type="reset" value=<spring:message code="ems.button.reset"/> id="resetbtn" />
				</div>
			</div>
		</form>
	</div>
</div>
<script src="/js/Register.js"></script>
</body>
</html>