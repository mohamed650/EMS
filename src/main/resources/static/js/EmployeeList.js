$(document).ready(function(){
	loadEmployeeTable();
	loadMonths();
	
	$("#CheckDate").on('click', function(){
		var salaryMonth = $("#Salary_Month").val();
		var salaryYear = $("#Salary_Year").val();
		var params = {
			Salary_Employee_Id: $("#Salary_Employee_Id").val(),
			Salary_Month: $("#Salary_Month :selected").text(),
			Salary_Year: $("#Salary_Year :selected").text()
		};
		if(salaryMonth == -1 && salaryYear == -1){
			alert("Please Select Both Fields...");
			return false;
		}else if(salaryMonth == -1 && salaryYear != -1){
			alert("Please Select Month...");
			return false;
		}else if(salaryMonth != -1 && salaryYear == -1){
			alert("Please Select Year...");
			return false;
		}else{
			$.ajax({
				type: 'POST',
				url: '/checkMonthYear',
				data: params,
				dataType: 'json',
				success: function(response){
					if(response.MESSAGE == "SALARYNOTEXIST"){
						alert("Salary Does Not Exist for Particular Month and Year!..");
						$("#Basic_Salary").val("");
						$("#Worked_Days").val("");
						$("#Sick_Leave").val("");
						$("#Earned_Leave").val("");
						$("#Used_Sick_Leave").val("");
						$("#Used_Earned_Leave").val("");
						document.getElementById("insertSalaryBtn").style.display = "block";
						return false;
					}else {
						for(data in response){
							var i = 0;
							$("#Basic_Salary").val(response[data][i]);
							$("#Worked_Days").val(response[data][++i]);
							$("#Sick_Leave").val(response[data][++i]);
							$("#Earned_Leave").val(response[data][++i]);
							$("#Used_Sick_Leave").val(response[data][++i]);
							$("#Used_Earned_Leave").val(response[data][++i]);
						}
						document.getElementById("insertSalaryBtn").style.display = "none";
					}
				}
			});
		}
		
	
	});
});

function searchTabulator(){
	selDept = $("#SelectDepartment :selected").val();
	selBatch = $("#SelectBatch :selected").val();
	var params = {
		EmployeeName: $("#SearchEmployeeName").val(),
		Department_Name: $("#SelectDepartment :selected").text(),
		Batch: $("#SelectBatch :selected").text()
	};
	if((params.EmployeeName == "" || params.EmployeeName == null) && (selDept == -1) && (selBatch == -1)){
		alert("Please Enter atleast one Search Field...");
		return false;
	}else{
		$.ajax({
			type: 'POST',
			url: '/searchEmployeeDetails',
			data: params,
			dataType: 'json',
			success: function(response){
				alert(response)
				console.log(response);
			}
		});
	}
}

function loadBatchList(){
	$.ajax({
		type: 'POST',
		url: '/loadBatch',
		data: {},
		success: function(response){
			var map = JSON.parse(response);
			loadBatchYearsList(map);
		}
	});
}

function loadBatchYearsList(map){
	var batchList = sessionStorage.getItem("BatchList");
	console.log(batchList);
	var s = '<option value="-1">Please Select Batch</option>';
	for(var i=0; i<map.length; i++){
		if(map[i] == batchList){
			s += '<option value="' + i + '" selected>' + map[i] + '</option>';
		}else {
			s += '<option value="' + i + '">' + map[i] + '</option>'; 	
		}
	}
	$("#BatchUpdate").html(s);
}

function loadDepartmentList(){
	$.ajax({
		type: 'POST',
		url: '/loadDepartment',
		data: {},
		success: function(response){
			var map = JSON.parse(response);
			loadDepartmentInfoList(map);
		}
	});
}

