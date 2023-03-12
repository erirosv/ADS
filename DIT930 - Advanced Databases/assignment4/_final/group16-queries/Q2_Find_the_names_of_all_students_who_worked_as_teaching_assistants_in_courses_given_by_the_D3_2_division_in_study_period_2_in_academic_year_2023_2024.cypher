// Q2. Find the names of all students who worked as teaching assistants in courses given by the D3-2 division in study period 2 in academic year 2023/2024.

MATCH (div:Division {name: "D3-2"})<-[r1:isUnder]-(c:Course)-[r2:isConductedAs]->(ci:CourseInstance {academicYear: "2023-2024", studyPeriod: "2"})
MATCH (ci)-[r3:TimeAssignment]-(s:Student)
RETURN s
ORDER BY s.name ASC