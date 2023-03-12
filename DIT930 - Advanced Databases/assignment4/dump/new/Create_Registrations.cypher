// Create Registrations
LOAD CSV WITH HEADERS FROM 'file:///Registrations.csv' AS registrations
MATCH (student:Individual {id: registrations.studentId})
MATCH (ci:CourseInstance {name: registrations.courseInstance})
MERGE (student)-[reg:Registration 
    {grade: registrations.grade, status: registrations.status}]->(ci)