function loadDepartmentInfoList(map){
	var departmentList = sessionStorage.getItem("DepartmentList");
	var s = '<option value="-1">Please Select Department</option>';
	for(var data in map){
		if(map[data] == departmentList){
			s += '<option value="' + data + '" selected>' + map[data] + '</option>';
		}else {
			s += '<option value="' + data + '">' + map[data] + '</option>'; 	
		}
	}
	$("#DepartmentNameList").html(s);
}

function loadDesignationList(){
	$.ajax({
		type: 'POST',
		url: '/loadDesignation',
		data: {},
		success : function(response){
			var map = JSON.parse(response);
			loadDesignationInfoList(map);
		}
	});
}

function loadDesignationInfoList(map){
	var designationList = sessionStorage.getItem("DesignationList");
	var s = '<option value="-1">Please Select Designation</option>';
	for(var data in map){
		if(map[data] == designationList){
			s += '<option value="' + data + '" selected>' + map[data] + '</option>'; 
		}else {
			s += '<option value="' + data + '">' + map[data] + '</option>'; 
		}	
	}
	$("#DesignationList").html(s);
}

function loadMonths(){
	$.ajax({
		type: 'POST',
		url: '/loadMonths',
		data: {},
		success : function(response){
			var map = JSON.parse(response);
			loadMonthsInfoList(map);
		}
	});
};

function loadMonthsInfoList(map){
	var s = '<option value="-1">Select Month</option>';
	for(var i=0; i<map.length-1; i++){
		s += '<option value="' + i + '">' + map[i] + '</option>'; 	
	}
	$("#Salary_Month").html(s);
	$("#SalaryMonthDiv").html(s);
};

function getAge(dateOfBirth){
	var today = new Date();
	var dob = new Date(dateOfBirth);
	var age = today.getFullYear() - dob.getFullYear();
	var month = today.getMonth() - dob.getMonth();
	if(month < 0 || (month === 0 && today.getDate() < dob.getDate())){
		age--;
	}
	return age;
}

function getJoiningDateDiff(dateOfBirth, dateOfJoining){
	var dob = new Date(dateOfBirth);
	var doj = new Date(dateOfJoining);
	var age = doj.getFullYear() - dob.getFullYear();
	var month = doj.getMonth() - dob.getMonth();
	if(month < 0 || (month === 0 && doj.getDate() < dob.getDate())){
		age--;
	}
	return age;
}

function getBatchDobDiff(batch, dateOfBirth){
	var dob = new Date(dateOfBirth);
	var age = batch - dob.getFullYear();
	return age;
}

function getBatchDojDiff(batch, dateOfJoining){
	var doj = new Date(dateOfJoining);
	if(batch == doj.getFullYear()){
		return true;
	}else{
		return false;
	}
}

let upbtn = function(value, data, cell, row, options){
	return '<button class="btn btn-primary">Update</button>';
};

let upbtncallback = function(e, cell, value, data){
	var select = cell.getRow().getData();
	alert(select.employee_Id);
	document.getElementById("Employee_Id").value = select.employee_Id.trim();
	$("#Employee_Id").prop("disabled", true);
	document.getElementById("FirstName").value = select.firstName.trim();
	document.getElementById("LastName").value = select.lastName.trim();
	$("input[name='gender'][value="+select.gender+"]").prop('checked', true);
	$("#DateofBirth").val(select.dateofBirth);
	document.getElementById("Address").value = select.address.trim();
	document.getElementById("Email_Id").value = select.email_Id.trim();
	document.getElementById("ContactNumber").value = select.contactNumber.substring(3, 13);
	sessionStorage.setItem("BatchList", select.batch);
	loadBatchList();
	$("#DateofJoining").val(select.dateofJoining);
	var today = new Date();
	today = today.getFullYear()+"-"+('0' + (today.getMonth() + 1)).slice(-2)+"-"+('0' + today.getDate()).slice(-2);
	$("#DateofLeaving").prop("min", today);
	sessionStorage.setItem("DepartmentList", select.department_Name);
	loadDepartmentList();
	sessionStorage.setItem("DesignationList", select.designation_Name);
	loadDesignationList();
	$("#bankOption :selected").text(select.bank_Name.trim());
	document.getElementById("AccountNumber").value = select.accountNumber.trim();
	document.getElementById("PFAccountNumber").value = select.pfAccountNumber.substring(13);
	document.getElementById("PAN").value = select.pan.trim();
	$("#EmployeeUpdate").modal("show");
};

