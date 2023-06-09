$(document).ready(function(){
    loadDiscontinuedEmployeeList();
});

var table;
function loadDiscontinuedEmployeeList(){
	var today = new Date();
	today = today.getFullYear()+"-"+('0' + (today.getMonth() + 1)).slice(-2)+"-"+('0' + today.getDate()).slice(-2);
    table = new Tabulator("#discontinued-employeeTabulator", {
		layout:"fitColumns",
		height: "360px",
		rowFormatter:function(row){
			if(row.getData().dateofLeaving == today){
				row.getElement().style.backgroundColor = "#ffbe33";
				row.getElement().style.pointerEvents = "none"; 
			}
		},
		pagination: "local",
    	paginationSize: 10,
    	paginationSizeSelector: [3, 6, 8, 10],
    	movableColumns: true,
    	paginationCounter:"rows",
		ajaxURL    :  "/loadDiscontinuedEmployeeDetails",
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
		{title:"Date of Leaving", field:"dateofLeaving", hozAlign:"center", visible: false},
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
		],
	});
}