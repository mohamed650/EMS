<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/css/NoConnection.css">
<script src="/js/NoConnection.js"></script>
<link rel="icon" type="image/x-icon" href="/images/scii-icon.jpg" />
<title><spring:message code="ems.label.noConnection.title"/></title>
</head>
<body>
<div class="maincontainer">
    <div class="imagecontainer">
        <img src="/images/no-internet.png" alt="">
        <div class="img-text">
            <p class="title"><spring:message code="ems.label.noConnection.heading"/></p>
            <p class="text"><spring:message code="ems.label.noConnection.text"/></p>
        </div>
    </div>
</div>
</body>
</html>