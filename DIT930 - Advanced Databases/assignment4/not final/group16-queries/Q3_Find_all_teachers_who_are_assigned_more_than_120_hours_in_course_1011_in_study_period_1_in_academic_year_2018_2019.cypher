// Q3. Find all teachers who are assigned more than 120 hours in course 1011 in study period 1 in academic year 2018/2019.

MATCH (t:Individual)-[r1:TimeAssignment]-(ci:CourseInstance {studyPeriod: "1", academicYear: "2018-2019"})
MATCH (ci)<-[r2:isConductedAs]-(c:Course {courseCode: "1011"})
WHERE r1.assignedHours > 120
RETURN t