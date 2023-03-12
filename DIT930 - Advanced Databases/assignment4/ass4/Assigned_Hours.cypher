// Assigned Hours
 LOAD CSV WITH HEADERS FROM 'file:///Assigned_Hours.csv' AS assignedHours
RETURN assignedHours
LIMIT 1;
