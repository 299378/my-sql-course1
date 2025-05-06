SELECT MAX(N) from Tally 

SELECT COUNT(*) from Tally

SELECT min(N) from Tally 

-- Here is a simple, but not good, way to build a Dates table for 2024
SELECT
    t.N AS DayOfYear
    ,DATEADD(DAY, t.N, '2023-12-31') AS TheDate
FROM
    Tally t WHERE N <=366
order by 1
 
-- A better approach is to use SQL variables to set the start and end dates
DECLARE @StartDate DATE;
DECLARE @EndDate DATE;
SELECT @StartDate = DATEFROMPARTS(2024, 1, 1);
SELECT  @EndDate = DATEFROMPARTS(2024, 12, 31);
DECLARE @NumberOfDays INT = DATEDIFF(DAY, @StartDate, @EndDate) + 1;
SELECT @NumberOfDays AS NumberOfDays;

SELECT
    DATEADD(DAY, N-1, @StartDate) AS Date
FROM
    Tally
WHERE
    N <= @NumberOfDays
ORDER BY Date


/*
 Tally Tables Exercise
 
 The temporary table, #PatientAdmission has columns AdmittedDate and NumAdmissions
 It has values for dates between the 1st and 8th January inclusive but not all dates are present
 
 List the dates that have no patient admissions
 
 There is a tally table, named Tally, with a column N that has values from 1 to 10,000.
 */
 
DROP TABLE IF EXISTS #PatientAdmission;
 
CREATE TABLE #PatientAdmission (AdmittedDate DATE, NumAdmissions INT);
 
INSERT INTO #PatientAdmission (AdmittedDate, NumAdmissions) VALUES ('2024-01-01', 5)
INSERT INTO #PatientAdmission (AdmittedDate, NumAdmissions) VALUES ('2024-01-02', 6)
INSERT INTO #PatientAdmission (AdmittedDate, NumAdmissions) VALUES ('2024-01-03', 4)
INSERT INTO #PatientAdmission (AdmittedDate, NumAdmissions) VALUES ('2024-01-05', 2)
INSERT INTO #PatientAdmission (AdmittedDate, NumAdmissions) VALUES ('2024-01-08', 2)
 
SELECT * FROM #PatientAdmission

SELECT
    t.N AS DayOfYear
    ,DATEADD(DAY, t.N, '2023-12-31') AS TheDate
    ,pa.admittedDate
    ,    pa.NumAdmissions
    FROM Tally t LEFT JOIN #PatientAdmission pa
    ON DATEADD(DAY, t.N, '2023-12-31') = pa.AdmittedDate
    WHERE N <= 8
    AND pa.AdmittedDate IS NULL
    ORDER BY 1
