// Create Teaching Staff

// Senior Teachers
LOAD CSV WITH HEADERS FROM 'file:///Senior_Teachers.csv' AS seniorTeachers
MATCH (div:Division {name: seniorTeachers.division})
MERGE (div)<-[k:isWorkingFor]-(st:Individual:TeachingStaff:SeniorTeacher{name: seniorTeachers.teacherName, id: seniorTeachers.teacherId});

// Teaching Assistants
LOAD CSV WITH HEADERS FROM 'file:///Teaching_Assistants.csv' AS teachingAssistants
MATCH (div:Division {name: teachingAssistants.division})
MATCH (ta:Individual {name: teachingAssistants.teacherName, id: teachingAssistants.teacherId})
MERGE (div)<-[k:isWorkingFor]-(ta)
SET ta:TeachingStaff:TeachingAssistant