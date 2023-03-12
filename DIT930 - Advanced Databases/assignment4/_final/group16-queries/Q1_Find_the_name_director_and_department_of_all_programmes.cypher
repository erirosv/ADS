// Q1. Find the name, director and department of all programmes.

MATCH (prog:Programme)-[r:hasDirector]-(director) 
MATCH (dept:Department)-[r2:isOffering]-(prog)
RETURN prog.name, director.id, dept.name