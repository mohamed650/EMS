<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
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
		<p>Salary Retrieval</p>
	</div>
	<div class="salarysearchdiv">
		<fieldset class="schedular-border">
			<legend class="schedular-border" id="legend-title">Search Conditions</legend>
			<div class="employeename-div">
				<label>Employee Name:</label>
				<select id="SearchEmployeeName"></select>
			</div>
			<div class="salarymonth-div">
				<label>Select Month:</label>
				<select id="SalaryMonthDiv"></select>
			</div>
			<div class="salaryyear-div">
				<label>Select Year:</label>
				<select id="SalaryYearDiv"></select>
			</div>
			<div class="searchbtn-div">
				 <input type="button" id="SearchButton" onclick="retrieveSalary()" value="Retrieve"/>
			</div>
		</fieldset>
	</div>
	<div class="mailbutton">
		<input type="button" onclick="takeScreenshot()" value="Send Mail">
	</div>
	<div class="salarytablediv" id="salary-div">
		<div class="salaryheadingdiv">
			<p id="salaryheading">SCII System Consultant Information India Pvt.Ltd</p>
			<p id="salarysubheading">Plot No: Spl-17, Anthrasanahalli, KSSIDC Industrial Complex 2nd Stage Madhugiri Road, Arakere P.O. Tumkur - 572106</p>
		</div>
		<div class="tablediv">
			<table id="salarytable" class="table table-bordered border border-dark">
				<tr>
					<td colspan="6" id="sl_no"></td>
					<td class="salary-table-elements">Pay Slip</td>
					<td colspan="2" id="salary-month-year"></td>
				</tr>
				<tr>
					<td class="firstcolwidth salary-table-elements">Name</td>
					<td colspan="2" id="employee-name"></td>
					<td class="salary-table-elements">Bank</td>
					<td colspan="2" id="bank-name"></td>
					<td class="salary-table-elements">Working Days</td>
					<td colspan="2" id="working-days"></td>
				</tr>
				<tr>
					<td class="firstcolwidth salary-table-elements">Emp.No</td>
					<td colspan="2" id="employee-no"></td>
					<td class="salary-table-elements">Bank A/c.#</td>
					<td colspan="2" id="bank-accountno"></td>
					<td class="salary-table-elements">Earned Leave</td>
					<td id="bal-earnedleave">0.0</td>
					<td id="used-earnedleave">0.0</td>
				</tr>
				<tr>
					<td class="firstcolwidth salary-table-elements">Department</td>
					<td colspan="2" id="department-name"></td>
					<td class="salary-table-elements">PF A/c.#</td>
					<td colspan="2" id="pf-accountno"></td>
					<td class="salary-table-elements">Sick Leave</td>
					<td id="bal-sickleave">0.0</td>
					<td id="used-sickleave">0.0</td>
				</tr>
				<tr>
					<td class="firstcolwidth salary-table-elements">Designation</td>
					<td colspan="2" id="designation-name"></td>
					<td class="salary-table-elements">DOJ</td>
					<td colspan="5" id="doj"></td>
				</tr>
				<tr>
					<td colspan="3" class="salary-table-elements">Earnings</td>
					<td colspan="3" class="salary-table-elements">Deductions</td>
					<td colspan="3" class="salary-table-elements">Reimbursements</td>
				</tr>
				<tr class="secondcolwidth">
					<td align="right" class="salary-table-elements">1</td>
					<td class="salary-table-elements">Basic</td>
					<td align="right" id="basic-salary">0.00</td>
					<td align="right" class="salary-table-elements">1</td>
					<td class="salary-table-elements">PF</td>
					<td align="right" id="salary-pf">0.00</td>
					<td align="right" class="salary-table-elements">1</td>
					<td class="salary-table-elements">Medical</td>
					<td align="right" id="salary-medical">0.00</td>
				</tr>
				<tr class="secondcolwidth">
					<td align="right" class="salary-table-elements">2</td>
					<td class="salary-table-elements">DPA</td>
					<td align="right" id="salary-dpa">0.00</td>
					<td align="right" class="salary-table-elements">2</td>
					<td class="salary-table-elements">Professional Tax</td>
					<td align="right" id="salary-professionaltax">0.00</td>
					<td align="right" class="salary-table-elements">2</td>
					<td class="salary-table-elements">LTA</td>
					<td align="right" id="salary-lta">0.00</td>
				</tr>
				<tr class="secondcolwidth">
					<td align="right" class="salary-table-elements">3</td>
					<td class="salary-table-elements">HRA</td>
					<td align="right" id="salary-hra">0.00</td>
					<td align="right" class="salary-table-elements">3</td>
					<td class="salary-table-elements">Income Tax</td>
					<td align="right" id="salary-incometax">0.00</td>
					<td align="right" class="salary-table-elements">3</td>
					<td class="salary-table-elements">EL</td>
					<td align="right" id="salary-el">0.00</td>
				</tr>
				<tr class="secondcolwidth"> 
					<td align="right" class="salary-table-elements">4</td>
					<td class="salary-table-elements">Conveyance</td>
					<td align="right" id="salary-conveyance">0.00</td>
					<td align="right" class="salary-table-elements">4</td>
					<td></td>
					<td align="right">0.00</td>
					<td align="right" class="salary-table-elements">4</td>
					<td class="salary-table-elements">SL</td>
					<td align="right">0.00</td>
				</tr>
				<tr class="secondcolwidth">
					<td align="right" class="salary-table-elements">5</td>
					<td></td>
					<td align="right">0.00</td>
					<td align="right" class="salary-table-elements">5</td>
					<td></td>
					<td align="right">0.00</td>
					<td align="right" class="salary-table-elements">5</td>
					<td></td>
					<td align="right">0.00</td>
				</tr>
				<tr class="secondcolwidth">
					<td align="right" class="salary-table-elements">6</td>
					<td></td>
					<td align="right">0.00</td>
					<td align="right" class="salary-table-elements">6</td>
					<td></td>
					<td align="right">0.00</td>
					<td align="right" class="salary-table-elements">6</td>
					<td></td>
					<td align="right">0.00</td>
				</tr>
				<tr class="secondcolwidth">
					<td align="right" class="salary-table-elements">7</td>
					<td class="salary-table-elements">Others</td>
					<td align="right">0.00</td>
					<td align="right" class="salary-table-elements">7</td>
					<td class="salary-table-elements">Others</td>
					<td align="right">0.00</td>
					<td align="right" class="salary-table-elements">7</td>
					<td class="salary-table-elements">Others-Arrear</td>
					<td align="right">0.00</td>
				</tr>
				<tr>
					<td class="firstcolwidth"></td>
					<td class="salary-table-elements">Total[A]</td>
					<td colspan="2" class="thirdcolwidth" id="salarytotal-a">0.00</td>
					<td class="salary-table-elements">Total[B]</td>
					<td colspan="2" class="thirdcolwidth" id="salarytotal-b">0.00</td>
					<td class="salary-table-elements">Total[C]</td>
					<td align="right" id="salarytotal-c">0.00</td>
				</tr>
				<tr>
					<td colspan="2" class="salary-table-elements">Total Paid[A-B+C]</td>
					<td colspan="6" class="thirdcolwidth" id="salarytotal-paid">0.00</td>
					<td></td>
				</tr>
			</table>
		</div>
		<div class="signaturediv">
			<p>Electronically generated pay slip does not require any physical signature and official seal</p>
		</div>
	</div>
</div>
<script src="/js/SalaryRetrieval.js"></script>
<script src="/js/EmployeeList.js"></script>
<script src="/js/Register.js"></script>
</body>
</html>