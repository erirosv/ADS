// Courses
LOAD CSV WITH HEADERS FROM 'file:///Courses.csv' AS courses
RETURN courses
LIMIT 1;
