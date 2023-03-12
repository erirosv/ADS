// Create TimeAssignment
LOAD CSV WITH HEADERS FROM 'file:///TimeAssignment.csv' AS timeAss
MATCH (teacher:Individual {id: timeAss.teacherId})
MATCH (ci:CourseInstance {name: timeAss.courseInstance})
MERGE (teacher)-[ta:TimeAssignment{reportedHours: timeAss.reportedHours, assignedHours: timeAss.assignedHours}]->(ci)
