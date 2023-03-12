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
CREATE (ci:CourseInstance
    {
        name: courseInstances.courseInstance,
        studyPeriod: courseInstances.studyPeriod, 
        academicYear: courseInstances.academicYear
    }
)
WITH ci, courseInstances
MATCH (examiner:SeniorTeacher {id: courseInstances.examiner})
MERGE (examiner)-[r:isExamining]->(ci)
WITH ci, courseInstances
MATCH (course:Course {courseCode: courseInstances.courseCode})
MERGE (course)-[k:isConductedAs]->(ci)

// Create Courses
LOAD CSV WITH HEADERS FROM 'file:///Courses.csv' AS courses
CREATE (c:Course
    {
        name: courses.courseName, 
        courseCode: courses.courseCode,
        level: courses.level,
        credits: courses.credits
    }
)
WITH c, courses
MATCH (prog:Programme {name: courses.ownedBy})
MERGE (c)-[r:ownedBy]->(prog)
WITH c, courses
MATCH (div:Division {name: courses.division})
MERGE (c)-[k:isUnder]->(div)

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
CREATE (pc:ProgrammeCourses
    {
        studyYear: programmeCourses.studyYear, 
        courseType: programmeCourses.courseType,
        academicYear: programmeCourses.academicYear
    }
)
WITH pc, programmeCourses
MATCH (prog:Programme {id: programmeCourses.programme})
MERGE (pc)<-[r:isProviding]-(prog)
WITH pc, programmeCourses
MATCH (course:Course {courseCode: programmeCourses.courseCode})
MERGE (pc)-[k:isBelongingTo]->(course)

// Create Programmes
LOAD CSV WITH HEADERS FROM 'file:///Programmes.csv' AS programmes
MATCH (d:Individual {id: programmes.director}) 
MATCH (dept:Department {name: programmes.department})
MERGE (dept)-[k:isOffering]->(prog:Programme {name:programmes.programmeName, id:programmes.programme})-[r:hasDirector]->(d)

// Create Registrations
LOAD CSV WITH HEADERS FROM 'file:///Registrations.csv' AS registrations
MATCH (student:Individual {id: registrations.studentId})
MATCH (ci:CourseInstance {name: registrations.courseInstance})
CREATE (student)-[reg:Registration 
    {grade: registrations.grade, status: registrations.status}]->(ci)

// Create Senior Teachers
LOAD CSV WITH HEADERS FROM 'file:///Senior_Teachers.csv' AS seniorTeachers
MATCH (div:Division {name: seniorTeachers.division})
CREATE (div)<-[k:isWorkingFor]-(st:Individual:TeachingStaff:SeniorTeacher 
    {
        name: seniorTeachers.teacherName, 
        id: seniorTeachers.teacherId
    }
)

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

// Create Teaching Assistants
LOAD CSV WITH HEADERS FROM 'file:///Teaching_Assistants.csv' AS teachingAssistants
MERGE (ta:Individual:TeachingStaff:TeachingAssistant 
    {
        name: teachingAssistants.teacherName, 
        id: teachingAssistants.teacherId
    }
)
WITH ta, teachingAssistants
MERGE (div:Division {name: teachingAssistants.division})<-[k:isWorkingFor]-(ta)

// Create TimeAssignment
LOAD CSV WITH HEADERS FROM 'file:///TimeAssignment.csv' AS timeAss
MATCH (teacher:Individual {id: timeAss.teacherId})
MATCH (ci:CourseInstance {name: timeAss.courseInstance})
CREATE (teacher)-[ta:TimeAssignment{reportedHours: timeAss.reportedHours, assignedHours: timeAss.assignedHours}]->(ci)


// Insert CoursePlannings into CourseInstances
LOAD CSV WITH HEADERS FROM 'file:///Course_plannings.csv' AS coursePlannings
MATCH (ci:CourseInstance {name: coursePlannings.courseInstance})
SET ci.assistantHours = coursePlannings.assistantHours,
    ci.seniorHours = coursePlannings.seniorHours,
    ci.plannedNumStudents = coursePlannings.plannedNumStudents

// Insert Students into Programmes
LOAD CSV WITH HEADERS FROM 'file:///Students.csv' AS students
MATCH (prog:Programme {id:students.programme})
MATCH (s:Individual {id:students.studentId})
MERGE (prog)<-[r:isEnrolledIn]-(s);