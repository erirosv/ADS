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
