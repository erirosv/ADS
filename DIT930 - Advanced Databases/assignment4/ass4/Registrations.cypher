// Registrations
LOAD CSV WITH HEADERS FROM 'file:///Registrations.csv' AS registrations
RETURN registrations
LIMIT 1;
