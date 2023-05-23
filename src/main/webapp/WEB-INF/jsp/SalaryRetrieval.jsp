<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="icon" type="image/x-icon" href="/images/scii-icon.jpg" />
<title><spring:message code="ems.label.salaryRetrieval.title"/></title>
<link rel="stylesheet" href="/css/SalaryRetrieval.css">
<link rel="stylesheet" href="/css/Cssboot.css">
<link rel="stylesheet" href="/css/common.css">
<link rel="stylesheet" href="/css/Tabulator.css">
<script src="/js/fontAwesome.js"></script>
<script src="/js/jquery.js"></script>
<script src="/js/Jquery1.16.0.js"></script>
<script src="/js/Tabulator.js"></script>
<script src="/js/html2Canvas.js"></script>
<script src="/js/NoConnection.js"></script>
<jsp:include page="common/header.jsp"></jsp:include>
<script src="/js/common.js"></script>
</head>
<body>
<div class="salarycontainer">
	<div class="salary-title">
		<p><spring:message code="ems.label.salaryRetrieval.header"/></p>
	</div>
	<div class="salarysearchdiv">
		<fieldset class="schedular-border">
			<legend class="schedular-border" id="legend-title"><spring:message code="ems.label.salaryRetrieval.searchCondition"/></legend>
			<div class="employeename-div">
				<label><spring:message code="ems.label.salaryRetrieval.employeeName"/></label>
				<select id="SearchEmployeeName"></select>
			</div>
			<div class="salarymonth-div">
				<label><spring:message code="ems.label.salaryRetrieval.month"/></label>
				<select id="SalaryMonthDiv"></select>
			</div>
			<div class="salaryyear-div">
				<label><spring:message code="ems.label.salaryRetrieval.year"/></label>
				<select id="SalaryYearDiv"></select>
			</div>
			<div class="searchbtn-div">
				 <input type="button" id="SearchButton" value=<spring:message code="ems.button.retrieve"/> onclick="retrieveSalary()" />
			</div>
		</fieldset>
	</div>
	<div class="mailbutton">
		<input type="button" onclick="takeScreenshot()" value=<spring:message code="ems.label.salaryRetrieval.sendMail"/>>
	</div>
	<div class="salarytablediv" id="salary-div">
		<div class="salaryheadingdiv">
			<p id="salaryheading"><spring:message code="ems.label.salaryRetrieval.salaryHeading"/></p>
			<p id="salarysubheading"><spring:message code="ems.label.salaryRetrieval.salarySubHeading"/></p>
		</div>
		<div class="tablediv">
			<table id="salarytable" class="table table-bordered border border-dark">
				<tr>
					<td colspan="6" id="sl_no"></td>
					<td class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.paySlip"/></td>
					<td colspan="2" id="salary-month-year"></td>
				</tr>
				<tr>
					<td class="firstcolwidth salary-table-elements"><spring:message code="ems.label.salaryRetrieval.name"/></td>
					<td colspan="2" id="employee-name"></td>
					<td class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.bank"/></td>
					<td colspan="2" id="bank-name"></td>
					<td class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.workingDays"/></td>
					<td colspan="2" id="working-days"></td>
				</tr>
				<tr>
					<td class="firstcolwidth salary-table-elements"><spring:message code="ems.label.salaryRetrieval.empNo"/></td>
					<td colspan="2" id="employee-no"></td>
					<td class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.bankAccount"/></td>
					<td colspan="2" id="bank-accountno"></td>
					<td class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.earnedLeave"/></td>
					<td id="bal-earnedleave"><spring:message code="ems.label.salaryRetrieval.balEarnedLeave"/></td>
					<td id="used-earnedleave"><spring:message code="ems.label.salaryRetrieval.usedEarnedLeave"/></td>
				</tr>
				<tr>
					<td class="firstcolwidth salary-table-elements"><spring:message code="ems.label.salaryRetrieval.department"/></td>
					<td colspan="2" id="department-name"></td>
					<td class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.pfAccount"/></td>
					<td colspan="2" id="pf-accountno"></td>
					<td class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.sickLeave"/></td>
					<td id="bal-sickleave"><spring:message code="ems.label.salaryRetrieval.balSickLeave"/></td>
					<td id="used-sickleave"><spring:message code="ems.label.salaryRetrieval.usedSickLeave"/></td>
				</tr>
				<tr>
					<td class="firstcolwidth salary-table-elements"><spring:message code="ems.label.salaryRetrieval.designation"/></td>
					<td colspan="2" id="designation-name"></td>
					<td class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.doj"/></td>
					<td colspan="5" id="doj"></td>
				</tr>
				<tr>
					<td colspan="3" class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.earnings"/></td>
					<td colspan="3" class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.deductions"/></td>
					<td colspan="3" class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.reimbursements"/></td>
				</tr>
				<tr class="secondcolwidth">
					<td align="right" class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.optionOne"/></td>
					<td class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.basic"/></td>
					<td align="right" id="basic-salary"><spring:message code="ems.label.salaryRetrieval.initialSalaryValue"/></td>
					<td align="right" class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.optionOne"/></td>
					<td class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.pf"/></td>
					<td align="right" id="salary-pf"><spring:message code="ems.label.salaryRetrieval.initialSalaryValue"/></td>
					<td align="right" class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.optionOne"/></td>
					<td class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.medical"/></td>
					<td align="right" id="salary-medical"><spring:message code="ems.label.salaryRetrieval.initialSalaryValue"/></td>
				</tr>
				<tr class="secondcolwidth">
					<td align="right" class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.optionTwo"/></td>
					<td class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.dpa"/></td>
					<td align="right" id="salary-dpa"><spring:message code="ems.label.salaryRetrieval.initialSalaryValue"/></td>
					<td align="right" class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.optionTwo"/></td>
					<td class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.professionalTax"/></td>
					<td align="right" id="salary-professionaltax"><spring:message code="ems.label.salaryRetrieval.initialSalaryValue"/></td>
					<td align="right" class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.optionTwo"/></td>
					<td class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.lta"/></td>
					<td align="right" id="salary-lta"><spring:message code="ems.label.salaryRetrieval.initialSalaryValue"/></td>
				</tr>
				<tr class="secondcolwidth">
					<td align="right" class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.optionThree"/></td>
					<td class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.hra"/></td>
					<td align="right" id="salary-hra"><spring:message code="ems.label.salaryRetrieval.initialSalaryValue"/></td>
					<td align="right" class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.optionThree"/></td>
					<td class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.incomeTax"/></td>
					<td align="right" id="salary-incometax"><spring:message code="ems.label.salaryRetrieval.initialSalaryValue"/></td>
					<td align="right" class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.optionThree"/></td>
					<td class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.el"/></td>
					<td align="right" id="salary-el"><spring:message code="ems.label.salaryRetrieval.initialSalaryValue"/></td>
				</tr>
				<tr class="secondcolwidth"> 
					<td align="right" class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.optionFour"/></td>
					<td class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.conveyance"/></td>
					<td align="right" id="salary-conveyance"><spring:message code="ems.label.salaryRetrieval.initialSalaryValue"/></td>
					<td align="right" class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.optionFour"/></td>
					<td></td>
					<td align="right"><spring:message code="ems.label.salaryRetrieval.initialSalaryValue"/></td>
					<td align="right" class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.optionFour"/></td>
					<td></td>
					<td align="right"><spring:message code="ems.label.salaryRetrieval.initialSalaryValue"/></td>
				</tr>
				<tr class="secondcolwidth">
					<td align="right" class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.optionFive"/></td>
					<td></td>
					<td align="right"><spring:message code="ems.label.salaryRetrieval.initialSalaryValue"/></td>
					<td align="right" class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.optionFive"/></td>
					<td></td>
					<td align="right"><spring:message code="ems.label.salaryRetrieval.initialSalaryValue"/></td>
					<td align="right" class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.optionFive"/></td>
					<td></td>
					<td align="right"><spring:message code="ems.label.salaryRetrieval.initialSalaryValue"/></td>
				</tr>
				<tr class="secondcolwidth">
					<td align="right" class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.optionSix"/></td>
					<td></td>
					<td align="right"><spring:message code="ems.label.salaryRetrieval.initialSalaryValue"/></td>
					<td align="right" class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.optionSix"/></td>
					<td></td>
					<td align="right"><spring:message code="ems.label.salaryRetrieval.initialSalaryValue"/></td>
					<td align="right" class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.optionSix"/></td>
					<td></td>
					<td align="right"><spring:message code="ems.label.salaryRetrieval.initialSalaryValue"/></td>
				</tr>
				<tr class="secondcolwidth">
					<td align="right" class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.optionSeven"/></td>
					<td class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.others"/></td>
					<td align="right"><spring:message code="ems.label.salaryRetrieval.initialSalaryValue"/></td>
					<td align="right" class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.optionSeven"/></td>
					<td class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.others"/></td>
					<td align="right"><spring:message code="ems.label.salaryRetrieval.initialSalaryValue"/></td>
					<td align="right" class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.optionSeven"/></td>
					<td class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.othersArrear"/></td>
					<td align="right"><spring:message code="ems.label.salaryRetrieval.initialSalaryValue"/></td>
				</tr>
				<tr>
					<td class="firstcolwidth"></td>
					<td class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.totalA"/></td>
					<td colspan="2" class="thirdcolwidth" id="salarytotal-a"><spring:message code="ems.label.salaryRetrieval.initialSalaryValue"/></td>
					<td class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.totalB"/></td>
					<td colspan="2" class="thirdcolwidth" id="salarytotal-b"><spring:message code="ems.label.salaryRetrieval.initialSalaryValue"/></td>
					<td class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.totalC"/></td>
					<td align="right" id="salarytotal-c"><spring:message code="ems.label.salaryRetrieval.initialSalaryValue"/></td>
				</tr>
				<tr>
					<td colspan="2" class="salary-table-elements"><spring:message code="ems.label.salaryRetrieval.totalPaid"/></td>
					<td colspan="6" class="thirdcolwidth" id="salarytotal-paid"><spring:message code="ems.label.salaryRetrieval.initialSalaryValue"/></td>
					<td></td>
				</tr>
			</table>
		</div>
		<div class="signaturediv">
			<p><spring:message code="ems.label.salaryRetrieval.signatureText"/></p>
		</div>
	</div>
</div>
<script src="/js/SalaryRetrieval.js"></script>
<script src="/js/EmployeeList.js"></script>
<script src="/js/Register.js"></script>
</body>
</html>