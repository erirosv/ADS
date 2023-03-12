//[*] Run all insert queries
 
// Create Students
LOAD CSV WITH HEADERS FROM 'file:///Students.csv' AS students
CREATE (s1:Individual:Student{name: students.studentName, id: students.studentId, graduated: toBoolean(students.graduated), year: toInteger(students.year)});
 
// Create Divisions and Departments
LOAD CSV WITH HEADERS FROM 'file:///Senior_Teachers.csv' AS divdept1
MERGE (div1:Division {name: divdept1.division})
WITH divdept1, div1
MERGE (dept1:Department {name: divdept1.department})
WITH div1, dept1
MERGE (div1)-[:isPartOf]->(dept1);

LOAD CSV WITH HEADERS FROM 'file:///Teaching_Assistants.csv' AS divdept2
MERGE (div2:Division {name: divdept2.division})
WITH divdept2, div2
MERGE (dept2:Department {name: divdept2.department})
WITH div2, dept2
MERGE (div2)-[:isPartOf]->(dept2);
 
// Create Teaching Staff
// Senior Teachers
LOAD CSV WITH HEADERS FROM 'file:///Senior_Teachers.csv' AS seniorTeachers
MATCH (div3:Division {name: seniorTeachers.division})
MERGE (div3)<-[:isWorkingFor]-(st1:Individual:TeachingStaff:SeniorTeacher{ name: seniorTeachers.teacherName, id: seniorTeachers.teacherId});
 
// Teaching Assistants
LOAD CSV WITH HEADERS FROM 'file:///Teaching_Assistants.csv' AS teachingAssistants
MATCH (div4:Division {name: teachingAssistants.division})
MATCH (ta1:Individual {name: teachingAssistants.teacherName, id: teachingAssistants.teacherId})
MERGE (div4)<-[:isWorkingFor]-(ta1)
SET ta1:TeachingStaff:TeachingAssistant;
 
// Create Programmes
LOAD CSV WITH HEADERS FROM 'file:///Programmes.csv' AS programmes
MATCH (director:Individual {id: programmes.director})
MATCH (dept3:Department {name: programmes.department})
MERGE (dept3)-[:isOffering]->(prog1:Programme {name:programmes.programmeName, id:programmes.programme})-[:hasDirector]->(director);

// Create Courses
LOAD CSV WITH HEADERS FROM 'file:///Courses.csv' AS courses
MATCH (prog2:Programme {name: courses.ownedBy})
MATCH (div5:Division {name: courses.division})
MERGE (div5)<-[:isUnder]-(c1:Course {name: courses.courseName, courseCode: courses.courseCode, level: courses.level, credits: courses.credits})-[:ownedBy]->(prog2);

// Create Programme Courses
LOAD CSV WITH HEADERS FROM 'file:///Programme_Courses.csv' AS programmeCourses
MATCH (prog3:Programme {id: programmeCourses.programme})
MATCH (c2:Course {courseCode: programmeCourses.courseCode})
MERGE (c2)<-[:isBelongingTo]-(pc1:ProgrammeCourses {studyYear: programmeCourses.studyYear, courseType: programmeCourses.courseType, academicYear: programmeCourses.academicYear})<-[:isProviding]-(prog3);
 
// Create Course Instances
LOAD CSV WITH HEADERS FROM 'file:///Course_Instances.csv' AS courseInstances
MATCH (examiner:SeniorTeacher {id: courseInstances.examiner})
MATCH (c3:Course {courseCode: courseInstances.courseCode})
MERGE (examiner)-[:isExamining]->(ci1:CourseInstance {name: courseInstances.courseInstance, studyPeriod: courseInstances.studyPeriod, academicYear: courseInstances.academicYear})<-[:isConductedAs]-(c3);
 
// Insert CoursePlannings into CourseInstances
LOAD CSV WITH HEADERS FROM 'file:///Course_plannings.csv' AS coursePlannings
MATCH (ci2:CourseInstance {name: coursePlannings.courseInstance})
SET ci2.assistantHours = coursePlannings.assistantHours,
ci2.seniorHours = coursePlannings.seniorHours,
ci2.plannedNumStudents = coursePlannings.plannedNumStudent;

// Insert Students into Programmes
LOAD CSV WITH HEADERS FROM 'file:///Students.csv' AS students
MATCH (prog4:Programme {id:students.programme})
MATCH (s2:Individual {id:students.studentId})
MERGE (prog4)<-[:isEnrolledIn]-(s2);

// Create TimeAssignment
LOAD CSV WITH HEADERS FROM 'file:///TimeAssignment.csv' AS timeAss
MATCH (teacher:Individual {id: timeAss.teacherId})
MATCH (ci3:CourseInstance {name: timeAss.courseInstance})
MERGE (teacher)-[tass1:TimeAssignment{reportedHours: timeAss.reportedHours, assignedHours: timeAss.assignedHours}]->(ci3);
 
// Create Registrations
LOAD CSV WITH HEADERS FROM 'file:///Registrations.csv' AS registrations
MATCH (s3:Individual {id: registrations.studentId})
MATCH (ci4:CourseInstance {name: registrations.courseInstance})
MERGE (s3)-[reg:Registration]->(ci4)
SET reg.grade= registrations.grade,
reg.status= registrations.status;
