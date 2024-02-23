# MongoDB (Find)
## Restaurants
1. Display all restaurants.
    ```
    db.restaurants.find()
    ```
2. Display neighborhood (borough) and cuisine type (cuisine) of all restaurants.
    ```
    db.restaurants.find({}, {borough: 1, cuisine: 1})
    ```
3. Display neighborhood (borough) and cuisine type (cuisine) of all restaurants, but without _id.
    ```
    db.restaurants.find({}, {borough: 1, cuisine: 1, _id: 0})
    ```
4. Display neighborhood (borough), cuisine type (cuisine) and street (address.street) of all restaurants.
    ```
    db.restaurants.find({}, {borough: 1, "cuisine": 1, "address.street": 1})
    ```
5. Display the restaurants whose zipcode is 11225
    ```
    db.restaurants.find({"address.zipcode": "11225"})
    ```
6. Display the restaurants whose cuisine type is Hamburgers
    ```
    db.restaurants.find({cuisine: "Hamburgers"})
    ```
7. Display the restaurants whose cuisine type is NOT Hamburgers
    ```
    db.restaurants.find({cuisine: {$ne: "Hamburgers"}})
    db.restaurants.find({cuisine: {$not: { $in: ["Hamburgers"]}})
    ```
8. Display restaurants whose type of cuisine is among Hamburgers, Bakery or Irish
    ```
    db.restaurants.find({cuisine: {$in: ["Hamburgers", "Bakery", "Irish"]})
    db.restaurants.find({$or: [{cuisine: "Hamburgers"}, {cuisine: "Bakery"}]})
    ```
9. Display restaurants whose type of cuisine is NOT among Hamburgers, Bakery or Irish
    ```
    db.restaurants.find({cuisine: {$nin: ["Hamburgers", "Bakery", "Irish"]}}
    db.restaurants.find({cuisine: {$not: {$in: ["Hamburgers", "Bakery", "Irish"]}})
    ```
10. Display restaurants whose type of cuisine does not exist
    ```
    db.restaurants.find({cuisine: {$exists: false}})
    ```
## Yelp business
11. Display all businesses that have received at least 10 reviews (review_count) AND are located in Arizona or Nevada (state = NV or AZ)
    ```
    db.yelpbusiness.find({review_count: {$gte: 10}, state: {$in: ["NV", "AZ"]}})
    -> 37113 results
    ```
12. Display all businesses that have received at least 10 reviews (review_count) OR are located in Arizona or Nevada (state = NV or AZ)
    ```
    db.yelpbusiness.find({$or: [{review_count: {$gte: 10}}, {state: {$in: ["NV", "AZ"]}}]})
    -> 79898 results
    ```
13. Display all businesses that have Grocery among the categories
    ```
    db.yelpbusiness.find({categories: "Grocery"})
    db.yelpbusiness.find({categories: {$in: ["Grocery"]}})
    -> 2850 results
    ```
14. Display all businesses that have Grocery AND Food among the categories
    ```
    db.yelpbusiness.find({categories: {$all: ["Grocery", "Food"]}})
    -> 4 results
    ```
15. Display all businesses that have Grocery OR Food among the categories
    ```
    db.yelpbusiness.find({categories: {$in: ["Grocery", "Food"]}})
    -> 4125 results
    ```
16. Display all businesses that have ONLY Grocery AND Food among the categories
    ```
    db.yelpbusiness.find({categories: ["Grocery", "Food"]})
    db.yelpbusiness.find({categories: {$all: ["Grocery", "Food"], $size: 2}})
    db.yelpbusinessdb.find({"categories": {"$size": 2}, "categories": ["Grocery", "Food"]})
    -> 0 results
    ```
17. Display all businesses that have 5 categories
    ```
    db.yelpbusiness.find({categories: {$size: 5}})
    -> 17227 results
    ```
18. Display all businesses that have 5 categories and the fifth category is Food
    ```
    db.yelpbusiness.find({$and: [{categories: {$size: 5}}, {"categories.4": "Food"} ]})
    db.yelpbusiness.find({categories: {$size: 5}, "categories.4": "Food"} )
    -> 604 results
    ```
19. Display the first two categories of each business
    ```
    db.yelpbusiness.find({}, {categories: {$slice: 2}})
    -> 144072 results (all: just a matter of changing the projection)
    ```
