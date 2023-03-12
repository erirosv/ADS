// Create Programmes
LOAD CSV WITH HEADERS FROM 'file:///Programmes.csv' AS programmes
MATCH (d:Individual {id: programmes.director}) 
MATCH (dept:Department {name: programmes.department})
MERGE (dept)-[k:isOffering]->(prog:Programme {name:programmes.programmeName, id:programmes.programme})-[r:hasDirector]->(d)