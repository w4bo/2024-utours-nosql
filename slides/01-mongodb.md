# MongoDB (Find)
## Restaurants
1. Display all restaurants.
2. Display neighborhood (borough) and cuisine type (cuisine) of all restaurants.
3. Display neighborhood (borough) and cuisine type (cuisine) of all restaurants, but without _id.
4. Display neighborhood (borough), cuisine type (cuisine) and street (address.street) of all restaurants.
5. Display the restaurants whose zipcode is 11225
6. Display the restaurants whose cuisine type is Hamburgers
7. Display the restaurants whose cuisine type is NOT Hamburgers
8. Display restaurants whose type of cuisine is among Hamburgers, Bakery or Irish
9. Display restaurants whose type of cuisine is NOT among Hamburgers, Bakery or Irish
10. Display restaurants whose type of cuisine does not exist
## Yelp business
11. Display all businesses that have received at least 10 reviews (review_count) AND are located in Arizona or Nevada (state = NV or AZ)
12. Display all businesses that have received at least 10 reviews (review_count) OR are located in Arizona or Nevada (state = NV or AZ)
13. Display all businesses that have Grocery among the categories
14. Display all businesses that have Grocery AND Food among the categories
15. Display all businesses that have Grocery OR Food among the categories
16. Display all businesses that have ONLY Grocery AND Food among the categories
17. Display all businesses that have 5 categories
18. Display all businesses that have 5 categories and the fifth category is Food
19. Display the first two categories of each business
20. Display only the categories of Nevada businesses
21. Display the distinct values of the city field
22. Display the distinct values of the city field in the state of Nevada
23. Display the distinct values of the categories array
## Games
24. Display games played in 2010. (1239 results). Date format: "year-month-day"
25. Display matches in which one of the teams scored at least 160 points (6 results)
26. Display matches in which the home team lost (12197 results)
27. Display games in which Michael Jordan played (990 results)
28. Display the games in which Michael Jordan scored more than 60 points (4 results)
29. Display the first 10 games stored in the collection (10 results)
30. Display the first 10 games in date order (10 results)
31. Display the first 10 matches of 2010 in date order (10 results)
32. Display the second 10 games (from 11th) of 2010 in date order (10 results)
## Additional exercises
33. [Restaurants] Display restaurants that have received at least one score (grades.score) greater than 10.
34. [Restaurants] Display restaurants that received at least one score (grades.score) greater than 10 in 2014
35. [Yelpbusiness] Count Yoga category businesses that have received at least 4 of score (stars) and are open (is_open=1)
36. [Games] Display games in which the home team lost while scoring more than 120 points
37. [Games] Display distinct list of dates in which one of the teams scored at least 160 points
38. [Games] Display games in which either team missed all free throws (box.team.ft=0) despite having tried at least 2 (box.team.fta>=2)