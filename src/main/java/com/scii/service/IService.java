package com.scii.service;

import java.util.List;

import com.scii.model.DepartmentModel;
import com.scii.model.DesignationModel;
import com.scii.model.RegisterModel;
import com.scii.model.SalaryModel;
import com.scii.model.SalaryRetrievalModel;

public interface IService {
	
	public List<RegisterModel> checkUser(RegisterModel checkUser);
	
	public int insertUser(RegisterModel insertUser);
	
	public List<DepartmentModel> loadDepartments(DepartmentModel departmentInfo);
	
	public List<DesignationModel> loadDesignations(DesignationModel designationInfo);
	
	public List<RegisterModel> loadEmployeeDetails();
	
	public List<SalaryModel> checkMonthYear(SalaryModel checkMonthYear);
	
	public int updateUser(RegisterModel updateUser);
	
	public int insertSalary(SalaryModel insertSalary);

	public List<SalaryModel> retrieveLeaves(SalaryModel getLeaves);
	
	public int updateLeaves(SalaryModel updateLeaves);
	
	public List<SalaryRetrievalModel> retrieveSalaryDetails(SalaryRetrievalModel retrieveSalaryDetails);
	
	public List<RegisterModel> searchEmployeeDetails(RegisterModel searchEmployee);
	
	public List<RegisterModel> loadDiscontinuedEmployeeDetails();

	String sendSalaryMail(String email, String salaryPath, String password, String paySlipDate, String employeeFirstName, String employeeLastName);
	
}
