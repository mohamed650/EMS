$(document).ready(function(){
	loadEmployeeNames();
});

function loadEmployeeNames(){
	$.ajax({
		type: 'POST',
		url: '/loadEmployeeNames',
		data: {},
		success: function(response){
			var map = JSON.parse(response);
			loadEmployeeNameInfo(map);
		}
	});
}

function loadEmployeeNameInfo(map){
	var s = '<option value="-1">Select Employee Name</option>';
	for(data in map){
		s += '<option value='+ data +'>'+ map[data] +'</option>';
	}
	$("#SearchEmployeeName").html(s);
}

function retrieveSalary(){
	var params = {
		Employee_Id : $("#SearchEmployeeName").val(),
		Salary_Month : $("#SalaryMonthDiv :selected").text(),
		Salary_Year : $("#SalaryYearDiv :selected").text()
	};
	Emp_Sal_Month = $("#SalaryMonthDiv").val();
	Emp_Sal_Year = $("#SalaryYearDiv").val();
	if(params.Employee_Id == -1){
		alert("Please Select Employee Name!!");
		return false;
	}else if(Emp_Sal_Month == -1){
		alert("Please Select Month!!");
		return false;
	}else if(Emp_Sal_Year == -1){
		alert("Please Select Year!!");
		return false;
	}else{
		$.ajax({
			type: 'POST',
			url: '/retrieveSalary',
			data: params,
			dataType: 'json',
			success: function(response){
				if(response.MESSAGE == "SALARYDOESNOTEXIST"){
					alert("Salary Does Not Exist for Particular Month and Year!...");
					$("#sl_no").html("");
					$("#salary-month-year").html("");
						$("#employee-name").html("");
						$("#bank-name").html("");
						$("#working-days").html("");
						$("#employee-no").html("");
						$("#bank-accountno").html("");
						$("#department-name").html("");
						$("#pf-accountno").html("");
						$("#designation-name").html("");
						$("#doj").html("");
						$("#basic-salary").html("0.00");
						$("#salary-pf").html("0.00");
						$("#salary-dpa").html("0.00");
						$("#salary-professionaltax").html("0.00");
						$("#salary-hra").html("0.00");
						$("#salary-conveyance").html("0.00");
						$("#salarytotal-a").html("0.00");
						$("#salarytotal-b").html("0.00");
						$("#salarytotal-paid").html("0.00");
						$("#bal-sickleave").html("0.0");
						$("#used-sickleave").html("0.0");
						$("#bal-earnedleave").html("0.0");
						$("#used-earnedleave").html("0.0");
					return false;
				}else{
					for(data in response){
						var i = 0;
						$("#sl_no").html(response[data][i]);
						$("#salary-month-year").html(response[data][++i]);
						$("#employee-name").html(response[data][++i]);
						$("#bank-name").html(response[data][++i]);
						$("#working-days").html(response[data][++i]);
						$("#employee-no").html(response[data][++i]);
						$("#bank-accountno").html(response[data][++i]);
						$("#department-name").html(response[data][++i]);
						$("#pf-accountno").html(response[data][++i]);
						$("#designation-name").html(response[data][++i]);
						$("#doj").html(response[data][++i]);
						$("#basic-salary").html(response[data][++i]);
						$("#salary-pf").html(response[data][++i]);
						$("#salary-dpa").html(response[data][++i]);
						$("#salary-professionaltax").html(response[data][++i]);
						$("#salary-hra").html(response[data][++i]);
						$("#salary-conveyance").html(response[data][++i]);
						$("#salarytotal-a").html(response[data][++i]);
						$("#salarytotal-b").html(response[data][++i]);
						$("#salarytotal-paid").html(response[data][++i]);
						var balSickLeave = response[data][++i];
						var usedSickLeave = response[data][++i];
						var balEarnedLeave = response[data][++i];
						var usedEarnedLeave = response[data][++i];
						console.log(balEarnedLeave);
						if(balSickLeave != "" && balSickLeave != null){
							$("#bal-sickleave").html(balSickLeave);
						}else{
							$("#bal-sickleave").html("0.0");
						}
						if(usedSickLeave != "" && usedSickLeave != null){
							$("#used-sickleave").html(usedSickLeave);
						}else{
							$("#used-sickleave").html("0.0");
						}
						if(balEarnedLeave != "" && balEarnedLeave != null){
							$("#bal-earnedleave").html(balEarnedLeave);
						}else{
							$("#bal-earnedleave").html("0.0");
						}
						if(usedEarnedLeave != "" && usedEarnedLeave != null){
							$("#used-earnedleave").html(usedEarnedLeave);
						}else{
							$("#used-earnedleave").html("0.0");
						}
						
					}
				}
			}
		});
	}
	
}


function takeScreenshot(){
	html2canvas(document.getElementById("salary-div")).then(canvas => {
		var url = canvas.toDataURL();
		console.log(url);
		sendSalaryMail(url);
	});
}

function sendSalaryMail(url){
	var params = {
		url: url
	}
	$.ajax({
		type: 'POST',
		url: '/sendSalaryMail',
		data: params,
		dataType: 'json',
		success: function(response){
			if(response.MESSAGE === "SUCCESS"){
				alert("Mail Sent Successfully...");
			}else{
				alert("Error Occurred!...");
				return false;
			}
		}
	})
}