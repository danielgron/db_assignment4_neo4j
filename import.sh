LOAD CSV WITH HEADERS FROM "file:///import.csv" AS row
MATCH (from:Player), (to:Player)
WHERE from.Name = row.From AND to.Name = row.To
return *;

"CALL apoc.load.csv('import.csv') YIELD lineNo, map, list RETURN *;"
CREATE (:Player {id:row.From, name:row.From});


MATCH (n) DETACH DELETE n;

LOAD CSV WITH HEADERS FROM "file:///import.csv" AS row
WITH row
WHERE row.Type = 'PASS'
MERGE (playerFrom:Player {name: row.From})
MERGE (playerTo:Player {name: row.To})
MERGE (team:Team {name: row.Team})
CREATE (playerFrom)-[:PASS_TO {startX:row.`Start X`, startY:row.`Start Y`, endX:row.`End X`, endY:row.`End Y`}]->(playerTo);

LOAD CSV WITH HEADERS FROM "file:///import.csv" AS row1
WITH row1
WHERE row1.SubType IS NULL
MERGE (event:Event {name: row1.Type});

LOAD CSV WITH HEADERS FROM "file:///import.csv" AS row2
WITH row2
WHERE row2.Subtype IS NOT NULL
MERGE (playerFrom:Player {name: row2.From})
MERGE (event:Event {name: row2.Type + " - " + row2.Subtype})
CREATE (playerFrom)-[:DID {startX:row2.`Start X`, startY:row2.`Start Y`, endX:row2.`End X`, endY:row2.`End Y`, startTime:row2.`Start Time [s]`, endTime:row2.`End Time [s]`, duration:toFloat(row2.`End Time [s]`) - toFloat(row2.`Start Time [s]`)}]->(event);



MATCH (p1:Player {id:row.From}), (p2:Player {id:row.To})
CREATE (p1)-[:PASS_TO]->(p2);