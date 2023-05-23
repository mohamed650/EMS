<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="icon" type="image/x-icon" href="/images/scii-icon.jpg" />
<title><spring:message code="ems.label.discontinued.title"/></title>
<link rel="stylesheet" href="/css/EmployeeList.css">
<link rel="stylesheet" href="/css/Cssboot.css">
<link rel="stylesheet" href="/css/common.css">
<link rel="stylesheet" href="/css/Tabulator.css">
<script src="/js/fontAwesome.js"></script>
<script src="/js/jquery.js"></script>
<script src="/js/Jquery1.16.0.js"></script>
<script src="/js/Tabulator.js"></script>
<script src="/js/NoConnection.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<jsp:include page="common/header.jsp"></jsp:include>
<script src="/js/common.js"></script>
</head>
<body>
<div class="discontinuedcontainer">
	<div  class="employee-title">
		<p><spring:message code="ems.label.discontinued.heading"/></p>
	</div>
	<div class="employeesearchdiv">
		<fieldset class="schedular-border">
			<legend class="schedular-border" id="legend-title"><spring:message code="ems.label.discontinued.searchCondition"/></legend>
			<div class="employeename-div">
				<label><spring:message code="ems.label.employeeName"/></label>
				<input type="text" id="SearchEmployeeName"/>
			</div>
			<div class="batch-div">
				<label><spring:message code="ems.label.batch"/></label>
				<select id="SelectBatch"></select>
			</div>
			<div class="department-div">
				<label><spring:message code="ems.label.department"/></label>
				<select id="SelectDepartment"></select>
			</div>
			<div class="searchbtn-div">
				 <input type="button" id="SearchButton" value=<spring:message code="ems.button.search"/> onclick="searchTabulator()" />
			</div>
		</fieldset>
	</div>
	<div id="tabulator-div">
		<div id="discontinued-employeeTabulator"></div>
	</div>
</div>
<script src="/js/EmployeeList.js"></script>
<script src="/js/Discontinued.js"></script>
<script src="/js/Register.js"></script>
</body>
</html>