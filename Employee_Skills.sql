Create DataBase SkillsDevelopmentDB;
Use SkillsDevelopmentDB;

--This stores information about the employees
Create Table Employees(
EmployeeID Int Primary Key not null,
EmployeeFullName Varchar(50) not null,
Department varchar(50),
JobRole Varchar(50),
HireDate Date);

--Contains the Technologies
Create Table Skills(
SkillID Int Primary Key not null,
SkillName Varchar(50),
SkillCategory varchar(50));

--Tells Us Which Employee has Which Skill and their Proficiency
Create Table EmployeeSkills(
EmployeeSkillID Int Primary Key,
EmployeeID Int,
SkillID Int,
ProficiencyLevel varchar(30),
YearsExperience Int,

Foreign Key (EmployeeID) References Employees(EmployeeID),
Foreign Key (SkillID) References Skills(SkillID)
);

--Records Employees moving from one tool to another
Create Table SkillTransitions(
TransitionID Int Primary key,
EmployeeId int,
FromSkillID int,
ToSkillID int,
TransiyionDate Date,
Reason Varchar(100),
TrainingStatus Varchar(30),

Foreign Key (EmployeeID) References Employees(EmployeeID),
Foreign Key (FromSkillID) References  Skills(SkillID),
Foreign Key (ToSkillID) References  Skills(SkillID));

select * from Employees;
select * from Skills;
select * from EmployeeSkills;
select * from SkillTransitions;

INSERT INTO Employees
(EmployeeID, EmployeeFullName, Department, JobRole, HireDate)
VALUES (101, 'Thabo Mokoena', 'Finance', 'Financial Analyst', '2021-03-15'),
(102, 'Ayanda Ndlovu', 'Marketing', 'Marketing Analyst', '2022-06-10'),
(103, 'Lerato Dlamini', 'IT', 'Data Analyst', '2020-01-20'),
(104, 'Sipho Khumalo', 'Operations', 'Business Analyst', '2023-02-14'),
(105, 'Zanele Mthembu', 'Finance', 'Data Analyst', '2021-08-01'),
(106, 'Sibusiso Naidoo', 'IT', 'Systems Analyst', '2019-11-05'),
(107, 'Nomsa Cele', 'Marketing', 'Business Analyst', '2022-09-18'),
(108, 'Bongani Zulu', 'Operations', 'Data Analyst', '2023-04-12'),
(109, 'Nandi Mkhize', 'Finance', 'Reporting Analyst', '2020-07-22'),
(110, 'Lunga Sithole', 'IT', 'Data Engineer', '2019-05-30');

INSERT INTO Skills (SkillID, SkillName, SkillCategory) 
VALUES (1, 'Excel', 'Data Analysis'),
(2, 'SQL', 'Database'),
(3, 'Power BI', 'Business Intelligence'),
(4, 'Python', 'Programming'),
(5, 'Tableau', 'Business Intelligence'),
(6, 'Azure', 'Cloud'),
(7, 'R', 'Programming');

INSERT INTO EmployeeSkills (EmployeeSkillID, EmployeeID, SkillID, ProficiencyLevel, YearsExperience)
VALUES (1, 101, 1, 'Advanced', 4.0),
(2, 101, 3, 'Intermediate', 2.0),
(3, 102, 1, 'Advanced', 3.0),
(4, 102, 2, 'Intermediate', 1.5),
(5, 103, 2, 'Advanced', 5.0),
(6, 103, 4, 'Intermediate', 2.0),
(7, 104, 1, 'Intermediate', 2.0),
(8, 104, 3, 'Intermediate', 1.5),
(9, 105, 1, 'Advanced', 4.0),
(10, 105, 2, 'Advanced', 3.0),
(11, 105, 3, 'Advanced', 2.5),
(12, 106, 2, 'Advanced', 6.0),
(13, 106, 6, 'Intermediate', 2.0),
(14, 107, 1, 'Intermediate', 2.0),
(15, 107, 5, 'Beginner', 1.0),
(16, 108, 1, 'Intermediate', 2.0),
(17, 108, 2, 'Intermediate', 1.5),
(18, 108, 4, 'Beginner', 0.5),
(19, 109, 1, 'Advanced', 5.0),
(20, 109, 3, 'Intermediate', 2.0),
(21, 110, 2, 'Advanced', 6.0),
(22, 110, 4, 'Advanced', 4.0),
(23, 110, 6, 'Advanced', 3.0);

INSERT INTO SkillTransitions (TransitionID, EmployeeID, FromSkillID, ToSkillID, TransiyionDate, Reason, TrainingStatus)
VALUES (1, 101, 1, 3, '2024-02-15', 'Career Development', 'Completed'),
(2, 102, 1, 2, '2024-04-10', 'Data Analysis', 'Completed'),
(3, 103, 2, 4, '2024-06-20', 'Automation', 'Completed'),
(4, 104, 1, 3, '2024-08-05', 'Reporting', 'Completed'),
(5, 105, 1, 2, '2024-03-12', 'Database Skills', 'Completed'),
(6, 105, 2, 3, '2024-09-18', 'Business Intelligence', 'Completed'),
(7, 106, 2, 6, '2024-05-25', 'Cloud Development', 'In Progress'),
(8, 107, 1, 5, '2024-07-15', 'Data Visualization', 'Completed'),
(9, 108, 1, 2, '2025-01-10', 'Data Management', 'Completed'),
(10, 108, 2, 4, '2025-06-05', 'Automation', 'In Progress'),
(11, 109, 1, 3, '2025-02-20', 'Dashboard Development', 'Completed'),
(12, 110, 2, 4, '2025-03-15', 'Advanced Analytics', 'Completed'),
(13, 110, 4, 6, '2025-08-10', 'Cloud Analytics', 'In Progress');

