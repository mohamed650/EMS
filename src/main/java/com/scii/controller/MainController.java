package com.scii.controller;

import java.text.DateFormatSymbols;
import java.text.DecimalFormat;
import java.util.*;
import java.io.File;
import java.io.*;
import java.io.OutputStream;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import com.itextpdf.text.Document;
import com.itextpdf.text.Image;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfWriter;
import com.scii.model.DepartmentModel;
import com.scii.model.DesignationModel;
import com.scii.model.RegisterModel;
import com.scii.model.SalaryImageModel;
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

	@GetMapping("/noConnection")
	public ModelAndView noConnection() throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("NoConnection");
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
			register.setDiscontinued(0);
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
				multimap.put(checkSalaryList.get(i).getSalary_Employee_Id(), checkSalaryList.get(i).getUsed_Sick_Leave());
				multimap.put(checkSalaryList.get(i).getSalary_Employee_Id(), checkSalaryList.get(i).getUsed_Earned_Leave());
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

		String empSickLeave = employeeSalary.getSick_Leave();
		String empUsedSickLeave = employeeSalary.getUsed_Sick_Leave();
		String empEarnedLeave = employeeSalary.getEarned_Leave();
		String empUsedEarnedLeave = employeeSalary.getUsed_Earned_Leave();
		if((empSickLeave != null && empSickLeave != "") || (empUsedSickLeave != null && empUsedSickLeave != "")){
			float balanceSickLeave = Float.parseFloat(empSickLeave);
			float usedSickLeave = Float.parseFloat(empUsedSickLeave);
			List<SalaryModel> getLeaveList = iservice.retrieveLeaves(employeeSalary);
			if(getLeaveList.size() > 0){
				balanceSickLeave = Float.parseFloat(getLeaveList.get(0).getSick_Leave()) + balanceSickLeave;
				usedSickLeave = Float.parseFloat(getLeaveList.get(0).getUsed_Sick_Leave()) + usedSickLeave;
				balanceSickLeave = balanceSickLeave - usedSickLeave;
				employeeSalary.setSick_Leave(String.valueOf(balanceSickLeave));
				employeeSalary.setUsed_Sick_Leave(String.valueOf(usedSickLeave));
				employeeSalary.setEarned_Leave(String.valueOf(0));
				employeeSalary.setUsed_Earned_Leave(String.valueOf(0));
				int status = iservice.updateLeaves(employeeSalary);
				System.out.println("Update: "+status);
			}else{
				employeeSalary.setSick_Leave(String.valueOf(balanceSickLeave));
				employeeSalary.setUsed_Sick_Leave(String.valueOf(usedSickLeave));
				int status = iservice.insertLeaves(employeeSalary);
				System.out.println("Insert: "+ status);
			}
		}
		
		if((empEarnedLeave != null && empEarnedLeave != "") || (empUsedEarnedLeave != null && empUsedEarnedLeave != "")){
			float balanceEarnedLeave = Float.parseFloat(empEarnedLeave);
			float usedEarnedLeave = Float.parseFloat(empUsedEarnedLeave);
			List<SalaryModel> getLeaveList = iservice.retrieveLeaves(employeeSalary);
			if(getLeaveList.size() > 0){
				balanceEarnedLeave = Float.parseFloat(getLeaveList.get(0).getEarned_Leave()) + balanceEarnedLeave;
				usedEarnedLeave = Float.parseFloat(getLeaveList.get(0).getUsed_Earned_Leave()) + usedEarnedLeave;
				balanceEarnedLeave = balanceEarnedLeave - usedEarnedLeave;
				employeeSalary.setEarned_Leave(String.valueOf(balanceEarnedLeave));
				employeeSalary.setUsed_Earned_Leave(String.valueOf(usedEarnedLeave));
				int status = iservice.updateLeaves(employeeSalary);
				System.out.println("Update: "+status);
			}else{
				employeeSalary.setEarned_Leave(String.valueOf(balanceEarnedLeave));
				employeeSalary.setUsed_Earned_Leave(String.valueOf(usedEarnedLeave));
				int status = iservice.insertLeaves(employeeSalary);
				System.out.println("Insert: "+ status);
			}
		}
		List<SalaryModel> getUpdatedLeaveList = iservice.retrieveLeaves(employeeSalary);
		if(getUpdatedLeaveList.size() == 0){
			employeeSalary.setSick_Leave(String.valueOf(0));
			employeeSalary.setUsed_Sick_Leave(String.valueOf(0));
			employeeSalary.setEarned_Leave(String.valueOf(0));
			employeeSalary.setUsed_Earned_Leave(String.valueOf(0));
			int status = iservice.insertLeaves(employeeSalary);
			System.out.println("Insert: "+ status);
		}
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
	public @ResponseBody void retrieveSlaryDetails(@ModelAttribute("salaryDetails") SalaryRetrievalModel salaryDetails, HttpServletResponse response, HttpSession httpSession) throws Exception{
		MultiMap<String, String> multiMap = new MultiValueMap<String, String>();
		SalaryRetrievalModel retrieveSalary = salaryDetails;
		List<SalaryRetrievalModel> retrieveSalaryList = iservice.retrieveSalaryDetails(retrieveSalary);
		if(retrieveSalaryList.size() > 0) {
			for(int i=0; i<retrieveSalaryList.size(); i++) {
				multiMap.put(retrieveSalaryList.get(i).getEmployee_Id(), retrieveSalaryList.get(i).getSl_no());
				multiMap.put(retrieveSalaryList.get(i).getEmployee_Id(), retrieveSalaryList.get(i).getPay_Slip());
				httpSession.setAttribute("PaySlip", retrieveSalaryList.get(i).getPay_Slip().trim());
				multiMap.put(retrieveSalaryList.get(i).getEmployee_Id(), retrieveSalaryList.get(i).getEmployeeName());
				httpSession.setAttribute("FIRSTNAME", retrieveSalaryList.get(i).getFirstName().trim());
				httpSession.setAttribute("LASTNAME", retrieveSalaryList.get(i).getLastName().trim());
				multiMap.put(retrieveSalaryList.get(i).getEmployee_Id(), retrieveSalaryList.get(i).getBank_Name());
				multiMap.put(retrieveSalaryList.get(i).getEmployee_Id(), retrieveSalaryList.get(i).getWorked_Days());
				multiMap.put(retrieveSalaryList.get(i).getEmployee_Id(), retrieveSalaryList.get(i).getEmployee_Id());
				httpSession.setAttribute("EMPID", retrieveSalaryList.get(i).getEmployee_Id().trim());
				multiMap.put(retrieveSalaryList.get(i).getEmployee_Id(), retrieveSalaryList.get(i).getAccountNumber());
				multiMap.put(retrieveSalaryList.get(i).getEmployee_Id(), retrieveSalaryList.get(i).getDepartment_Name());
				multiMap.put(retrieveSalaryList.get(i).getEmployee_Id(), retrieveSalaryList.get(i).getPfAccountNumber());
				multiMap.put(retrieveSalaryList.get(i).getEmployee_Id(), retrieveSalaryList.get(i).getDesignation_Name());
				multiMap.put(retrieveSalaryList.get(i).getEmployee_Id(), retrieveSalaryList.get(i).getDateofJoining());
				float BasicSalary = Float.parseFloat(retrieveSalaryList.get(i).getBasic_Salary().trim());
				String empUsedSickLeave = retrieveSalaryList.get(i).getUsed_Sick_Leave().trim();
				String empUsedEarnedLeave = retrieveSalaryList.get(i).getUsed_Earned_Leave().trim();
				float totalWorkingDays = 22;
				float holidayDays = 8;
				float workingHours = 8;
				float workedDays = Float.parseFloat(retrieveSalaryList.get(i).getWorked_Days().trim());
				float totalWorkedDays =  workedDays - holidayDays;
				if(totalWorkingDays != totalWorkedDays){
					float perDaySalary = BasicSalary / totalWorkingDays;
					float perHourSalary = perDaySalary / workingHours;
					float absenceWorkingDays = totalWorkingDays - totalWorkedDays;
					float absenceWorkingHours = absenceWorkingDays * workingHours;
					float absenceHourSalary = perHourSalary * absenceWorkingHours;
					if(empUsedSickLeave != null && empUsedSickLeave != ""){
						float usedSickLeave = Float.parseFloat(empUsedSickLeave);
						float sickLeaveHours = usedSickLeave * workingHours;
						float sickLeaveHoursSalary = sickLeaveHours * perHourSalary;
						BasicSalary = BasicSalary - (absenceHourSalary - sickLeaveHoursSalary);
					}else if(empUsedEarnedLeave != null && empUsedEarnedLeave != ""){
						int usedEarnedLeave = Integer.parseInt(empUsedEarnedLeave);
						int earnedLeaveHours = (int) (usedEarnedLeave * workingHours);
						int earnedLeaveHoursSalary = (int) (earnedLeaveHours * perHourSalary);
						BasicSalary = BasicSalary - (absenceHourSalary - earnedLeaveHoursSalary);
					}else{
						BasicSalary = BasicSalary - absenceHourSalary;
					}
				}
				

				if(String.valueOf(BasicSalary).indexOf(".") > -1) {
					multiMap.put(retrieveSalaryList.get(i).getEmployee_Id(), String.valueOf(BasicSalary));
				}else {
					multiMap.put(retrieveSalaryList.get(i).getEmployee_Id(), String.valueOf(BasicSalary).concat(".00"));
				}
				
				float pf = (float) (0.12 * BasicSalary);
				multiMap.put(retrieveSalaryList.get(i).getEmployee_Id(), df.format(pf));	
				float dpa = (float) (0.1667 * BasicSalary);
				multiMap.put(retrieveSalaryList.get(i).getEmployee_Id(), df.format(dpa));
				float professionalTax = (float) 200.00;
				multiMap.put(retrieveSalaryList.get(i).getEmployee_Id(), df.format(professionalTax));
				float hra = (float) (0.4 * BasicSalary);
				multiMap.put(retrieveSalaryList.get(i).getEmployee_Id(), df.format(hra));
				float conveyance = (float) (0.1 * BasicSalary);
				multiMap.put(retrieveSalaryList.get(i).getEmployee_Id(), df.format(conveyance));
				float totalA = BasicSalary + Float.parseFloat(df.format(dpa)) + 
							Float.parseFloat(df.format(hra)) + Float.parseFloat(df.format(conveyance));
				multiMap.put(retrieveSalaryList.get(i).getEmployee_Id(), df.format(totalA));
				float totalB = Float.parseFloat(df.format(pf)) + Float.parseFloat(df.format(professionalTax));
				multiMap.put(retrieveSalaryList.get(i).getEmployee_Id(), df.format(totalB));
				float totalPaid = totalA - totalB;
				multiMap.put(retrieveSalaryList.get(i).getEmployee_Id(), df.format(totalPaid));
				multiMap.put(retrieveSalaryList.get(i).getEmployee_Id(), retrieveSalaryList.get(i).getSick_Leave().trim());
				multiMap.put(retrieveSalaryList.get(i).getEmployee_Id(), retrieveSalaryList.get(i).getUsed_Sick_Leave().trim());
				multiMap.put(retrieveSalaryList.get(i).getEmployee_Id(), retrieveSalaryList.get(i).getEarned_Leave().trim());
				multiMap.put(retrieveSalaryList.get(i).getEmployee_Id(), retrieveSalaryList.get(i).getUsed_Earned_Leave().trim());
				httpSession.setAttribute("Email", retrieveSalaryList.get(i).getEmail_Id().trim());
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


	@RequestMapping("/loadDiscontinuedEmployeeDetails")
	public @ResponseBody Object loadDiscontinuedEmployeeDetails() throws Exception{
		List<RegisterModel> discontinuedEmployeeList = iservice.loadDiscontinuedEmployeeDetails();
		return discontinuedEmployeeList;
	}

	@RequestMapping("/sendSalaryMail")
	public @ResponseBody void sendSalaryMail(@ModelAttribute ("url") SalaryImageModel url, HttpSession httpSession, HttpServletResponse response) throws Exception{
		Map<String, String> map = new HashMap<String, String>();
		String imgUrl = url.getUrl();
		imgUrl = imgUrl.replace("data:image/png;base64,", "");
		//String[] imgParts = imgUrl.split(",");
		byte[] data = Base64.getDecoder().decode(imgUrl);
		String path = "D:\\salaryImage.png";
		File file = new File(path);
		try (OutputStream outputStream = new BufferedOutputStream(new FileOutputStream(file))) {
			outputStream.write(data);
			String paySlipDate = (String) httpSession.getAttribute("PaySlip");
			paySlipDate = paySlipDate.replaceAll("\\s", "");
			String emp_Id = (String) httpSession.getAttribute("EMPID");
			String email = (String ) httpSession.getAttribute("Email");
			String salaryPath = "D:\\EMS-Salaryslips\\"+emp_Id+"_"+"Salaryslip_"+paySlipDate+".pdf";
			String employeeFirstName = (String) httpSession.getAttribute("FIRSTNAME");
			String employeeLastName = (String) httpSession.getAttribute("LASTNAME");
			String password = genratePassword(6);
			Document document = new Document();
			PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(salaryPath));
			writer.setEncryption(password.getBytes(), password.getBytes(),
                    PdfWriter.ALLOW_PRINTING, PdfWriter.ENCRYPTION_AES_128);
			document.open();
			PdfContentByte graphics = writer.getDirectContent();
			Image image = Image.getInstance(data);
			float x = 50;
            float y = 320;
            float width = 500;
            float height = 500;
			graphics.addImage(image, width, 0, 0, height, x, y);
			//document.add(Image.getInstance(data));
			document.close();
			System.out.println(password);
			String mailStatus = iservice.sendSalaryMail(email, salaryPath, password, paySlipDate, employeeFirstName, employeeLastName);
			if(mailStatus == "Mail Sent Successfully....") {
				map.put("MESSAGE", "SUCCESS");
			}else {
				map.put("MESSAGE", "Failed");
			}
		} catch (Exception e) {
			e.printStackTrace();
			map.put("MESSAGE", "FAILURE");
		}
		Gson gson = new Gson();
		String json = gson.toJson(map);
		response.getWriter().print(json);
	}

	private static String genratePassword(int length){
		String allowedChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
		Random random = new Random();
		StringBuilder password = new StringBuilder();
		for(int i=0; i<length; i++){
			int randomIndex = random.nextInt(allowedChars.length());
			password.append(allowedChars.charAt(randomIndex));
		}
		return password.toString();
	}
}
