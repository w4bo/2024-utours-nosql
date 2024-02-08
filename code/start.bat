call .\build.bat
call .\download.bat


REM Starting docker containers
docker-compose down --remove-orphans
docker-compose up --build -d
timeout /t 20 /nobreak
docker exec neo4j bash -c "cypher-shell -u neo4j -p fitstic -f /datasets/movies.cypher"
npm test -- --detectOpenHandles
pause