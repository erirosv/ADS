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