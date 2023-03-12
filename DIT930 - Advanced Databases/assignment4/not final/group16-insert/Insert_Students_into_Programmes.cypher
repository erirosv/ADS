// Insert Students into Programmes
LOAD CSV WITH HEADERS FROM 'file:///Students.csv' AS students
MATCH (prog:Programme {id:students.programme})
MATCH (s:Individual {id:students.studentId})
MERGE (prog)<-[r:isEnrolledIn]-(s);