package com.scii.controller;

import java.text.DateFormatSymbols;
import java.text.DecimalFormat;
import java.util.*;
import java.io.File;
import java.io.*;
import java.io.OutputStream;
import java.net.URL;
import java.net.URLConnection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections4.MultiMap;
import org.apache.commons.collections4.map.MultiValueMap;
// import org.apache.logging.log4j.Level;
// import org.apache.logging.log4j.LogManager;
// import org.apache.logging.log4j.Logger;
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

	// private static final Logger logger = LogManager.getLogger(MainController.class.getName());

	Gson gson = new Gson();
	
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
		URL connectionUrl = new URL("http://localhost:8080/");
		URLConnection connection = connectionUrl.openConnection();
		connection.connect();
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
	public @ResponseBody void loadDepartment(HttpServletResponse response) {
		try {
			Map<String, String> map = new HashMap<String, String>();
			DepartmentModel department = new DepartmentModel();
			List<DepartmentModel> departmentList = iservice.loadDepartments(department);
			for(int i=0; i<departmentList.size(); i++) {
				map.put(departmentList.get(i).getDepartment_Id(), departmentList.get(i).getDepartment_Name());
			}
			String json = gson.toJson(map);
			response.getWriter().print(json);
		} catch (Exception e) {
			// logger.log(Level.ERROR, e);
            e.printStackTrace();
		}
	}
	
	@RequestMapping("/loadDesignation")
	public @ResponseBody void loadDesignation(HttpServletResponse response) {
		try {
			Map<String, String> map = new HashMap<String, String>();
			DesignationModel designation = new DesignationModel();
			List<DesignationModel> designationList = iservice.loadDesignations(designation);
			for(int i=0; i<designationList.size(); i++) {
				map.put(designationList.get(i).getDesignation_Id(), designationList.get(i).getDesignation_Name());
			}
			String json = gson.toJson(map);
			response.getWriter().print(json);
		} catch (Exception e) {
			// logger.log(Level.ERROR, e);
            e.printStackTrace();
		}
	}
	
	@RequestMapping("/loadBatch")
	public @ResponseBody Object loadBatch(HttpServletResponse response) {
		try {
			ObjectMapper mapper = new ObjectMapper();
			List<Integer> years = new ArrayList<Integer>();
			int endYear = Calendar.getInstance().get(Calendar.YEAR);
			for(int year = endYear;year >= 2005; year--){
				//System.out.println(year);// if you just want to print the years.
				years.add(year);// if you want to store the years in an array list.
			}
			return mapper.writeValueAsString(years);
		} catch (Exception e) {
			List<String> exceptionList = new ArrayList<>();
			exceptionList.add("Exception Occured!!!");
			// logger.log(Level.ERROR, e);
			return exceptionList;
		}
	}
	
	@RequestMapping("/insertUser")
	public @ResponseBody void insertUser(@ModelAttribute ("user") RegisterModel user, HttpServletResponse response) {
		try {
			Map<String, String> map = new HashMap<String, String>();
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
			String json = gson.toJson(map);
			response.getWriter().print(json);
			// logger.log(Level.INFO, map.get("MESSAGE"));
		} catch (Exception e) {
			// logger.log(Level.ERROR, e);
            e.printStackTrace();
		}
	}
	
	@RequestMapping("/updateUser")
	public @ResponseBody void updateUser(@ModelAttribute ("user") RegisterModel user, HttpServletResponse response) {
		try {
			Map<String, String> map = new HashMap<String, String>();
			RegisterModel register = user;
			int status = iservice.updateUser(register);
			if(status > 0) {
				map.put("MESSAGE", "SUCCESS");
			}else {
				map.put("MESSAGE", "FAILED");
			}
			String json = gson.toJson(map);
			response.getWriter().print(json);
			// logger.log(Level.INFO, map.get("MESSAGE"));
		} catch (Exception e) {
			// logger.log(Level.ERROR, e);
            e.printStackTrace();
		}
	}
	
	@RequestMapping("/loadEmployeeDetails")
	public @ResponseBody Object loadEmployeeDetails() {
		List<RegisterModel> employeeList = iservice.loadEmployeeDetails();
		return employeeList;
	}
	
	@RequestMapping("/loadEmployeeNames")
	public @ResponseBody void loadEmployeeNames(HttpServletResponse response) {
		try {
			Map<String, String> map = new HashMap<String, String>();
			List<RegisterModel> employeeNameList = iservice.loadEmployeeDetails();
			if(employeeNameList.size() > 0) {
				for(int i=0; i<employeeNameList.size(); i++) {
					map.put(employeeNameList.get(i).getEmployee_Id(), employeeNameList.get(i).getEmployeeName());
				}
			}else{
				map.put("MESSAGE", "EMPLOYEENOTEXIST");
				// logger.log(Level.INFO, map.get("MESSAGE"));
			}
			String json = gson.toJson(map);
			response.getWriter().print(json);
		} catch (Exception e) {
			// logger.log(Level.ERROR, e);
            e.printStackTrace();
		}
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
	public @ResponseBody void checkMonthYear(@ModelAttribute ("salarymodel")SalaryModel salarymodel, HttpServletResponse response) {
		try {
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
				// logger.log(Level.INFO, multimap.get("MESSAGE"));
			}
			String json = gson.toJson(multimap);
			response.getWriter().print(json);
		} catch (Exception e) {
			// logger.log(Level.ERROR, e);
            e.printStackTrace();
		}
	}
	
	@RequestMapping("/insertSalary")
	public @ResponseBody void insertSalary(@ModelAttribute ("salary") SalaryModel salary, HttpServletResponse response) {
		try {
			Map<String, String> map = new HashMap<String, String>();
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
					//usedSickLeave = Float.parseFloat(getLeaveList.get(0).getUsed_Sick_Leave()) + usedSickLeave;
					balanceSickLeave = balanceSickLeave - usedSickLeave;
					employeeSalary.setSick_Leave(String.valueOf(balanceSickLeave));
					employeeSalary.setUsed_Sick_Leave(String.valueOf(usedSickLeave));
					employeeSalary.setEarned_Leave(String.valueOf(0));
					employeeSalary.setUsed_Earned_Leave(String.valueOf(0));
				}else{
					employeeSalary.setSick_Leave(String.valueOf(balanceSickLeave));
					employeeSalary.setUsed_Sick_Leave(String.valueOf(usedSickLeave));
				}
			}	
			if((empEarnedLeave != null && empEarnedLeave != "") || (empUsedEarnedLeave != null && empUsedEarnedLeave != "")){
				float balanceEarnedLeave = Float.parseFloat(empEarnedLeave);
				float usedEarnedLeave = Float.parseFloat(empUsedEarnedLeave);
				List<SalaryModel> getLeaveList = iservice.retrieveLeaves(employeeSalary);
				if(getLeaveList.size() > 0){
					balanceEarnedLeave = Float.parseFloat(getLeaveList.get(0).getEarned_Leave()) + balanceEarnedLeave;
					//usedEarnedLeave = Float.parseFloat(getLeaveList.get(0).getUsed_Earned_Leave()) + usedEarnedLeave;
					balanceEarnedLeave = balanceEarnedLeave - usedEarnedLeave;
					employeeSalary.setEarned_Leave(String.valueOf(balanceEarnedLeave));
					employeeSalary.setUsed_Earned_Leave(String.valueOf(usedEarnedLeave));
				}else{
					employeeSalary.setEarned_Leave(String.valueOf(balanceEarnedLeave));
					employeeSalary.setUsed_Earned_Leave(String.valueOf(usedEarnedLeave));
				}
			}
			if(((empSickLeave == null && empSickLeave == "") || (empUsedSickLeave == null && empUsedSickLeave == "")) && ((empEarnedLeave == null && empEarnedLeave == "") || (empUsedEarnedLeave == null && empUsedEarnedLeave == ""))) {
				employeeSalary.setSick_Leave(String.valueOf(0.0));
				employeeSalary.setUsed_Sick_Leave(String.valueOf(0.0));
				employeeSalary.setEarned_Leave(String.valueOf(0.0));
				employeeSalary.setUsed_Earned_Leave(String.valueOf(0.0));
			}
			int status = iservice.insertSalary(employeeSalary);
			if(status > 0) {
				map.put("MESSAGE", "SUCCESS");
			}else {
				map.put("MESSAGE", "FAILED");
			}	
			String json = gson.toJson(map);
			response.getWriter().print(json);
			// logger.log(Level.INFO, map.get("MESSAGE"));
		} catch (Exception e) {
			// logger.log(Level.ERROR, e);
            e.printStackTrace();
		}
		
	}
	
	@SuppressWarnings("deprecation")
	@RequestMapping("/retrieveSalary")
	public @ResponseBody void retrieveSlaryDetails(@ModelAttribute("salaryDetails") SalaryRetrievalModel salaryDetails, HttpServletResponse response, HttpSession httpSession) {
		try {
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
						BasicSalary = BasicSalary - absenceHourSalary;
						if(empUsedSickLeave != null && empUsedSickLeave != ""){
							if(!empUsedSickLeave.equals("0.0") && !empUsedSickLeave.equals("0")){
								float usedSickLeave = Float.parseFloat(empUsedSickLeave);
								float sickLeaveHours = usedSickLeave * workingHours;
								float sickLeaveHoursSalary = sickLeaveHours * perHourSalary;
								if(sickLeaveHoursSalary == absenceHourSalary){
									BasicSalary = BasicSalary + absenceHourSalary;
								}else{
									absenceHourSalary = absenceHourSalary - sickLeaveHoursSalary;
									BasicSalary = BasicSalary + absenceHourSalary;
								}
							}
						}
						if(empUsedEarnedLeave != null && empUsedEarnedLeave != ""){
							if(!empUsedEarnedLeave.equals("0.0") && !empUsedEarnedLeave.equals("0")){
								System.out.println("Entered");
								float usedEarnedLeave = Float.parseFloat(empUsedEarnedLeave);
								float earnedLeaveHours = usedEarnedLeave * workingHours;
								float earnedLeaveHoursSalary = earnedLeaveHours * perHourSalary;
								if(earnedLeaveHoursSalary == absenceHourSalary){
									BasicSalary = BasicSalary + absenceHourSalary;
								}else{
									absenceHourSalary = absenceHourSalary - earnedLeaveHoursSalary;
									BasicSalary = BasicSalary + absenceHourSalary;
								}
							}
						}/*else if((empUsedSickLeave == null || empUsedSickLeave == "") && (empUsedEarnedLeave == null || empUsedEarnedLeave == "")) {
							BasicSalary = BasicSalary - absenceHourSalary;
						}*/
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
				// logger.log(Level.INFO, multiMap.get("MESSAGE"));
			}
			String json = gson.toJson(multiMap);
			response.getWriter().print(json);
		} catch (Exception e) {
			// logger.log(Level.ERROR, e);
            e.printStackTrace();
		}
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
	public @ResponseBody void sendSalaryMail(@ModelAttribute ("url") SalaryImageModel url, HttpSession httpSession, HttpServletResponse response) {
		try {
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
			String json = gson.toJson(map);
			response.getWriter().print(json);
			// logger.log(Level.INFO, map.get("MESSAGE"));
		} catch (Exception e) {
			// logger.log(Level.ERROR, e);
            e.printStackTrace();
		}
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


	@GetMapping("/checkSession")
	public @ResponseBody void checkSession(HttpServletRequest request ,HttpServletResponse response){
		try {
			Map<String, String> map = new HashMap<String, String>();
			HttpSession httpSession = request.getSession(false);
			if(httpSession == null){
				map.put("MESSAGE", "EXPIRED");
			}else{
				map.put("MESSAGE", "ALIVE");
			}
			String json = gson.toJson(map);
			response.getWriter().print(json);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@GetMapping("/logout")
	public @ResponseBody Object logout(HttpSession httpSession){
		try {
			ModelAndView modelAndView = new ModelAndView();
			httpSession.invalidate();
			modelAndView.setViewName("Login");
			return modelAndView;
		} catch (Exception e) {
			return e.getMessage();
		}
	}

	
}
