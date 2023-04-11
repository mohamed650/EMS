<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/common.css">
<link rel="stylesheet" href="/css/Cssboot.css">
<script src="/js/fontAwesome.js"></script>
<script src="/js/jquery.js"></script>
<script src="/js/Jquery1.16.0.js"></script>
</head>
<body>
<div class="maincontainer">
	<div class="firstcontainer">
		<img alt="logo" src="/images/sciilogo.jpg" id="company-logo">
		<p id="project-title">Employee Management System</p>
		<a id="logout" href="">LogOut</a>
	</div>
	<div class="secondcontainer">
		<div class="sub-secondcontainer">
			<ul id="ul-items">
				<li id="li-employee"><a href="/employeeList">Employee List</a></li>
				<li id="li-register"><a href="/navigateRegister">Register</a></li>
				<li id="li-salary"><a href="/navigateSalaryRetrieval">Salary Retrieval</a></li>
				<li id="li-discontinued"><a href="/navigateDiscontinuedEmployee">Discontinued Employee</a></li>
			</ul>
		</div>
	</div>
</div>
</body>
</html>