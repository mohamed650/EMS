package com.scii.mapper;
import java.util.*;

import org.apache.ibatis.annotations.Mapper;

import com.scii.model.DepartmentModel;
import com.scii.model.DesignationModel;
import com.scii.model.RegisterModel;
import com.scii.model.SalaryModel;
import com.scii.model.SalaryRetrievalModel;


@Mapper
public interface IMapper {
	
	public List<RegisterModel> checkUser(RegisterModel checkUser);
	
	public int insertUser(RegisterModel insertUser);
	
	public List<DepartmentModel> loadDepartments(DepartmentModel departmentInfo);
	
	public List<DesignationModel> loadDesignations(DesignationModel designationInfo);
	
	public List<RegisterModel> loadEmployeeDetails(RegisterModel loadEmployee);
	
	public List<SalaryModel> checkMonthYear(SalaryModel checkMonthYear);
	
	public int updateUser(RegisterModel updateUser);
	
	public int insertSalary(SalaryModel insertSalary);

	public List<SalaryModel> retrieveLeaves(SalaryModel getLeaves);

	public int insertLeaves(SalaryModel insertLeaves);

	public int updateLeaves(SalaryModel updateLeaves);
	
	public List<SalaryRetrievalModel> retrieveSalaryDetails(SalaryRetrievalModel retrieveSalaryDetails);
	
	public List<RegisterModel> searchEmployeeDetails(RegisterModel searchEmployee);

	public List<RegisterModel> loadDiscontinuedEmployeeDetails(RegisterModel loadEmployee);
}
