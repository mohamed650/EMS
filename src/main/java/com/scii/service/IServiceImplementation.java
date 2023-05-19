package com.scii.service;

import java.io.File;
import java.util.List;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
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

	@Autowired
	private JavaMailSender javaMailSender;
	
	@Value("${spring.mail.username}")
	private String sender;
	
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

	@Override
	public List<RegisterModel> loadDiscontinuedEmployeeDetails() {
		List<RegisterModel> loadDiscontinuedEmployeeList = imapper.loadDiscontinuedEmployeeDetails(new RegisterModel());
		return loadDiscontinuedEmployeeList;
	}

	@Override
	public String sendSalaryMail(String email, String salaryPath, String password, String paySlipDate, String employeeFirstName, String employeeLastName) {
		try {
			
			MimeMessage mimeMessage = javaMailSender.createMimeMessage();
			MimeMessageHelper mimeMessageHelper;
			
			String recepient = email;
			String text = "Dear, "+ employeeFirstName+" "+employeeLastName
						+"\n"
						+"Please find the Salary Slip for the Month of "+paySlipDate+"."+"\n"
						+"\n"
						+"Password for pdf is : "+password;
			String subject = "Salary Slip "+ paySlipDate;
			mimeMessageHelper = new MimeMessageHelper(mimeMessage, true);
			mimeMessageHelper.setFrom(sender);
			mimeMessageHelper.setTo(recepient);
			mimeMessageHelper.setText(text);
			mimeMessageHelper.setSubject(subject);
			
			FileSystemResource file = new FileSystemResource(new File(salaryPath));
			mimeMessageHelper.addAttachment(file.getFilename(), file);
			
			javaMailSender.send(mimeMessage);
			String status = "Mail Sent Successfully....";
			return status;
		} catch(Exception e) {
			e.printStackTrace();
			return "Error while Sending Mail";
		}
	}

	@Override
	public int insertLeaves(SalaryModel insertLeaves) {
		int status = imapper.insertLeaves(insertLeaves);
		return status;
	}

	@Override
	public List<SalaryModel> retrieveLeaves(SalaryModel getLeaves) {
		List<SalaryModel> leaveList = imapper.retrieveLeaves(getLeaves);
		return leaveList;
	}

	@Override
	public int updateLeaves(SalaryModel updateLeaves) {
		int status = imapper.updateLeaves(updateLeaves);
		return status;
	}
}
