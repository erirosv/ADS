//All CSVs
LOAD CSV WITH HEADERS FROM 'file:///Students.csv' AS students
LOAD CSV WITH HEADERS FROM 'file:///Teaching_Assistants.csv' AS teachingAssistants
LOAD CSV WITH HEADERS FROM 'file:///Senior_Teachers.csv' AS seniorTeachers
LOAD CSV WITH HEADERS FROM 'file:///Programmes.csv' AS programmes
LOAD CSV WITH HEADERS FROM 'file:///Courses.csv' AS courses
LOAD CSV WITH HEADERS FROM 'file:///Programme_Courses.csv' AS programmeCourses
LOAD CSV WITH HEADERS FROM 'file:///Course_Instances.csv' AS courseIntances
LOAD CSV WITH HEADERS FROM 'file:///Course_plannings.csv' AS coursePlannings
LOAD CSV WITH HEADERS FROM 'file:///Registrations.csv' AS registrations
LOAD CSV WITH HEADERS FROM 'file:///Assigned_Hours.csv' AS assignedHours
LOAD CSV WITH HEADERS FROM 'file:///Reported_Hours.csv' AS reportedHours
RETURN students;


// Create Course Instances
LOAD CSV WITH HEADERS FROM 'file:///Course_Instances.csv' AS courseInstances
MATCH (examiner:SeniorTeacher {id: courseInstances.examiner})
MATCH (course:Course {courseCode: courseInstances.courseCode})
MERGE (examiner)-[r:isExamining]->(ci:CourseInstance
    {
        name: courseInstances.courseInstance,
        studyPeriod: courseInstances.studyPeriod, 
        academicYear: courseInstances.academicYear
    }
)<-[k:isConductedAs]-(course);

// Insert CoursePlannings into CourseInstances
LOAD CSV WITH HEADERS FROM 'file:///Course_plannings.csv' AS coursePlannings
MATCH (ci:CourseInstance {name: coursePlannings.courseInstance})
SET ci.assistantHours = coursePlannings.assistantHours,
    ci.seniorHours = coursePlannings.seniorHours,
    ci.plannedNumStudents = coursePlannings.plannedNumStudent

// Create Courses
LOAD CSV WITH HEADERS FROM 'file:///Courses.csv' AS courses
MATCH (prog:Programme {name: courses.ownedBy})
MATCH (div:Division {name: courses.division})
MERGE (div)<-[k:isUnder]-(c:Course
    {
        name: courses.courseName, 
        courseCode: courses.courseCode,
        level: courses.level,
        credits: courses.credits
    }
)-[r:ownedBy]->(prog)

// Create Divisions and Departments
LOAD CSV WITH HEADERS FROM 'file:///Senior_Teachers.csv' AS row2
MERGE (div2:Division {name: row2.division})
WITH row2, div2
MERGE (dept2:Department {name: row2.department})
WITH div2, dept2
MERGE (div2)-[k2:isPartOf]->(dept2);

LOAD CSV WITH HEADERS FROM 'file:///Teaching_Assistants.csv' AS row
MERGE (div:Division {name: row.division})
WITH row, div
MERGE (dept:Department {name: row.department})
WITH div, dept
MERGE (div)-[k:isPartOf]->(dept);

// Create Programme Courses
LOAD CSV WITH HEADERS FROM 'file:///Programme_Courses.csv' AS programmeCourses
MATCH (prog:Programme {id: programmeCourses.programme})
MATCH (course:Course {courseCode: programmeCourses.courseCode})
MERGE (course)<-[k:isBelongingTo]-(pc:ProgrammeCourses
    {
        studyYear: programmeCourses.studyYear, 
        courseType: programmeCourses.courseType,
        academicYear: programmeCourses.academicYear
    }
)<-[r:isProviding]-(prog)

// Create Programmes
LOAD CSV WITH HEADERS FROM 'file:///Programmes.csv' AS programmes
MATCH (d:Individual {id: programmes.director}) 
MATCH (dept:Department {name: programmes.department})
MERGE (dept)-[k:isOffering]->(prog:Programme {name:programmes.programmeName, id:programmes.programme})-[r:hasDirector]->(d)

// Create Registrations
LOAD CSV WITH HEADERS FROM 'file:///Registrations.csv' AS registrations
MATCH (student:Individual {id: registrations.studentId})
MATCH (ci:CourseInstance {name: registrations.courseInstance})
MERGE (student)-[reg:Registration 
    {grade: registrations.grade, status: registrations.status}]->(ci)

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

// Create TimeAssignment
LOAD CSV WITH HEADERS FROM 'file:///TimeAssignment.csv' AS timeAss
MATCH (teacher:Individual {id: timeAss.teacherId})
MATCH (ci:CourseInstance {name: timeAss.courseInstance})
MERGE (teacher)-[ta:TimeAssignment{reportedHours: timeAss.reportedHours, assignedHours: timeAss.assignedHours}]->(ci)


// Insert Students into Programmes
LOAD CSV WITH HEADERS FROM 'file:///Students.csv' AS students
MATCH (prog:Programme {id:students.programme})
MATCH (s:Individual {id:students.studentId})
MERGE (prog)<-[r:isEnrolledIn]-(s);