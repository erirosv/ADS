// Create Students
LOAD CSV WITH HEADERS FROM 'file:///Students.csv' AS students
CREATE (student:Individual:Student 
    {
        name: students.studentName, 
        id: students.studentId,
        graduated: toBoolean(students.graduated),
        year: toInteger(students.year)
    }
);