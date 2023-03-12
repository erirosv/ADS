// Q4. Find all students registered for course instance I-910 that were not registered for course instance I-911.

MATCH (s:Student)-[:Registration]-(:CourseInstance {name: "I-910"})
WHERE NOT exists((s)-[:Registration]-(:CourseInstance {name: "I-911"}))
RETURN DISTINCT s
ORDER BY s.name ASC