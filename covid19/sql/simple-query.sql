SELECT
  date,
  location,
  iso_code,
  new_cases_smoothed,
  new_cases_smoothed_per_million
FROM
  covid19
WHERE
  continent <> ''
  AND (new_cases_smoothed_per_million <> '' OR new_cases_smoothed_per_million <> null)
  AND iso_code = 'USA'
GROUP BY
  date, location, iso_code, new_cases_smoothed, new_cases_smoothed_per_million
ORDER BY
  date ASC;
