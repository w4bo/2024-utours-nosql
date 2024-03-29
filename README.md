# NoSQL in Action!

[![Build](https://github.com/w4bo/2024-utours-nosql/actions/workflows/build.yml/badge.svg)](https://github.com/w4bo/2024-utours-nosql/actions/workflows/build.yml)

Matteo Francia, University of Bologna.

Thanks to Enrico Gallinucci and Oscar Romero for sharing their teaching material.

Link to this repository: https://github.com/w4bo/2024-utours-nosql

## Description

In this 10-hour course, we will delve into NoSQL databases, their pros/cons with respect to relational ones, and their intersection with big data.
We will discuss challenges related to design, scaling to clusters of machines, and data availability.
We will mainly refer to document- and graph-based data models, introducing their fundamentals and their application to some real-life scenarios (such as the Internet of Things and social networks).
For both data models, we will have 2-hour theory and 3-hour laboratory classes.

## Teaching material

|          When                      | Duration (hours) | What                                                                    |
|:----------------------------------:|:----------------:|-------------------------------------------------------------------------|
| Fri 2024-02-09, 13:00 (room 345)   |         2        | Introduction to NoSQL databases with a focus on Document-based database |
| Wed 2024-02-21, 14:45 (room 345)   |         2        | Introduction to property and knowledge graph databases                  |
| Fri 2024-02-23, 14:45 (room 345)   |         3        | Hands on MongoDB                                                        |
| Fri 2024-03-15, 14:45 (room 345)   |         3        | Hands on Neo4J                                                          |

- `code/` contains the software necessary to start the databases on docker
- `slides/` contains the teaching material

## Requirements

### Install MongoDB

#### With Docker (if you have Docker installed in your PC)

1. Install and run Docker Desktop
1. Clone the repository: `git clone https://github.com/w4bo/2024-utours-nosql.git`
1. Start the database (collections are automatically loaded into the database)
    - On Windows, double click on `code/start.bat`
    - On Linux,
      ```sh
      cd code
      sh start.sh
      ``` 

#### Without Docker

1. Follow the instructions at [MongoDB](https://www.mongodb.com/docs/manual/administration/install-community/)
    - Windows: https://www.mongodb.com/docs/manual/tutorial/install-mongodb-on-windows-unattended/#std-label-install-mdb-community-windows-msiexec
    - Linux: https://www.mongodb.com/docs/manual/administration/install-on-linux/ 
2. Clone the repository: `git clone https://github.com/w4bo/2024-utours-nosql.git`
3. Download the databases
    - On Windows, double click on `code/download.bat`
    - On Linux,
      ```sh
      cd code
      sh download.sh
      ``` 
4. Import the databases
```sh
mongorestore --host <database-host> --port <database-port> -d exercises code/mongodb/data
``` 
   
### Install Studio3T 

1. Download and install Studio3T
1. Connect Studio3T to MongoDB (`${MONGO_URL}:${MONGO_PORT}`, e.g. `127.0.0.1:27118`)
   ![immagine](https://user-images.githubusercontent.com/18005592/224693910-36e7fbd3-aac7-4888-8872-a3ef2f12bda1.png)

## Neo4J

1. Access via browser the Neo4J's GUI (`${NEO4J_URL}:${NEO4J_PORT_GUI}`, e.g. `127.0.0.1:7474`)
