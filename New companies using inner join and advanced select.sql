-- USING INNER JOIN 

SELECT c.company_code, founder, COUNT(DISTINCT lead_manager_code), COUNT(DISTINCT  senior_manager_code), COUNT( DISTINCT  manager_code), COUNT(DISTINCT employee_code)
    FROM EMPLOYEE e
    INNER JOIN company c
        on c.company_code = e.company_code
group by company_code,founder
ORDER BY e.company_code;

-- USING ADVANCE SELECT
SELECT c.company_code, c.founder, COUNT(DISTINCT lead_manager_code), COUNT(DISTINCT  senior_manager_code), COUNT( DISTINCT  manager_code), COUNT(DISTINCT employee_code)
FROM EMPLOYEE e, COMPANY c
WHERE
e.company_code = c.company_code
group by company_code,founder
ORDER BY e.company_code;