EXEC sp_rename 'skillTransitions.TransiyionDate','TransitionDate','COLUMN';

--Employees in each Department
SELECT 
    Department,
    COUNT(*) AS TotalEmployees
FROM Employees
GROUP BY Department
ORDER BY TotalEmployees DESC;

--count how many Emplooyees have each skill
SELECT
    s.SkillName,
    COUNT(es.EmployeeID) AS NumberOfEmployees
FROM Skills s
JOIN EmployeeSkills es
    ON s.SkillID = es.SkillID
GROUP BY s.SkillName
ORDER BY NumberOfEmployees DESC;

--The Avarage Experience for each skill
SELECT
    s.SkillName,
    AVG(es.YearsExperience) AS AverageExperience
FROM Skills s
JOIN EmployeeSkills es
    ON s.SkillID = es.SkillID
GROUP BY s.SkillName
ORDER BY AverageExperience DESC;

--Tools employees are moving From and To
SELECT
    fs.SkillName AS FromTool,
    ts.SkillName AS ToTool,
    COUNT(*) AS NumberOfTransitions
FROM SkillTransitions st
JOIN Skills fs
    ON st.FromSkillID = fs.SkillID
JOIN Skills ts
    ON st.ToSkillID = ts.SkillID
GROUP BY
    fs.SkillName,
    ts.SkillName
ORDER BY NumberOfTransitions DESC;

--How many employees are at each Proficiency level?
SELECT
    ProficiencyLevel,
    COUNT(*) AS NumberOfEmployees
FROM EmployeeSkills
GROUP BY ProficiencyLevel
ORDER BY NumberOfEmployees DESC;

--Proficiency by tool
SELECT
    s.SkillName,
    es.ProficiencyLevel,
    COUNT(*) AS NumberOfEmployees
FROM Skills s
JOIN EmployeeSkills es
    ON s.SkillID = es.SkillID
GROUP BY
    s.SkillName,
    es.ProficiencyLevel
ORDER BY
    s.SkillName,
    NumberOfEmployees DESC;

--
SELECT
    s.SkillName,
    es.ProficiencyLevel,
    CASE
        WHEN es.ProficiencyLevel = 'Beginner' THEN 1
        WHEN es.ProficiencyLevel = 'Intermediate' THEN 2
        WHEN es.ProficiencyLevel = 'Advanced' THEN 3
    END AS SkillScore
FROM Skills s
JOIN EmployeeSkills es
    ON s.SkillID = es.SkillID;

-- which transition have been completed?
SELECT
    fs.SkillName AS FromTool,
    ts.SkillName AS ToTool,
    COUNT(*) AS CompletedTransitions
FROM SkillTransitions st
JOIN Skills fs
    ON st.FromSkillID = fs.SkillID
JOIN Skills ts
    ON st.ToSkillID = ts.SkillID
WHERE st.TrainingStatus = 'Completed'
GROUP BY
    fs.SkillName,
    ts.SkillName
ORDER BY CompletedTransitions DESC;

--Which department have the most skill transitions?
SELECT
    e.Department,
    COUNT(st.TransitionID) AS TotalTransitions
FROM Employees e
JOIN SkillTransitions st
    ON e.EmployeeID = st.EmployeeID
GROUP BY e.Department
ORDER BY TotalTransitions DESC;

-- which employees have more than the average years of experience 
select 
e.EmployeeFullName, es.YearsExperience
from Employees e 
join EmployeeSkills es on e.EmployeeID = es.EmployeeID
where es.YearsExperience>(Select AVG(YearsExperience)
from EmployeeSkills)
Order by es.YearsExperience DESc;

--Which Skills have more employees than the average number of employees per skill
Select s.Skillname, Count(es.EmployeeID) as NumberOfEmployees
from Skills s 
join EmployeeSkills es on s.SkillID =es.SkillID
group by s.skillName 
having count(es.EmployeeID) > (select Avg(SkillCount)
from (Select count(*) as SkillCount
from EmployeeSkills Group by SkillID ) as SkillCount)
Order by NumberOfEmployees DESC;

-- employyes skill transition with their department
With TransitionDetails as (
Select 
st.transitionID,
st.EmployeeID,
st.fromSkillID,
st.ToSkillID,
st.TransitionDate,
st.Trainingstatus
From SkillTransitions st)

select 
e.EmployeeFullName,
e.Department,
fs.SkillName as FromTool,
ts.SkillName as ToTool,
td.TransitionDate,
td.TrainingStatus

From TransitionDetails td
join Employees e
on td.EmployeeID =e.EmployeeID 
Join Skills fs 
on td.FromSkillID = fs.SkillID
join Skills ts 
on td.toSkillID = ts.SkillID 
order by td.TransitionDate;

--The most common transition
SELECT TOP 1
    fs.SkillName AS FromTool,
    ts.SkillName AS ToTool,
    COUNT(*) AS NumberOfTransitions
FROM SkillTransitions st
JOIN Skills fs
    ON st.FromSkillID = fs.SkillID
JOIN Skills ts
    ON st.ToSkillID = ts.SkillID
GROUP BY
    fs.SkillName,
    ts.SkillName
ORDER BY NumberOfTransitions DESC;