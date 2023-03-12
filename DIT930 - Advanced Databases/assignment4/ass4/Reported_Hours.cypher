// Reported Hours
LOAD CSV WITH HEADERS FROM 'file:///Reported_Hours.csv' AS reportedHours
RETURN reportedHours
LIMIT 1;
