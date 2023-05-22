create table EMPLOYEES(
sl_no serial not null,
Employee_Id character(255) not null primary key,
FirstName character(255) not null,
LastName character(255) not null,
Gender character(10) not null,
DateofBirth Date not null,
Address character(255) not null,
Email_Id character(255) not null,
ContactNumber character(15) not null,
Batch character(5) not null,
DateofJoining Date not null,
DateofLeaving Date,
Department_Id character(25) not null,
Department_Name character(255) not null,
Designation_Id character(25) not null,
Designation_Name character(255) not null,
Bank_Name character(255) not null,
AccountNumber character(35) not null,
PfAccountNumber character(40) not null,
PAN character(25) not null,
Discontinued integer
);

drop table SALARY;

create table DEPARTMENTS(
Department_Id character(25) not null primary key,
Department_Name character(255) not null
);


create table DESIGNATIONS(
Designation_Id character(25) not null primary key,
Designation_Name character(255) not null
);


create table SALARY(
Salary_Employee_Id character(25) not null,
Salary_Month character(25) not null,
Salary_Year character(25) not null,
Basic_Salary character(25) not null,
Worked_Days character(25) not null,
Sick_Leave character(25),
Used_Sick_Leave character(25),
Earned_Leave character(25),
Used_Earned_Leave character(25),
primary key(Salary_Employee_Id, Salary_Month, Salary_Year)
);


insert into DEPARTMENTS(Department_Id, Department_Name) values('DEP10', 'PD-1'),('DEP11', 'PD-2'), 
('DEP12', 'Product/R&D');


insert into DESIGNATIONS(Designation_Id, Designation_Name)
values('DES10', 'Project Manager'),
('DES11', 'Project Leader'),
('DES12', 'Senior Software Engineer'),
('DES13', 'Junior Software Engineer'),
('DES14', 'Trainee Software Engineer');