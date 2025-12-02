create database Hospital_Project;

# Read all Data
select * from disease_hospital_map;
select * from hospital_master;
select * from patient_master;
select * from patient_ratings;
select * from visit_record;

# Q1 Show all records from patient_master.
SELECT 
    *
FROM
    patient_master;

#Q2  Show the Name and City of all patients.
SELECT 
    Name, City
FROM
    patient_master;

#Q3 Show all hospitals in Pune. 
SELECT 
    *
FROM
    hospital_master
WHERE
    City = 'Pune';

# Q4 Show diseases treated in each hospital.
SELECT 
    h.HospitalName, d.Disease
FROM
    hospital_master h
        JOIN
    disease_hospital_map d ON h.Specialization = d.Specialization;

# Q5 Count how many patients are from Mumbai
SELECT 
    COUNT(*)
FROM
    patient_master
WHERE
    City = 'Mumbai';

# Q6 List all male patients.
SELECT 
    *
FROM
    patient_master
WHERE
    Gender = 'M';

# Q7 Show hospitals with a rating greater than 4.
SELECT 
    *
FROM
    hospital_master
WHERE
    Rating > 4;

# Q8 Show the total number of hospitals.
SELECT DISTINCT
    COUNT(HospitalID) AS Total_Hospital
FROM
    hospital_master;

# Q9 Show unique diseases from patient_master.
SELECT DISTINCT
    Disease AS Unique_Diasease
FROM
    patient_master;
    
# Q10 ) Show all visits from visit_record.
SELECT 
    *
FROM
    visit_record;
    
# Q11) Show the highest hospital rating.
SELECT 
    *
FROM
    hospital_master
ORDER BY Rating DESC
LIMIT 1;

# Q12) Show the lowest hospital rating.
SELECT 
    *
FROM
    hospital_master
ORDER BY Rating
LIMIT 1;

# Q13) Show all visits happened on a specific date.
SELECT 
    VisitDate, COUNT(*) AS Visit_per_date
FROM
    visit_record
WHERE
    VisitDate = '2024-03-02'
GROUP BY VisitDate;


# Q14) Show the patient details whose PatientID = 10
SELECT 
    *
FROM
    patient_master
WHERE
    PatientID LIKE 'P010';
    
#Q 15) Show hospital names and their cities.
SELECT 
    HospitalName, City
FROM
    hospital_master;


# Q 16) Count patients grouped by city.
SELECT 
    City, COUNT(*)
FROM
    patient_master
GROUP BY City;


# Q 17) Count hospitals by specialization.
SELECT 
    Specialization, COUNT(*)
FROM
    hospital_master
GROUP BY Specialization;


# Q18) Show hospitals that treat ‘Cardiac’ disease (use join).
SELECT 
    h.HospitalName, d.disease
FROM
    hospital_master h
        JOIN
    disease_hospital_map d ON h.Specialization = d.Specialization
WHERE
    d.Specialization LIKE '%Cardiology%';
    

# Q19) Show patients with their visited hospital name.
SELECT 
    p.*, h.HospitalName
FROM
    patient_master p
        JOIN
    visit_record v ON p.PatientID = v.PatientID
        JOIN
    hospital_master h ON v.HospitalID = h.HospitalID;


#Q 20 ) Find patients who visited more than 1 time.
SELECT 
    PatientID, COUNT(VisitID) AS visitcount
FROM
    visit_record
GROUP BY PatientID
HAVING COUNT(VisitID) > 1;


# Q 21) Find hospitals whose rating is between 3 and 5.

SELECT 
    *
FROM
    hospital_master
WHERE
    Rating BETWEEN 3 AND 5;

SELECT 
    *
FROM
    hospital_master
WHERE
    Rating > 3 AND Rating < 5;
    
    
# Q 22) Show the top 5 patients based on age.
SELECT 
    *
FROM
    patient_master
ORDER BY Age DESC
LIMIT 5;


#Q23) Show hospital details along with diseases they treat.
SELECT 
    h.*, d.Disease
