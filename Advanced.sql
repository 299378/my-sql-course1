SELECT
    ps.PatientId
    ,ps.AdmittedDate
    ,ps.Hospital
    , ps.Tariff
    , (Select SUM(Tariff) from patientstay subq WHERE subq.PatientId <= ps.PatientId and subq.hospital = ps.Hospital) as CumulativeTariff
    , (Select count(*) from patientstay subq WHERE subq.PatientId <= ps.PatientId and subq.hospital = ps.Hospital) as PATIENTINDEX
FROM
    PatientStay ps
ORDER BY ps.Hospital, ps.PatientId


