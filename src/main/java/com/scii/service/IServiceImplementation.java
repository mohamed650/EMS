package com.scii.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.scii.model.DepartmentModel;
import com.scii.model.DesignationModel;
import com.scii.model.RegisterModel;
import com.scii.model.SalaryModel;
import com.scii.model.SalaryRetrievalModel;
import com.scii.mapper.IMapper;

@Component
public class IServiceImplementation implements IService {
	
	@Autowired(required=false)
	IMapper imapper;
	
	@Override
	public List<RegisterModel> checkUser(RegisterModel checkUser) {
		List<RegisterModel> checkUserList = imapper.checkUser(checkUser);
		return checkUserList;
	}

	@Override
	public int insertUser(RegisterModel insertUser) {
		int status = imapper.insertUser(insertUser);
		return status;
	}

	@Override
	public List<DepartmentModel> loadDepartments(DepartmentModel departmentInfo) {
		List<DepartmentModel> loadDepartmentList = imapper.loadDepartments(departmentInfo);
		return loadDepartmentList;
	}

	@Override
	public List<DesignationModel> loadDesignations(DesignationModel designationInfo) {
		List<DesignationModel> loadDesignationList = imapper.loadDesignations(designationInfo);
		return loadDesignationList;
	}

	@Override
	public List<RegisterModel> loadEmployeeDetails() {
		List<RegisterModel> loadEmployeeList = imapper.loadEmployeeDetails(new RegisterModel());
		return loadEmployeeList;
	}

	@Override
	public List<SalaryModel> checkMonthYear(SalaryModel checkMonthYear) {
		List<SalaryModel> checkSalaryList = imapper.checkMonthYear(checkMonthYear);
		return checkSalaryList;
	}

	@Override
	public int updateUser(RegisterModel updateUser) {
		int status = imapper.updateUser(updateUser);
		return status;
	}

	@Override
	public int insertSalary(SalaryModel insertSalary) {
		int status = imapper.insertSalary(insertSalary);
		return status;
	}

	@Override
	public List<SalaryRetrievalModel> retrieveSalaryDetails(SalaryRetrievalModel retrieveSalaryDetails) {
		List<SalaryRetrievalModel> retrieveSalaryList = imapper.retrieveSalaryDetails(retrieveSalaryDetails);
		return retrieveSalaryList;
	}

	@Override
	public List<RegisterModel> searchEmployeeDetails(RegisterModel searchEmployee) {
		List<RegisterModel> searchEmployeeList = imapper.searchEmployeeDetails(searchEmployee);
		return searchEmployeeList;
	}
}