FROM
    hospital_master h
        JOIN
    disease_hospital_map d ON h.Specialization = d.Specialization;
    
    
# Q24) Find which disease is most common among patients.
SELECT 
    Disease, COUNT(Disease) AS Disease_count
FROM
    patient_master
GROUP BY Disease
ORDER BY Disease_count DESC
LIMIT 1;


# Q25) Find total bills generated for all visits.
SELECT 
    SUM(TotalBill) AS Total_bill
FROM
    visit_record;
    

# Q 26) Show visit dates along with hospital and patient name.
SELECT 
    p.Name, h.HospitalName, v.VisitDate
FROM
    patient_master p
        JOIN
    visit_record v ON p.PatientID = v.PatientID
        JOIN
    hospital_master h ON h.HospitalID = v.HospitalID;
    
    
# Q 27) Show all hospitals that treat more than 1 diseases.
SELECT 
    h.HospitalName, COUNT(m.Disease) AS disease_count
FROM
    hospital_master h
        JOIN
    disease_hospital_map m ON h.Specialization = m.Specialization
GROUP BY h.HospitalName
HAVING disease_count >1 ;

select * from hospital_master;
# Q 28) List patients who visited a Hospital_20 hospital.
SELECT 
    p.*, h.HospitalName
FROM
    patient_master p
        JOIN
    visit_record v ON p.PatientID = v.PatientID
        JOIN
    hospital_master h ON v.HospitalID = h.HospitalID
    where h.HospitalName = 'Hospital_20';
    
    select * from visit_record;
# Q 29) Show all patient's latest visit.
SELECT 
    p.*, v.VisitDate
FROM
    patient_master p
        JOIN
    visit_record v ON p.PatientId = v.PatientID
ORDER BY VisitDate DESC
LIMIT 10;


# Q 30) Count number of patients by gender.
select Gender, count(Gender) as No_of_Patient from patient_master
group by Gender;

# Q31) Show all patients who have not visited any hospital (LEFT JOIN).
SELECT 
    p.*
FROM
    patient_master p
        left JOIN
    visit_record v ON p.PatientID = v.PatientID
WHERE
    v.VisitID IS NULL;


#Q 32) Show hospitals without any visits.
SELECT 
    h.*
FROM
    hospital_master h
        LEFT JOIN
    visit_record v ON h.HospitalID = v.HospitalID
WHERE
    v.VisitID IS NULL;
    
    
# Q33) Show total visits per hospital.
SELECT 
    h.HospitalName, COUNT(v.VisitId) AS Total_Hospital
FROM
    hospital_master h
        LEFT JOIN
    visit_record v ON h.HospitalID = v.HospitalID
GROUP BY h.HospitalName;


# Q 34) Show records of patients aged between 20 and 40.
SELECT 
    *
FROM
    patient_master
WHERE
    Age BETWEEN 20 AND 40;



# Q 35) Find hospitals in each city (GROUP BY city).
SELECT 
    City, COUNT(HospitalID) AS Total_Hospital
FROM
    hospital_master
GROUP BY City;


# Q 36)  Show top 3 hospitals for each disease (WINDOW FUNCTION).

select * from (select d.Disease,h.HospitalName , h.rating ,
rank() over (partition by d.Disease order by h.rating desc) as h_rank
from hospital_master h join disease_hospital_map d 
on h.Specialization = d.Specialization) as t
where h_rank <=3;


# Q37)  Show total revenue earned by each hospital.

SELECT 
    h.HospitalName, SUM(v.TotalBill) AS Revenue
FROM
    hospital_master h
        JOIN
    visit_record v ON h.HospitalID = v.HospitalID
GROUP BY HospitalName;


# Q 38) Find which hospital has the maximum number of visits.
 SELECT 
    h.HospitalName, COUNT(v.VisitID) AS Max_visit
FROM
    hospital_master h
        JOIN
    visit_record v ON h.HospitalID = v.HospitalID
GROUP BY HospitalName
ORDER BY Max_visit DESC
LIMIT 1;


