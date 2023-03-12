// Q5. Find all programmes along with the total number of owned courses. List the results in descending order of number of owned courses.

MATCH (c:Course)-[r:ownedBy]->(p:Programme)
RETURN p.name, COUNT(r) as ownedCourses
ORDER BY ownedCourses DESC