function updateEmployeeDetails(){
	var checkboxFlag;
	var pfAccountNumber = $("#PFAccountNo").val();
	var IndianPhoneNo = $("#IndianPhoneNo").val();
	const notAllowedSpecials = /[`!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?~]/;
	const regex_pattern = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
	const phoneValid = /^[6-9]\d{9}$/;
	var radioOptions = document.getElementsByName("gender");
	var PFAccountLength = $("PFAccountNumber").val();
	var selectBatch = $("#Batch").val();
	var discontinuedCheckbox = document.getElementById("Discontinued");
	if(discontinuedCheckbox.checked){
		if(params.DateofLeaving == "" || params.DateofLeaving == null){
			alert("Please Select of Date of Relieving!...");
			return false;
		}else{
			checkboxFlag = 1;
		}
	}else{
		checkboxFlag = 0;
	}
	var params = {
		Employee_Id : $("#Employee_Id").val(),
		FirstName : $("#FirstName").val(),
		LastName : $("#LastName").val(),
		Gender : $('input[name="gender"]:checked').val(),
		DateofBirth: $("#DateofBirth").val(),
		Address : $("#Address").val(),
		Email_Id : $("#Email_Id").val(),
		ContactNumber : IndianPhoneNo.concat($("#ContactNumber").val()),
		Batch : $("#BatchUpdate :selected").text(),
		DateofJoining : $("#DateofJoining").val(),
		DateofLeaving : $("#DateofLeaving").val(),
		Department_Id: $("#DepartmentNameList").val(),
		Department_Name : $("#DepartmentNameList :selected").text(),
		Designation_Id : $("#DesignationList").val(),
		Designation_Name : $("#DesignationList :selected").text(),
		Bank_Name : $("#bankOption :selected").text(),
		AccountNumber : $("#AccountNumber").val(),
		PfAccountNumber : pfAccountNumber.concat($("#PFAccountNumber").val()),
		PAN: $("#PAN").val(),
		Discontinued : checkboxFlag
	};
	
	var employeeAge = getAge(params.DateofBirth);
	var dateJoiningDiff = getJoiningDateDiff(params.DateofBirth, params.DateofJoining);
	var dobBatchDiff = getBatchDobDiff(params.Batch, params.DateofBirth);
	var dojBatchDiff = getBatchDojDiff(params.Batch, params.DateofJoining);
	
	if(params.FirstName == ""){
		alert("First Name cannot be null..");
		return false;
	}else if(params.FirstName.match(notAllowedSpecials)){
		alert("First Name cannot contain Special Characters..");
		return false;
	}else if(params.LastName == ""){
		alert("Last Name cannot be null..");
		return false;
	}else if(params.LastName.match(notAllowedSpecials)){
		alert("Last Name cannot contain Special Characters..");
		return false;
	}else if(!(radioOptions[0].checked || radioOptions[1].checked)){
		alert("Please Select Your Gender..");
		return false;
	}else if(params.DateofBirth ==""){
		alert("Date of Birth cannot be null..");
		return false;
	}else if(employeeAge < 18){
		alert("Age should be above 18 years only...");
		return false;
	}else if(params.Address == ""){
		alert("Address cannot be null..");
		return false;
	}else if(params.Email_Id ==""){
		alert("EMail Id cannot be null..");
		return false;
	}else if(!(params.Email_Id.match(regex_pattern))){
		alert("Invalid Email Id..");
		return false;
	}else if(params.ContactNumber == ""){
		alert("Contact Number cannot be null..");
		return false;
	}else if(!(params.ContactNumber.substring(3,13).match(phoneValid))){
		alert("Invalid Phone Number..");
		return false;
	}else if(selectBatch == -1){
		alert("Please Select Your Batch...");
		return false;
	}else if(dobBatchDiff < 18){
		alert("Difference Between Date of Birth and Batch should be above 18 years...");
		return false;
	}else if(params.DateofJoining == ""){
		alert("Date of Joining cannot be null..");
		return false;
	}else if(dateJoiningDiff < 18){
		alert("Age Difference should be greater than 18 years...");
		return false;
	}else if(dojBatchDiff == false){
		alert("Date of Joining year and Batch should be same...");
		return false;
	}else if(params.Department_Id == -1){
		alert("Please Select Your Department...");
		return false;
	}else if(params.Designation_Id == -1){
		alert("Please Select Your Designation...");
		return false;
	}else if(params.AccountNumber == ""){
		alert("Account Number cannit be null..");
		return false;
	}else if(params.PfAccountNumber.substring(13, PFAccountLength) ==""){
		alert("PF Account Number cannot be null..");
		return false;
	}else if(params.PAN == ""){
		alert("PAN cannot be null..");
		return false;
	}else{
		$.ajax({
			type: 'POST',
			url: '/updateUser',
			data: params,
			dataType: 'json',
			success: function(response){
				if(response.MESSAGE == "SUCCESS"){
					alert("Employee Updated Successfully..");
					window.location.href="/employeeList";
				}else{
					alert("Unable to Update Employee..");
					return false;
				}
			}
		});
	}
}

let salbtn = function(value, data, cell, row, options){
	return '<button class="btn btn-primary">Salary</button>';
};

let salbtncallback = function(e, cell, value, data){
	var select = cell.getRow().getData();
	document.getElementById("Salary_Employee_Id").value = select.employee_Id;
	$("#Salary_Employee_Id").prop("disabled", true);
	var dateofJoinAfterEight = new Date(select.dateofJoining);
	dateofJoinAfterEight.setMonth((dateofJoinAfterEight.getMonth()+1) + 7);
	var afterdojEight = dateofJoinAfterEight.getFullYear()+"-"+(dateofJoinAfterEight.getMonth()+1)+"-"+dateofJoinAfterEight.getDate();
	var dateAfterEightMonths = new Date(afterdojEight);
	var currentdate = new Date();
	if(currentdate.getTime() < dateAfterEightMonths.getTime()){
		document.getElementById("Sick_Leave").disabled = true;
		document.getElementById("Used_Sick_Leave").disabled = true;
	}else{
		document.getElementById("Sick_Leave").disabled = false;
		document.getElementById("Used_Sick_Leave").disabled = false;
	}
	
	var dateofJoinAfterTwenty = new Date(select.dateofJoining);
	dateofJoinAfterTwenty.setMonth((dateofJoinAfterTwenty.getMonth()+1)+19);
	var afterdojTwenty = dateofJoinAfterTwenty.getFullYear()+"-"+(dateofJoinAfterTwenty.getMonth()+1)+"-"+dateofJoinAfterTwenty.getDate();
	var dateAfterTwentyMonths = new Date(afterdojTwenty);
	if(currentdate.getTime() < dateAfterTwentyMonths.getTime()){
		document.getElementById("Earned_Leave").disabled = true;
		document.getElementById("Used_Earned_Leave").disabled = true;
	}else{
		document.getElementById("Earned_Leave").disabled = false;
		document.getElementById("Used_Earned_Leave").disabled = false;
	}
	$("#SalaryModal").modal("show");
}

function insertSalaryDetails(){
	var salaryMonth = $("#Salary_Month").val();
	var salaryYear = $("#Salary_Year").val();
	var params = {
		Salary_Employee_Id : $("#Salary_Employee_Id").val(),
		Salary_Month : $("#Salary_Month :selected").text(),
		Salary_Year : $("#Salary_Year :selected").text(),
		Basic_Salary : $("#Basic_Salary").val(),
		Worked_Days : $("#Worked_Days").val(),
		Sick_Leave : $("#Sick_Leave").val(),
		Used_Sick_Leave : $("#Used_Sick_Leave").val(),
		Earned_Leave : $("#Earned_Leave").val(),
		Used_Earned_Leave : $("#Used_Earned_Leave").val()
	};
	if(salaryMonth == -1 && salaryYear == -1){
		alert("Please Select Both Fields...");
		return false;
	}else if(salaryMonth == -1 && salaryYear != -1){
		alert("Please Select Month...");
		return false;
	}else if(salaryMonth != -1 && salaryYear == -1){
		alert("Please Select Year...");
		return false;
	}else if(params.Basic_Salary == null || params.Basic_Salary == ""){
		alert("Please Add Basic Salary...");
		return false;
	}else if(params.Worked_Days == null || params.Worked_Days == ""){
		alert("Please Add Worked Days...");
		return false;
	}else{
		$.ajax({
			type: 'POST',
			url: '/insertSalary',
			data: params,
			dataType: 'json',
			success: function(response){
				if(response.MESSAGE == "SUCCESS"){
					alert("Salary Added Successfully..");
					window.location.href="/employeeList";
				}else{
					alert("Unable to Add Salary..");
					return false;
				}
			}
		})
	}
}

var table;
function loadEmployeeTable(){
	table = new Tabulator("#employeeTabulator", {
		layout:"fitColumns",
		height: "360px",
		rowFormatter:function(row){
			if(row.getData().discontinued == 1){
				row.getElement().style.backgroundColor = "#ffbe33";
				row.getElement().style.pointerEvents = "none"; 
			}
		},
		pagination: "local",
    	paginationSize: 10,
    	paginationSizeSelector: [3, 6, 8, 10],
    	movableColumns: true,
    	paginationCounter:"rows",
		ajaxURL    :  "/loadEmployeeDetails",
		ajaxConfig : "get",
		ajaxFiltering: true,
		width: 50,
		headerSort: false,
      	cssClass: 'text-center',
      	frozen: true,
	    columns    : [
    	{title:"Employee Id", field:"employee_Id"},
		{title:"Employee Name", field:"employeeName", headerFilter: true},
		{title:"Email Id", field:"email_Id"},
		{title:"Contact Number", field:"contactNumber"},
		{title:"Batch", field:"batch", hozAlign:"center", headerFilter: true},
		{title:"Date of Joining", field:"dateofJoining", hozAlign:"center"},
		{title:"Department Name", field:"department_Name", headerFilter: true},
		{title:"Designation Name", field:"designation_Name"},
		{title:"Address", field:"address", visible: false},
		{title:"Bank Name", field:"bank_Name", visible: false},
		{title:"Account Number", field:"accountNumber", visible: false},
		{title:"PF Account Number", field:"pfAccountNumber", visible: false},
		{title:"First Name", field:"firstName", visible: false},
		{title:"Last Name", field:"lastName", visible: false},
		{title:"PAN", field:"pan", visible: false},
		{title:"Gender", field:"gender", visible: false},
		{title:"Discontinued", field:"discontinued", visible: false},
		{title:"", formatter:upbtn, cellClick: upbtncallback, width: 100},
		{title:"", formatter:salbtn, cellClick: salbtncallback, width: 100},
		],
	});
}

function closeSalaryModal(){
	$("#Salary_Month").val(-1);
	$("#Salary_Year").val(-1);
	$("#Basic_Salary").val("");
	$("#Worked_Days").val("");
	$("#Sick_Leave").val("");
	$("#Earned_Leave").val("");
	$("#Used_Sick_Leave").val("");
	$("#Used_Earned_Leave").val("");
	document.getElementById("insertSalaryBtn").style.display = "block";
}

