#!/bin/bash
set -exo

chmod +x *.sh
./build.sh
./download.sh

if [ -f .env ]; then
  export $(cat .env | sed 's/#.*//g' | xargs)
fi

sudo docker compose down --remove-orphans
sudo docker compose up --build -d --remove-orphans
./wait-for-it.sh ${MONGO_URL}:${MONGO_PORT} --strict --timeout=10 -- echo "MongoDB is up"
./wait-for-it.sh ${NEO4J_URL}:${NEO4J_PORT} --strict --timeout=10 -- echo "Neo4J is up"
sleep 20
sudo docker exec neo4j bash -c "cypher-shell -u ${NEO4J_USER} -p ${NEO4J_PWD} -f /datasets/movies.cypher"
npm test -- --detectOpenHandles
