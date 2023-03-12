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