require('dotenv').config()
const {MongoClient} = require('mongodb');

const MONGO_URL = process.env.MONGO_URL
const MONGO_PORT = process.env.MONGO_PORT
const URI = "mongodb://" + MONGO_URL + ":" + MONGO_PORT + "/"
const client = new MongoClient(URI);
let db = null

async function connect() {
    try {
        await client.connect();
        db = client.db("exercises")
        db.restaurants = db.collection("restaurants")
        return db
    } catch (e) {
        console.error(e);
    }
}

async function disconnect() {
    await client.close()
}

async function getResult(obj) {
    return await obj.toArray();
}

module.exports = {};
module.exports.connect = connect;
module.exports.disconnect = disconnect;
module.exports.getResult = getResult;