# Q 39 Find which hospital earns the highest revenue.

SELECT 
    h.HospitalName, SUM(v.TotalBill) AS Revenue
FROM
    hospital_master h
        JOIN
    visit_record v ON h.HospitalID = v.HospitalID
GROUP BY HospitalName
ORDER BY Revenue DESC
LIMIT 1;


# Q40) Find the average bill amount per disease.

SELECT 
    p.Disease, AVG(v.TotalBill) AS Avg_Bill
FROM
    patient_master p
        JOIN
    visit_record v ON p.PatientID = v.PatientID
GROUP BY p.Disease;


# Q41 ) Show patient’s full visit history with hospital rating.
SELECT 
    p.Name, v.*, h.HospitalName, h.rating
FROM
    hospital_master h
        JOIN
    visit_record v ON h.HospitalID = v.HospitalID
        JOIN
    patient_master p ON p.PatientID = v.PatientID;
    
#Q 42) Detect patients who visited multiple hospitals.

SELECT 
    p.PatientID, p.Name, COUNT(v.HospitalID)
FROM
    patient_master p
        JOIN
    visit_record v ON p.PatientID = v.PatientID
GROUP BY p.PatientID , p.Name
HAVING COUNT(v.HospitalID) > 1;

# Q43) For each city, show the best-rated hospital. 
select * from (select City,Rating,
rank() over(partition by City order by rating desc) as h_rank
from  hospital_master) as t
where h_rank= 1;


# Q 44) Show diseases ranked by number of patients (RANK()).
select Disease , count(PatientID)as Total_patient,
Rank()over(order by count(PatientID)desc)as top_rank
from patient_master
group by Disease;

# Q 45) Show hospitals ranked by revenue.
select h.HospitalName,sum(v.TotalBill),
rank()over(order by sum(v.TotalBill) desc) as top_revenue
 from hospital_master h join visit_record v
on h.HospitalID = v.HospitalID
group by h.HospitalName;

# Q 46) Show patient count growth month-wise (DATE functions). 
SELECT 
    MONTH(VisitDate) AS VisitMonth,
    COUNT(PatientID) AS Patient_count
FROM
    visit_record
GROUP BY MONTH(VisitDate)
ORDER BY VisitMonth;


# Q47) Find which specialization has the highest rated hospitals.
select Specialization, max(Rating)as Ratings from hospital_master
group by Specialization
order by Ratings 
limit 1;


# Q 48) Show the hospital that treats most diseases, with count.
select h.HospitalName, count(d.Disease)as Disease_count from hospital_master h join disease_hospital_map d 
on h.Specialization = d.Specialization
group by h.HospitalName
order by Disease_count desc
limit 1;

# Q 49) Identify patients who always visit the same hospital.

SELECT 
    v.PatientID,
    COUNT(DISTINCT v.HospitalID) AS UniqueHospitals
FROM visit_record v
GROUP BY v.PatientID
HAVING COUNT(DISTINCT v.HospitalID) = 1;


# Q 50) Create a VIEW that shows patient name, hospital name, visit date, bill amount.
CREATE VIEW patient_details AS
    SELECT 
        P.Name, h.HospitalName, v.VisitDate, v.TotalBill
    FROM
        patient_master p
            JOIN
        visit_record v ON p.PatientID = v.PatientID
            JOIN
        hospital_master h ON v.HospitalID = h.HospitalID;


select * from patient_details;

# Q 51) Show top 2 hospitals in each city.
WITH ranked_hospitals AS (
    SELECT 
        HospitalName,
        City,
        Rating,
        ROW_NUMBER() OVER (PARTITION BY City ORDER BY Rating DESC) AS rnk
    FROM hospital_master
)
SELECT *
FROM ranked_hospitals
WHERE rnk <= 2;

select p.disease, avg(v.TotalBill) as AvgBill from patient_master p join visit_record v 
on p.PatientID = v.PatientID
group by p.Disease;


# Patient Count per city
select City, count(patientID)as Patient_Count from patient_master
group by City;