function loginValidate(){
	var params = {
		Login_Id: $("#Login_Id").val(),
		Password: $("#Password").val()
	}
	if((params.Login_Id == "" || params.Login_Id == null) && (params.Password == "" || params.Password == null)){
		alert("Fields must not be null.");
		return false;
	}else if((params.Login_Id != "" || params.Login_Id != null) && (params.Password == "" || params.Password == null)){
		alert("Password must not be null.");
		return false;
	}else if((params.Login_Id == "" || params.Login_Id == null) && (params.Password != "" || params.Password != null)){
		alert("Login_Id must not be null.");
		return false;
	}else if(params.Login_Id == "admin" && params.Password == "admin"){
		alert("Logged In..");
		window.location.href="/employeeList";
	}
	/*else{
		$.ajax({
			type: 'POST',
			url: '/loginValidate',
			data: params,
			dataType: 'json',
			success: function(response){
				
			}
		})
	}*/
}