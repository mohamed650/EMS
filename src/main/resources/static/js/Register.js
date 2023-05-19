$(document).ready(function(){
	loadDepartment();
	loadDesignation();
	loadBatch();
});

function onlyNumbers(event){
	var asciiCode = (event.which) ? event.which : event.keyCode;
	if(asciiCode > 31 && (asciiCode < 48 || asciiCode > 57)){
		return false;
	}else{
		return true;
	}
}

function onlyAlphabets(event){
	var asciiCode = (event.which) ? event.which : event.keyCode;
	if((asciiCode > 64 && asciiCode < 91) || (asciiCode > 96 && asciiCode < 123) || asciiCode == 32){
		return true;
	}else{
		return false;
	}
}
function loadDepartment(){
	$.ajax({
		type: 'POST',
		url: '/loadDepartment',
		data: {},
		success: function(response){
			var map = JSON.parse(response);
			loadDepartmentInfo(map);
		}
	});
}

function loadDepartmentInfo(map){
	var s = '<option value="-1">Please Select Department</option>';
	for(var data in map){
		s += '<option value="' + data + '">' + map[data] + '</option>'; 
	}
	$("#DepartmentName").html(s);
	$("#SelectDepartment").html(s);
}

function loadDesignation(){
	$.ajax({
		type: 'POST',
		url: '/loadDesignation',
		data: {},
		success : function(response){
			var map = JSON.parse(response);
			loadDesignationInfo(map);
		}
	});
}

function loadDesignationInfo(map){
	var s = '<option value="-1">Please Select Designation</option>';
	for(var data in map){
		s += '<option value="' + data + '">' + map[data] + '</option>'; 
	}
	$("#Designation").html(s);
}

function loadBatch(){
	$.ajax({
		type: 'POST',
		url: '/loadBatch',
		data: {},
		success: function(response){
			var map = JSON.parse(response);
			loadBatchYears(map);
		}
	});
}

function loadBatchYears(map){
	var s = '<option value="-1">Please Select Year</option>';
	for(var i=0; i<map.length; i++){
		s += '<option value="' + i + '">' + map[i] + '</option>'; 	
	}
	$("#Batch").html(s);
	$("#SelectBatch").html(s);
	$("#Salary_Year").html(s);
	$("#SalaryYearDiv").html(s);
}

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

function registerEmployee(){
	var pfAccountNumber = $("#PFAccountNo").val();
	var IndianPhoneNo = $("#IndianPhoneNo").val();
	const notAllowedSpecials = /[`!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?~]/;
	const regex_pattern = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
	const phoneValid = /^[6-9]\d{9}$/;
	var radioOptions = document.getElementsByName("gender");
	var PFAccountLength = $("PFAccountNumber").val();
	var selectBatch = $("#Batch").val();
	var params ={
		Employee_Id : $("#Employee_Id").val(),
		FirstName : $("#FirstName").val(),
		LastName : $("#LastName").val(),
		Gender : $('input[name="gender"]:checked').val(),
		DateofBirth: $("#DateofBirth").val(),
		Address : $("#Address").val(),
		Email_Id : $("#Email_Id").val(),
		ContactNumber : IndianPhoneNo.concat($("#ContactNumber").val()),
		Batch : $("#Batch :selected").text(),
		DateofJoining : $("#DateofJoining").val(),
		Department_Id: $("#DepartmentName").val(),
		Department_Name : $("#DepartmentName :selected").text(),
		Designation_Id : $("#Designation").val(),
		Designation_Name : $("#Designation :selected").text(),
		Bank_Name : $("#bankoption :selected").text(),
		AccountNumber : $("#AccountNumber").val(),
		PfAccountNumber : pfAccountNumber.concat($("#PFAccountNumber").val()),
		PAN: $("#PAN").val()
	};
	var employeeAge = getAge(params.DateofBirth);
	var dateJoiningDiff = getJoiningDateDiff(params.DateofBirth, params.DateofJoining);
	var dobBatchDiff = getBatchDobDiff(params.Batch, params.DateofBirth);
	var dojBatchDiff = getBatchDojDiff(params.Batch, params.DateofJoining);
	if(params.Employee_Id == "" && params.FirstName == "" && params.LastName =="" && params.DateofBirth =="" &&
		params.Address =="" && params.Email_Id == "" && params.ContactNumber =="" && params.Batch == -1 &&
		params.DateofJoining == "" && params.Department_Name == -1 && params.Designation_Name == -1 &&
		params.AccountNumber =="" && params.PfAccountNumber =="" && params.PAN ==""){
			alert("Fields cannot be Empty..");
			return false;
		}else if(params.Employee_Id == "" || params.Employee_Id == null){
			alert("Employee_Id cannot be null..");
			return false;
		}else if(params.FirstName == "" || params.FirstName == null){
			alert("First Name cannot be null..");
			return false;
		}else if(params.FirstName.match(notAllowedSpecials)){
			alert("First Name cannot contain Special Characters..");
			return false;
		}else if(params.LastName == "" || params.LastName == null){
			alert("Last Name cannot be null..");
			return false;
		}else if(params.LastName.match(notAllowedSpecials)){
			alert("Last Name cannot contain Special Characters..");
			return false;
		}else if(!(radioOptions[0].checked || radioOptions[1].checked)){
			alert("Please Select Your Gender..");
			return false;
		}else if(params.DateofBirth == "" || params.DateofBirth == null){
			alert("Date of Birth cannot be null..");
			return false;
		}else if(employeeAge < 18){
			alert("Age should be above 18 years only...");
			return false;
		}else if(params.Address == "" || params.Address == null){
			alert("Address cannot be null..");
			return false;
		}else if(params.Email_Id =="" || params.Email_Id == null){
			alert("EMail Id cannot be null..");
			return false;
		}else if(!(params.Email_Id.match(regex_pattern))){
			alert("Invalid Email Id..");
			return false;
		}else if(params.ContactNumber == "" || params.ContactNumber == null){
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
		}else if(params.DateofJoining == "" || params.DateofJoining == null){
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
		}else if(params.AccountNumber == "" || params.AccountNumber == null){
			alert("Account Number cannit be null..");
			return false;
		}else if(params.PfAccountNumber.substring(13, PFAccountLength) == "" || params.PfAccountNumber.substring(13, PFAccountLength) == null){
			alert("PF Account Number cannot be null..");
			return false;
		}else if(params.PAN == "" || params.PAN == null){
			alert("PAN cannot be null..");
			return false;
		}else {
			$.ajax({
				type: 'POST',
				url: '/insertUser',
				data: params,
				dataType: 'json',
				success: function(response){
					if(response.MESSAGE == "SUCCESS"){
						alert("Employee Registered Successfully..");
						window.location.href="/employeeList";
					}else if(response.MESSAGE == "USEREXIST"){
						alert("EMployee Already Exist..");
						return false;
					}else{
						alert("Unable to Register Employee..");
						return false;
					}
				}
			});
		}
}