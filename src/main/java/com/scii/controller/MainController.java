package com.scii.controller;

import java.text.DateFormatSymbols;
import java.text.DecimalFormat;
import java.time.LocalDate;
import java.time.Year;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.lang.*;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections4.MultiMap;
import org.apache.commons.collections4.map.MultiValueMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.scii.model.DepartmentModel;
import com.scii.model.DesignationModel;
import com.scii.model.RegisterModel;
import com.scii.model.SalaryModel;
import com.scii.model.SalaryRetrievalModel;
import com.scii.service.IService;


@RestController
public class MainController {
	
	@Autowired
	private IService iservice;
	
	private static final DecimalFormat df = new DecimalFormat("0.00");
	
	@GetMapping("/")
	public ModelAndView login() throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("Login");
		return modelAndView;
	}
	
	@GetMapping("/employeeList")
	public ModelAndView employeeList() throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("EmployeeList");
		return modelAndView;
	}
	
	@GetMapping("/navigateRegister")
	public ModelAndView registerPage() throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("Register");
		return modelAndView;
	}
	
	@GetMapping("/navigateSalaryRetrieval")
	public ModelAndView salaryPage() throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("SalaryRetrieval");
		return modelAndView;
	}
	
	@GetMapping("/navigateDiscontinuedEmployee")
	public ModelAndView discontinuedPage() throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("DiscontinuedEmployee");
		return modelAndView;
	}
	
	@RequestMapping("/loadDepartment")
	public @ResponseBody void loadDepartment(HttpServletResponse response) throws Exception{
		Map<String, String> map = new HashMap<String, String>();
		DepartmentModel department = new DepartmentModel();
		List<DepartmentModel> departmentList = iservice.loadDepartments(department);
		for(int i=0; i<departmentList.size(); i++) {
			map.put(departmentList.get(i).getDepartment_Id(), departmentList.get(i).getDepartment_Name());
		}
		Gson gson = new Gson();
		String json = gson.toJson(map);
		//json = json.replaceAll("\\s", "");
		response.getWriter().print(json);
	}
	
	@RequestMapping("/loadDesignation")
	public @ResponseBody void loadDesignation(HttpServletResponse response) throws Exception{
		Map<String, String> map = new HashMap<String, String>();
		DesignationModel designation = new DesignationModel();
		List<DesignationModel> designationList = iservice.loadDesignations(designation);
		for(int i=0; i<designationList.size(); i++) {
			map.put(designationList.get(i).getDesignation_Id(), designationList.get(i).getDesignation_Name());
		}
		Gson gson = new Gson();
		String json = gson.toJson(map);
		//json = json.replaceAll("\\s", "");
		response.getWriter().print(json);
	}
	
	@RequestMapping("/loadBatch")
	public @ResponseBody Object loadBatch(HttpServletResponse response) throws Exception{
		ObjectMapper mapper = new ObjectMapper();
		List<Integer> years = new ArrayList<Integer>();
		int endYear = Calendar.getInstance().get(Calendar.YEAR);
		for(int year = endYear;year >= 2005; year--){
		    //System.out.println(year);// if you just want to print the years.
		    years.add(year);// if you want to store the years in an array list.
		}
		return mapper.writeValueAsString(years);

	}
	
	@RequestMapping("/insertUser")
	public @ResponseBody Object insertUser(@ModelAttribute ("user") RegisterModel user) throws Exception{
		Map<String, String> map = new HashMap<String, String>();
		ObjectMapper mapper = new ObjectMapper();
		RegisterModel register = user;
		List<RegisterModel> registerList = iservice.checkUser(register);
		if(registerList.size() > 0) {
			map.put("MESSAGE", "USEREXIST");
		}else {
			int status = iservice.insertUser(register);
			if(status > 0) {
				map.put("MESSAGE", "SUCCESS");
			}else {
				map.put("MESSAGE", "FAILED");
			}
		}
		return mapper.writeValueAsString(map);
	}
	
	@RequestMapping("/updateUser")
	public @ResponseBody Object updateUser(@ModelAttribute ("user") RegisterModel user) throws Exception{
		Map<String, String> map = new HashMap<String, String>();
		ObjectMapper mapper = new ObjectMapper();
		RegisterModel register = user;
		int status = iservice.updateUser(register);
		if(status > 0) {
			map.put("MESSAGE", "SUCCESS");
		}else {
			map.put("MESSAGE", "FAILED");
		}
		return mapper.writeValueAsString(map);
	}
	
	@RequestMapping("/loadEmployeeDetails")
	public @ResponseBody Object loadEmployeeDetails() throws Exception{
		List<RegisterModel> employeeList = iservice.loadEmployeeDetails();
		return employeeList;
	}
	
	@RequestMapping("/loadEmployeeNames")
	public @ResponseBody Object loadEmployeeNames() throws Exception{
		ObjectMapper mapper = new ObjectMapper();
		Map<String, String> map = new HashMap<String, String>();
		List<RegisterModel> employeeNameList = iservice.loadEmployeeDetails();
		if(employeeNameList.size() > 0) {
			for(int i=0; i<employeeNameList.size(); i++) {
				map.put(employeeNameList.get(i).getEmployee_Id(), employeeNameList.get(i).getEmployeeName());
			}
		}else{
			map.put("MESSAGE", "EMPLOYEENOTEXIST");
		}
		return mapper.writeValueAsString(map);
	}
	
	@RequestMapping("/loadMonths")
	public @ResponseBody Object loadMonths() throws Exception{
		ObjectMapper mapper = new ObjectMapper();
		DateFormatSymbols dfs = new DateFormatSymbols();
		String[] monthNames = dfs.getShortMonths();
		return mapper.writeValueAsString(monthNames);
	}
	
	@SuppressWarnings("deprecation")
	@RequestMapping("/checkMonthYear")
	public @ResponseBody void checkMonthYear(@ModelAttribute ("salarymodel")SalaryModel salarymodel, HttpServletResponse response) throws Exception{
		MultiMap<String, String> multimap = new MultiValueMap<String, String>();
		List<SalaryModel> checkSalaryList = iservice.checkMonthYear(salarymodel);
		if(checkSalaryList.size() > 0) {
			for(int i=0; i< checkSalaryList.size(); i++) {
				multimap.put(checkSalaryList.get(i).getSalary_Employee_Id(), checkSalaryList.get(i).getBasic_Salary());
				multimap.put(checkSalaryList.get(i).getSalary_Employee_Id(), checkSalaryList.get(i).getWorked_Days());
				multimap.put(checkSalaryList.get(i).getSalary_Employee_Id(), checkSalaryList.get(i).getSick_Leave());
				multimap.put(checkSalaryList.get(i).getSalary_Employee_Id(), checkSalaryList.get(i).getEarned_Leave());
			}
		}else {
			multimap.put("MESSAGE", "SALARYNOTEXIST");
		}
		Gson gson = new Gson();
		String json = gson.toJson(multimap);
		//json = json.replaceAll("\\s", "");
		response.getWriter().print(json);
	}
	
	@RequestMapping("/insertSalary")
	public @ResponseBody Object insertSalary(@ModelAttribute ("salary") SalaryModel salary) throws Exception{
		Map<String, String> map = new HashMap<String, String>();
		ObjectMapper mapper = new ObjectMapper();
		SalaryModel employeeSalary = salary;
		int status = iservice.insertSalary(employeeSalary);
		if(status > 0) {
			map.put("MESSAGE", "SUCCESS");
		}else {
			map.put("MESSAGE", "FAILED");
		}
		return mapper.writeValueAsString(map);
	}
	
	@SuppressWarnings("deprecation")
	@RequestMapping("/retrieveSalary")
	public @ResponseBody void retrieveSlaryDetails(@ModelAttribute("salaryDetails") SalaryRetrievalModel salaryDetails, HttpServletResponse response) throws Exception{
		MultiMap<String, String> multiMap = new MultiValueMap<String, String>();
		SalaryRetrievalModel retrieveSalary = salaryDetails;
		List<SalaryRetrievalModel> retrieveSalaryList = iservice.retrieveSalaryDetails(retrieveSalary);
		if(retrieveSalaryList.size() > 0) {
			for(int i=0; i<retrieveSalaryList.size(); i++) {
				multiMap.put(retrieveSalaryList.get(i).getEmployee_Id(), retrieveSalaryList.get(i).getSl_no());
				multiMap.put(retrieveSalaryList.get(i).getEmployee_Id(), retrieveSalaryList.get(i).getPay_Slip());
				multiMap.put(retrieveSalaryList.get(i).getEmployee_Id(), retrieveSalaryList.get(i).getEmployeeName());
				multiMap.put(retrieveSalaryList.get(i).getEmployee_Id(), retrieveSalaryList.get(i).getBank_Name());
				multiMap.put(retrieveSalaryList.get(i).getEmployee_Id(), retrieveSalaryList.get(i).getWorked_Days());
				multiMap.put(retrieveSalaryList.get(i).getEmployee_Id(), retrieveSalaryList.get(i).getEmployee_Id());
				multiMap.put(retrieveSalaryList.get(i).getEmployee_Id(), retrieveSalaryList.get(i).getAccountNumber());
				multiMap.put(retrieveSalaryList.get(i).getEmployee_Id(), retrieveSalaryList.get(i).getDepartment_Name());
				multiMap.put(retrieveSalaryList.get(i).getEmployee_Id(), retrieveSalaryList.get(i).getPfAccountNumber());
				multiMap.put(retrieveSalaryList.get(i).getEmployee_Id(), retrieveSalaryList.get(i).getDesignation_Name());
				multiMap.put(retrieveSalaryList.get(i).getEmployee_Id(), retrieveSalaryList.get(i).getDateofJoining());
				if(retrieveSalaryList.get(i).getBasic_Salary().indexOf(".") > -1) {
					multiMap.put(retrieveSalaryList.get(i).getEmployee_Id(), retrieveSalaryList.get(i).getBasic_Salary());
				}else {
					multiMap.put(retrieveSalaryList.get(i).getEmployee_Id(), retrieveSalaryList.get(i).getBasic_Salary().concat(".00"));
				}
				String BasicSalary = retrieveSalaryList.get(i).getBasic_Salary();
				float pf = (float) (0.12 * Float.parseFloat(BasicSalary));
				multiMap.put(retrieveSalaryList.get(i).getEmployee_Id(), df.format(pf));	
				float dpa = (float) (0.1667 * Float.parseFloat(BasicSalary));
				multiMap.put(retrieveSalaryList.get(i).getEmployee_Id(), df.format(dpa));
				float professionalTax = (float) 200.00;
				multiMap.put(retrieveSalaryList.get(i).getEmployee_Id(), df.format(professionalTax));
				float hra = (float) (0.4 * Float.parseFloat(BasicSalary));
				multiMap.put(retrieveSalaryList.get(i).getEmployee_Id(), df.format(hra));
				float conveyance = (float) (0.1 * Float.parseFloat(BasicSalary));
				multiMap.put(retrieveSalaryList.get(i).getEmployee_Id(), df.format(conveyance));
				float totalA = Float.parseFloat(BasicSalary) + Float.parseFloat(df.format(dpa)) + 
							Float.parseFloat(df.format(hra)) + Float.parseFloat(df.format(conveyance));
				multiMap.put(retrieveSalaryList.get(i).getEmployee_Id(), df.format(totalA));
				float totalB = Float.parseFloat(df.format(pf)) + Float.parseFloat(df.format(professionalTax));
				multiMap.put(retrieveSalaryList.get(i).getEmployee_Id(), df.format(totalB));
				float totalPaid = totalA - totalB;
				multiMap.put(retrieveSalaryList.get(i).getEmployee_Id(), df.format(totalPaid));
			}
		}else {
			multiMap.put("MESSAGE", "SALARYDOESNOTEXIST");
		}
		Gson gson = new Gson();
		String json = gson.toJson(multiMap);
		//json = json.replaceAll("\\s", "");
		response.getWriter().print(json);
	}
	
	@RequestMapping("/searchEmployeeDetails")
	public @ResponseBody Object searchEmployee(@ModelAttribute ("searchEmployee") RegisterModel searchEmployee) throws Exception{
		List<RegisterModel> searchEmployeeList = iservice.searchEmployeeDetails(searchEmployee);
		System.out.println(searchEmployeeList.size());
		return searchEmployeeList;
	}
}
