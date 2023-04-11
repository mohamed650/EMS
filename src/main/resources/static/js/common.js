
var page = location.pathname.substring(location.pathname.lastIndexOf('/')+1);
	//page = fullPath.replace(/^.*[\\\/]/, '');
	if(page === "employeeList"){
		$("#li-employee").addClass("active");
		$("#li-register").removeClass("active");
		$("#li-salary").removeClass("active");
		$("#li-discontinued").removeClass("active");
	} else if(page === "navigateRegister"){
		$("#li-employee").removeClass("active");
		$("#li-register").addClass("active");
		$("#li-salary").removeClass("active");
		$("#li-discontinued").removeClass("active");
	} else if(page === "navigateSalaryRetrieval"){
		$("#li-employee").removeClass("active");
		$("#li-register").removeClass("active");
		$("#li-salary").addClass("active");
		$("#li-discontinued").removeClass("active");
	}  else if(page === "navigateDiscontinuedEmployee"){
		$("#li-employee").removeClass("active");
		$("#li-register").removeClass("active");
		$("#li-salary").removeClass("active");
		$("#li-discontinued").addClass("active");
	}