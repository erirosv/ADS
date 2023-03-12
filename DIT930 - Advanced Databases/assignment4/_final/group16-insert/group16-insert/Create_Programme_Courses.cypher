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