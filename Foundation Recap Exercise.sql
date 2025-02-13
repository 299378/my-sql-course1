/*
Foundation Recap Exercise

Use the table PatientStay.  
This lists 44 patients admitted to London hospitals over 5 days between Feb 26th and March 2nd 2024
*/

SELECT
	*
FROM
	PatientStay ps
;

/*
1. List the patients -
a) in the Oxleas or PRUH hospitals and
b) admitted in February 2024
c) only the Surgery wards

2. Show the PatientId, AdmittedDate, DischargeDate, Hospital and Ward columns only, not all the columns.
3. Order results by AdmittedDate (latest first) then PatientID column (high to low)
4. Add a new column LengthOfStay which calculates the number of days that the patient stayed in hospital, inclusive of both admitted and discharge date.
*/

-- Write the SQL statement here
SELECT
	ps.PatientId
	,ps.AdmittedDate
	,ps.DischargeDate
	,ps.Ward
	,ps.Hospital
	,DATEDIFF(DAY, ps.AdmittedDate, ps.DischargeDate) + 1 AS LengthOfStay
FROM
	PatientStay ps
WHERE ps.Hospital IN ('Oxleas', 'PRUH')
	--AND MONTH(ps.AdmittedDate) = 2
	AND ps.AdmittedDate BETWEEN '2024-02-01' AND '2024-02-29'
	--AND ps.AdmittedDate >= '2024-02-01'
	--AND ps.AdmittedDate <= '2024-02-29'
	AND PS.Ward LIKE '%Surgery'
ORDER BY ps.AdmittedDate DESC, ps.PatientId DESC


--test date functions 
SELECT
	month ('2024-02-13') AS MyMonth
SELECT
	DATEPART(MM, 2024-02-13)
SELECT
	DATENAME(MM, '2024-02-13')

SELECT
	LEFT(DATENAME(MM, '2024-02-13'),3) AS Month

/*
5. How many patients has each hospital admitted? 
6. How much is the total tarriff for each hospital?
7. List only those hospitals that have admitted over 10 patients
8. Order by the hospital with most admissions first
*/

-- Write the SQL statement here

SELECT
	ps.hospital
	,count (*) AS [NumberOfPatients]
	,SUM(ps.Tariff) AS TotalTariff
FROM
	PatientStay ps
GROUP BY ps.Hospital
HAVING SUM(ps.Tariff) >50
ORDER BY SUM(ps.tariff) DESC

SELECT* from DimHospitalBad h

SELECT
	ps.PatientId
    ,ps.AdmittedDate
	,h.Hospital
	,ps.Hospital
	,h.Type
	,ps.Ethnicity
FROM
	PatientStay ps FULL OUTER JOIN DimHospitalBad h ON ps.Hospital=h.Hospital
	WHERE ps.Ethnicity is NULL


	SELECT
    ps.PatientId
    ,ps.AdmittedDate
    ,ps.DischargeDate
    ,ps.Ward
    ,ps.Hospital
    ,DATEDIFF(DAY, ps.AdmittedDate, ps.DischargeDate) + 1 AS LengthOfStay
SELECT
    CASE
        WHEN ps.Tariff >= 7 THEN 'High Cost'
        WHEN ps.Tariff >= 4 THEN 'Medium Cost'
        ELSE 'Low Cost' END AS CostType
		,COUNT(*) as [Number of Patients]
		,SUM(ps.Tariff) as [Total cost]
FROM
    PatientStay ps
	WHERE CASE
        WHEN ps.Tariff >= 7 THEN 'High Cost'
        WHEN ps.Tariff >= 4 THEN 'Medium Cost'
        ELSE 'Low Cost' END IN ('High cost', 'Low cost')
GROUP BY CASE
        WHEN ps.Tariff >= 7 THEN 'High Cost'
        WHEN ps.Tariff >= 4 THEN 'Medium Cost'
        ELSE 'Low Cost' END
;

--adding cte- grouping to make it simpler
WITH
	cte
	AS
	(
		SELECT
			CASE
        WHEN ps.Tariff >= 7 THEN 'High Cost'
        WHEN ps.Tariff >= 4 THEN 'Medium Cost'
        ELSE 'Low Cost' END AS CostType
		,ps.Tariff
		FROM
			PatientStay ps
	)
SELECT
	cte.CostType
	,count(*) AS NumPatients
	,SUM(cte.Tariff) AS TotalTariff
FROM
	cte
WHERE cte.CostType IN ('High Cost', 'Low Cost')
GROUP BY cte.CostType


