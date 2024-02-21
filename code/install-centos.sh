#!/bin/bash
set -exo

# chmod +x *.sh
# . ./download.sh

yum install -y https://dist.neo4j.org/neo4j-java17-adapter.noarch.rpm --skip-broken
rpm --import https://debian.neo4j.com/neotechnology.gpg.key
cat << EOF >  /etc/yum.repos.d/neo4j.repo
[neo4j]
name=Neo4j RPM Repository
baseurl=https://yum.neo4j.com/stable/5
enabled=1
gpgcheck=1
EOF
cat /etc/yum.repos.d/neo4j.repo
yum install -y neo4j-5.16.0

# neo4j &

cat << EOF >  /etc/yum.repos.d/mongodb-org-7.0.repo
[mongodb-org-7.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/9/mongodb-org/7.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://pgp.mongodb.com/server-7.0.asc
EOF

# yum install -y mongodb-org mongodb-org-database mongodb-org-server mongodb-mongosh mongodb-org-mongos mongodb-org-tools
yum install -y https://repo.mongodb.org/yum/redhat/9/mongodb-org/7.0/x86_64/RPMS/mongodb-org-7.0.5-1.el9.x86_64.rpm --skip-broken

cd mongodb/data
for f in *.json; do
    echo $f
    extension="${f##*.}"
    filename="${f%.*}"
    mongoimport mongodb://127.0.0.1:27017 --jsonArray --db=exercises --collection=$filename --file=$f
done
for f in *.bson; do
    echo $f
    extension="${f##*.}"    
    filename="${f%.*}"
    mongorestore mongodb://127.0.0.1:27017 --db=exercises --collection=$filename $f
done
# ./studio-3t-linux-x64.sh &

mongod