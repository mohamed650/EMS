<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/Register.css">
<link rel="stylesheet" href="/css/Cssboot.css">
<link rel="stylesheet" href="/css/common.css">
<script src="/js/fontAwesome.js"></script>
<script src="/js/jquery.js"></script>
<script src="/js/Jquery1.16.0.js"></script>
<jsp:include page="common/header.jsp"></jsp:include>
<script src="/js/common.js"></script>
</head>
<body>
<div class="registercontainer">
	<div class="register-title">
		<p>Register New Employees</p>
	</div>
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
					<input type="text" id="FirstName" style="width: 430px;" onkeypress="return onlyAlphabets(event)"/>
					<span>&#42</span>
				</div>
			</div>
			<div class="row g-0" style="margin-top: 2.5px;">
				<div class="col-md-3 title">
					<p>Last Name</p>
				</div>
				<div class="col-md-9 title-box">
					<input type="text" id="LastName" style="width: 430px;" onkeypress="return onlyAlphabets(event)"/>
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
					<input type="tel" id="ContactNumber" maxlength=10 style="width: 230px;" onkeypress="return onlyNumbers(event)"/>
					<span>&#42</span>
				</div>
			</div>
			<div class="row g-0" style="margin-top: 2px;">
				<div class="col-md-3 title">
					<p>Batch</p>
				</div>
				<div class="col-md-9 title-box">
					<select id="Batch" style="width: 170px;"></select>
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
					<p>Department Name</p>
				</div>
				<div class="col-md-9 title-box">
					<select id="DepartmentName" style="width: 280px;"></select>
				</div>
			</div>
			<div class="row g-0" style="margin-top: 2px;">
				<div class="col-md-3 title">
					<p>Designation</p>
				</div>
				<div class="col-md-9 title-box">
					<select id="Designation" style="width: 280px;"></select>
				</div>
			</div>
			<div class="row g-0" style="margin-top: 2.5px;">
				<div class="col-md-3 title">
					<p>Account Number</p>
				</div>
				<div class="col-md-9 title-box">
					<select id="bankoption">
						<option value="1">SBI</option>
						<option value="2">IDBI</option>
					</select>
					<input type="text" id="AccountNumber" style="width: 280px;" maxlength=11/>
				</div>
			</div>
			<div class="row g-0" style="margin-top: 2px;">
				<div class="col-md-3 title">
					<p>PF Account Number</p>
				</div>
				<div class="col-md-9 title-box">
					<input type="text" id="PFAccountNo" style="width: 120px;" value="KN/PNY/XXXXX/" disabled/>
					<input type="text" id="PFAccountNumber" style="width: 150px;"/>
				</div>
			</div>
			<div class="row g-0" style="margin-top: 2.5px;">
				<div class="col-md-3 title">
					<p>PAN</p>
				</div>
				<div class="col-md-9 title-box">
					<input type="text" id="PAN" style="width: 280px;"/>
				</div>
			</div>
			<div class="row g-0" style="margin-top: 18px; margin-bottom: 20px;">
				<div class="col-md-4 form-btn1">
					<input type="button" id="submitbtn" onclick="registerEmployee()" value="Register"/>
				</div>
				<div class="col-md-8 form-btn2">
					<input type="reset" id="resetbtn" value="Reset"/>
				</div>
			</div>
		</form>
	</div>
</div>
<script src="/js/Register.js"></script>
</body>
</html>