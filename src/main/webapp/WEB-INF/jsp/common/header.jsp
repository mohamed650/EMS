<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
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
		<p id="project-title"><spring:message code="ems.label.projectTitle"/></p>
		<a id="logout" href=""><spring:message code="ems.label.header.logout"/></a>
	</div>
	<div class="secondcontainer">
		<div class="sub-secondcontainer">
			<ul id="ul-items">
				<li id="li-employee"><a href="/employeeList"><spring:message code="ems.label.header.employeePage"/></a></li>
				<li id="li-register"><a href="/navigateRegister"><spring:message code="ems.label.header.registerPage"/></a></li>
				<li id="li-salary"><a href="/navigateSalaryRetrieval"><spring:message code="ems.label.header.salaryPage"/></a></li>
				<li id="li-discontinued"><a href="/navigateDiscontinuedEmployee"><spring:message code="ems.label.header.discontinuedPage"/></a></li>
			</ul>
		</div>
	</div>
</div>
</body>
</html>