20. Display only the categories of Nevada businesses
    ```
    db.yelpbusiness.find({state: "NV"}, {"categories": 1, "state": 1})
    -> 28214 results
    ```
21. Display the distinct values of the city field
    ```
    db.yelpbusiness.distinct("city")
    -> 1 array with 878 distinct values
    ```
22. Display the distinct values of the city field in the state of Nevada
    ```
    db.yelpbusiness.distinct("city", {state: "NV"})
    -> 1 array with 41 distinct values
    ```
23. Display the distinct values of the categories array
    ```
    db.yelpbusiness.distinct("categories")
    -> 1 array with 1192 distinct values
    ```
## Games
24. Display games played in 2010. (1239 results). Date format: "year-month-day"
    ```
    db.games.find({date: {$gte: new Date("2010-01-01"), $lte: new Date("2010-12-31")}})
    db.games.find({$where: function(){ return this.date.getFullYear() == 2010}})
    ```
25. Display matches in which one of the teams scored at least 160 points (6 results)
    ```
    db.games.find({teams: {$elemMatch: {score: {$gte: 160}}}})
    db.games.find({"teams.score": {$gte: 160}})
    ```
26. Display matches in which the home team lost (12197 results)
    ```
    db.games.find({teams: {$elemMatch: {won: 0, home: true}})
    NO: db.games.find({teams: {won: 0, home: true}}) exact match
    NO: db.games.find({"teams.won": 0, "teams.home": true}) conditions in OR
    ```
27. Display games in which Michael Jordan played (990 results)
    ```
    db.games.find({box: {$elemMatch: {players: {player: "Michael Jordan"}}}}})
    db.games.find({box: {$elemMatch: {players.player: "Michael Jordan"}})
    db.games.find({"box.players.player": "Michael Jordan"} )
    ```
28. Display the games in which Michael Jordan scored more than 60 points (4 results)
    ```
    db.games.find({box: {$elemMatch: {players: {player: "Michael Jordan", pts: {$gt: 60}}}}}})
    db.games.find({"box.players": {$elemMatch: {player: "Michael Jordan", pts: {$gt: 60}}}})
    ```
29. Display the first 10 games stored in the collection (10 results)
    ```
    db.games.find().limit(10)
    ```
30. Display the first 10 games in date order (10 results)
    ```
    db.games.find().sort({date: 1}).limit(10)
    ```
31. Display the first 10 matches of 2010 in date order (10 results)
    ```
    db.games.find({date: {$gte: new Date("2010-01-01"), $lt: new Date("2011-01-01")}}).sort({date: 1}).limit(10)
    ```
32. Display the second 10 games (from 11th) of 2010 in date order (10 results)
    ```
    db.games.find({date: {$gte: new Date("2010-01-01"), $lte: new Date("2010-12-31")}}).sort({date: 1}).skip(10).limit(10)
    ```
## Additional exercises
33. [Restaurants] Display restaurants that have received at least one score (grades.score) greater than 10.
    ```
    db.restaurants.find({"grades.score": {"$gt": 10}})
    ```
34. [Restaurants] Display restaurants that received at least one score (grades.score) greater than 10 in 2014
    ```
    db.restaurants.find({"grades": {"$elemMatch": {"score": {"$gt": 10}, "date":{"$gte": new Date("2014-01-01"), "$lt": new Date("2015-01-01")}}}})
    ```
35. [Yelpbusiness] Count Yoga category businesses that have received at least 4 of score (stars) and are open (is_open=1)
    ```
    db.yelpbusiness.find({ "categories": "Yoga", "stars": { "$gte": 4}, "is_open": 1})
    ```
36. [Games] Display games in which the home team lost while scoring more than 120 points
    ```
    db.games.find({"teams": {"$elemMatch": {"home": true, "won": 0, score : {"$gte": 120}}}})
    ```
37. [Games] Display distinct list of dates in which one of the teams scored at least 160 points
    ```
    db.games.distinct( "date", { "teams": { "$elemMatch": { "score": {"$gte": 160}}}})
    ```
38. [Games] Display games in which either team missed all free throws (box.team.ft=0) despite having tried at least 2 (box.team.fta>=2)
    ```
    db.games.find({ "box": {"$elemMatch": {"team.ft": 0, "team.fta": {"$gte": 2}}}})
    ```