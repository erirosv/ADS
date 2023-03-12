//Course Instances
LOAD CSV WITH HEADERS FROM 'file:///Course_Instances.csv' AS courseIntances
RETURN courseIntances
LIMIT 1;
