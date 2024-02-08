# Neo4j
Cypher Manual https://neo4j.com/docs/cypher-manual/current/
## Movie graph
### Simple patterns
1. Return all nodes and relationships in the database.
2. Count the nodes and arcs present
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
5. Return all 134 people connected to a movie
6. Return the 104 actors, i.e., people who acted (ACTED_IN) in a movie
7. Return the 5 actors who are also directors, i.e., have directed (DIRECTED) a movie (:Movie)
8. Return the 3 actors who also directed a movie in which they acted (ACTED_IN); also return the related movie
9. Return the 3 reviewers, i.e., the people who reviewed (REVIEWED) a movie
10. Return the 2 movies that have been reviewed by different reviewers; return these as well
11. Return the movie released (released) after 2010
12. Return the actors who starred in the film released after 2010; also return the film
13. Return all pairs of actors who starred in the same movie released after 2010; also return the movie. How does the result of this query change from that of the previous query?
14. Return all pairs of actors who have acted together in more than one movie
15. Return, for each reviewer, all reviewers followed directly or indirectly through another reviewer
16. Return the 12 nodes reachable by up to 3 jumps (in any direction) from Clint Eastwood
### Aggregations
17. Return the ages of the actors who starred in the film Apollo 13 (make the difference between the release date of the film and the actor's year of birth)
18. Calculate the average age of the actors who starred in the movie Apollo 13
19. Calculate the average age of the actors for each film
20. Return the top-10 movies with the lowest average age (use order by and limit clauses)
## Northwind
- See: https://neo4j.com/developer/example-data/#demo-server
- Access Northwind: https://demo.neo4jlabs.com:7473/browser/?dbms=neo4j://northwind@demo.neo4jlabs.com&db=northwind
21. Return, for each product (:Product), the number of orders received
22. Return, for customer (:Customer) with contactName Francisco Chang, products ordered by other customers who have purchased a jointly purchased product
23. Return, for the product with productName Mascarpone Fabioli, the 3 most ordered products together with it
24. Return the 4 absolute most ordered pairs of products together
