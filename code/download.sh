#!/bin/bash
set -exo
cd mongodb/data
if test -f "games.bson"; then
    echo "games.bson exists"
else
    curl --fail -L -o games.bson http://big.csr.unibo.it/projects/nosql-datasets/games.bson
fi
if test -f "restaurants.bson"; then
    echo "restaurants.bson exists"
else
    curl --fail -L -o restaurants.bson http://big.csr.unibo.it/projects/nosql-datasets/restaurants.bson
fi
if test -f "yelp-business.bson"; then
    echo "yelp-business.bson exists"
else
    curl --fail -L -o yelp-business.bson http://big.csr.unibo.it/projects/nosql-datasets/yelp-business.bson
fi
ls -las
cd -