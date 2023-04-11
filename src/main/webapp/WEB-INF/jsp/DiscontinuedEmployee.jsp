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
<script src="/js/Tabulator.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<jsp:include page="common/header.jsp"></jsp:include>
<script src="/js/common.js"></script>
</head>
<body>
<div class="discontinuedcontainer">
	<div  class="employee-title">
		<p>List of Discontinued Employees</p>
	</div>
	<div class="employeesearchdiv">
		<fieldset class="schedular-border">
			<legend class="schedular-border" id="legend-title">Search Condition</legend>
			<div class="employeename-div">
				<label>Employee Name:</label>
				<input type="text" id="SearchEmployeeName"/>
			</div>
			<div class="batch-div">
				<label>Batch:</label>
				<select id="SelectBatch"></select>
			</div>
			<div class="department-div">
				<label>Department:</label>
				<select id="SelectDepartment"></select>
			</div>
			<div class="searchbtn-div">
				 <input type="button" id="SearchButton" onclick="searchTabulator()" value="Search"/>
			</div>
		</fieldset>
	</div>
</div>
<script src="/js/EmployeeList.js"></script>
<script src="/js/Register.js"></script>
</body>
</html>