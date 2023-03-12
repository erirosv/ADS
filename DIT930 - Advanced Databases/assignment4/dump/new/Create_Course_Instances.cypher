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