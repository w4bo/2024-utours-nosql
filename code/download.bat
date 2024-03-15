cd mongodb\data
IF EXIST "games.bson" (
  echo games.bson exists
) ELSE (
  curl --fail -L -o  games.bson https://big.csr.unibo.it/projects/nosql-datasets/games.bson
)

IF EXIST "restaurants.bson" (
  echo restaurants.bson exists
) ELSE (
  curl --fail -L -o  restaurants.bson https://big.csr.unibo.it/projects/nosql-datasets/restaurants.bson
)

IF EXIST "yelp-business.bson" (
  echo yelp-business.bson exists
) ELSE (
  curl --fail -L -o  yelp-business.bson https://big.csr.unibo.it/projects/nosql-datasets/yelp-business.bson
)
cd ..\..
