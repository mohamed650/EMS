<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="icon" type="image/x-icon" href="/images/scii-icon.jpg" />
<title><spring:message code="ems.label.login.loginTitle"/></title>
<link rel="stylesheet" href="/css/Login.css">
<link rel="stylesheet" href="/css/Cssboot.css">
<script src="/js/fontAwesome.js"></script>
<script src="/js/jquery.js"></script>
<script src="/js/Jquery1.16.0.js"></script>
<script src="/js/NoConnection.js"></script>
</head>
<body>
<div class="maincontainer">
	<div class="firstcontainer">
		<img alt="logo" src="/images/sciilogo.jpg" id="company-logo">
		<p id="project-title"><spring:message code="ems.label.projectTitle"/></p>
	</div>
	<div class="secondcontainer">
	</div>
	<div class="title-div">
		<p><spring:message code="ems.label.login.loginHeader"/></p>
		<form>
			<div class="title-div1">
				<label><spring:message code="ems.label.login.loginId"/></label>
				<input type="text" class="user-input" id="Login_Id"/><span><spring:message code="ems.label.asterisk"/></span>
			</div>
			<div class="title-div2">
				<label><spring:message code="ems.label.login.password"/></label>
				<input type="password" class="user-input" id="Password"/><span><spring:message code="ems.label.asterisk"/></span>
			</div>
			<div class="btn-div">
				<input type="button" class="user-btn" value=<spring:message code="ems.button.login"/> onclick="loginValidate()"/>
				<input type="reset" value=<spring:message code="ems.button.reset"/> class="user-btn" />
			</div>
		</form>		
	</div>
</div>
<script src="/js/Login.js"></script>
</body>
</html>