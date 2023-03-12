//Course Plannings
LOAD CSV WITH HEADERS FROM 'file:///Course_plannings.csv' AS coursePlannings
RETURN coursePlannings
LIMIT 1;
