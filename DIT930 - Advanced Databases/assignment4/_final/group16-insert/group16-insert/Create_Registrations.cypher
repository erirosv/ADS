// Create Registrations
LOAD CSV WITH HEADERS FROM 'file:///Registrations.csv' AS registrations
MATCH (student:Individual {id: registrations.studentId})
MATCH (ci:CourseInstance {name: registrations.courseInstance})
MERGE (student)-[reg:Registration]->(ci)
SET reg.grade= registrations.grade, 
    reg.status= registrations.status