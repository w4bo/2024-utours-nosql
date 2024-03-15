# Neo4j
Cypher Manual https://neo4j.com/docs/cypher-manual/current/
## Movie graph
### Simple patterns
1. Return all nodes and relationships in the database.
    ```
    MATCH (n) RETURN n
    ```
2. Count the nodes and arcs present
    ```
    MATCH (n) WITH COUNT(n) AS numVertices
    MATCH (a)-[e]->(b)
    RETURN numVertices, COUNT(e) AS numEdges
    ```
3. Given the movie The Departed (https://www.imdb.com/title/tt0407887/?ref_=fn_al_tt_1) enter the following nodes and arcs (WARNING: run the code in one block! Otherwise, the instructions to create the arcs must be preceded by a MATCH to retrieve the respective nodes involved). What does the following code do?
    ```
    CREATE (departed:Movie {title:'The Departed', released:2006, tagline:'Good and Evil'})
    CREATE (leo:Person {name:'Leonardo Di Caprio', born: 1974})
    CREATE (matt:Person {name:'Matt Damon', born: 1970})
    CREATE (leo)-[:ACTED_IN {roles: ['Billy']}]->(departed)
    CREATE (matt)-[:ACTED_IN {roles: ['Colin Sullivan']}]->(departed);
    MATCH (jack:Person {name: 'Jack Nicholson'})
    MATCH (departed:Movie {title:'The Departed'})
    CREATE (jack)-[:ACTED_IN {roles: ['Frank Costello']}]->(departed)
    ```
The code creates:
- The movie instance (properties: title, released)
- 3 main actors (properties: name, born)
- The respective ACTED_IN relationships (properties: role)
4. Return the movie The Departed and all nodes related to it
    ```
    MATCH (n:Movie {title:'The Departed'})<--(m) RETURN n, m
    ```
5. Return all 134 people connected to a movie
    ```
    MATCH (n:Person)-->(:Movie) RETURN n
    ```
6. Return the 104 actors, i.e., people who acted (ACTED_IN) in a movie
    ```
    MATCH (n:Person)-[:ACTED_IN]->(:Movie) RETURN n
    ```
7. Return the 5 actors who are also directors, i.e., have directed (DIRECTED) a movie (:Movie)
    ```
    MATCH (n:Person)-[:ACTED_IN]->(:Movie),(n:Person)-[:DIRECTED]->(:Movie) RETURN n
    MATCH (n:Person)-[:ACTED_IN]->(:Movie)
    MATCH (n:Person)-[:DIRECTED]->(:Movie)
    RETURN n
    ```
8. Return the 3 actors who also directed a movie in which they acted (ACTED_IN); also return the related movie
    ```
    MATCH (n:Person)-[:ACTED_IN]->(m:Movie),(n:Person)-[:DIRECTED]->(m:Movie) RETURN n, m
    ```
9. Return the 3 reviewers, i.e., the people who reviewed (REVIEWED) a movie
    ```
    MATCH (n:Person)-[:REVIEWED]->(:Movie) RETURN n
    MATCH (n:Person)-[:REVIEWED]->(m:Movie) RETURN n, m
    ```
10. Return the 2 movies that have been reviewed by different reviewers; return these as well
    ```
    MATCH (p:Person)-[:REVIEWED]->(m:Movie)<-[:REVIEWED]-(p2:Person) RETURN p, p2, m
    ```
11. Return the movie released (released) after 2010
    ```
    MATCH (m:Movie) WHERE m.released > 2010 RETURN m
    ```
12. Return the actors who starred in the film released after 2010; also return the film
    ```
    MATCH (p:Person)-[:ACTED_IN]->(m:Movie) WHERE m.released > 2010 RETURN m, p
    ```
13. Return all pairs of actors who starred in the same movie released after 2010; also return the movie. How does the result of this query change from that of the previous query?
    ```
    MATCH (p:Person)-[:ACTED_IN]->(m:Movie)<-[:ACTED_IN]-(p2:Person) WHERE m.released > 2010 RETURN m, p, p2
    ```
14. Return all pairs of actors who have acted together in more than one movie
    ```
    MATCH (p:Person)-[:ACTED_IN]->(m:Movie)<-[:ACTED_IN]-(p2:Person)-[:ACTED_IN]->(m2:Movie)<-[:ACTED_IN]-(p) RETURN p, p2, m, m2
    ```
15. Return, for each reviewer, all reviewers followed directly or indirectly through another reviewer
    ```
    MATCH (p:Person)-[:FOLLOWS*1..2]->(p2:Person) RETURN p, p2
    MATCH (m:Movie)<-[:REVIEWED]-(r1)-[:FOLLOWS*1..2]->(r2)-[:REVIEWED]->(:Movie) RETURN m, r1, r2
    NO: MATCH (p:Person)-[:FOLLOWS]->(p1:Person)-[:FOLLOWS]->(p2:Person) RETURN p, p2
    ```
16. Return the 12 nodes reachable by up to 3 jumps (in any direction) from Clint Eastwood
    ```
    MATCH (p:Person {name: 'Clint Eastwood'})-[*..3]-(m) RETURN p, m
    ```
### Aggregations
17. Return the ages of the actors who starred in the film Apollo 13 (make the difference between the release date of the film and the actor's year of birth)
    ```
    MATCH (m:Movie {title: 'Apollo 13'})<-[:ACTED_IN]-(p:Person) RETURN m, p, m.released - p.born
    ```
18. Calculate the average age of the actors who starred in the movie Apollo 13
    ```
    MATCH (m:Movie {title: 'Apollo 13'})<-[:ACTED_IN]-(p:Person) RETURN m, AVG(m.released - p.born)
    ```
19. Calculate the average age of the actors for each film
    ```
    MATCH (m:Movie)<-[:ACTED_IN]-(p:Person) RETURN m, AVG(m.released - p.born)
    ```
20. Return the top-10 movies with the lowest average age (use order by and limit clauses)
    ```
    MATCH (m:Movie)<-[:ACTED_IN]-(p:Person) RETURN m, AVG(m.released-p.born) as av ORDER BY av DESC LIMIT 10
    ```
## Northwind
- See: https://neo4j.com/developer/example-data/#demo-server
- Access Northwind: https://demo.neo4jlabs.com:7473/browser/?dbms=neo4j://northwind@demo.neo4jlabs.com&db=northwind
21. Return, for each product (:Product), the number of orders received
    ```
    MATCH (p:Product)<--(o:Order) RETURN p, COUNT(o)
    ```
22. Return, for customer (:Customer) with contactName Francisco Chang, products ordered by other customers who have purchased a jointly purchased product
    ```
    MATCH (c1:Customer {contactName: 'Francisco Chang'})-->(:Order)-->(p1:Product)<--(:Order)<--(c2:Customer)-->(:Order)-->(p2:Product) WHERE c1<>c2 and p1<>p2 RETURN DISTINCT p2
    ```
23. Return, for the product with productName Mascarpone Fabioli, the 3 most ordered products together with it
    ```
    MATCH (p:Product {productName: 'Mascarpone Fabioli'})--(:Order)--(p2:Product) WHERE p<>p2 RETURN p2, COUNT (*) AS c ORDER BY c DESC LIMIT 3
    ```
24. Return the 4 absolute most ordered pairs of products together
    ```
    MATCH (p:Product)--(:Order)--(p2:Product) WHERE p<>p2 RETURN p, p2, COUNT(*) AS c ORDER BY c DESC LIMIT 4
    ```
