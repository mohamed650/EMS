<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/Login.css">
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
	</div>
	<div class="secondcontainer">
	</div>
	<div class="title-div">
		<p>Login for Employee Management System</p>
		<form>
			<div class="title-div1">
				<label>LoginID :</label>
				<input type="text" class="user-input" id="Login_Id"/><span>&#42</span>
			</div>
			<div class="title-div2">
				<label>Password :</label>
				<input type="password" class="user-input" id="Password"/><span>&#42</span>
			</div>
			<div class="btn-div">
				<input type="button" class="user-btn" value="Login" onclick="loginValidate()"/>
				<input type="reset" class="user-btn" value="Reset"/>
			</div>
		</form>		
	</div>
</div>
<script src="/js/Login.js"></script>
</body>
</html>