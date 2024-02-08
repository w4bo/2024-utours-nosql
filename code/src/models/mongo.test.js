const mongo = require('./mongo');
let db

beforeAll(async () => {
    db = await mongo.connect();
});

function restaurants01() {
    return db.restaurants.find({}, {});
}

function restaurants02() {
    return db.restaurants.find({}, {projection: {borough: 1, cuisine: 1}});
}

function restaurants03() {
    return db.restaurants.find({}, {projection: {borough: 1, cuisine: 1, _id: 0}});
}

function restaurants04() {
    return db.restaurants.find({}, {projection: {borough: 1, cuisine: 1, 'address.street': 1, _id: 0}});
}

function restaurants05() {
    return db.restaurants.find({"address.zipcode": "11225"});
}

function restaurants06() {
    return db.restaurants.find({cuisine: "Hamburgers"});
}

function restaurants07() {
    return db.restaurants.find({cuisine: {$ne: "Hamburgers"}});
}

function restaurants07bis() {
    return db.restaurants.find({cuisine: {$not: {$in: ["Hamburgers"]}}});
}

function restaurants08() {
    return db.restaurants.find({cuisine: {$in: ["Hamburgers", "Bakery", "Irish"]}});
}

function restaurants08bis() {
    return db.restaurants.find({$or: [{cuisine: "Hamburgers"}, {cuisine: "Bakery"}, {cuisine: "Irish"}]});
}

function restaurants09() {
    return db.restaurants.find({cuisine: {$nin: ["Hamburgers", "Bakery", "Irish"]}});
}

function restaurants09bis() {
    return db.restaurants.find({cuisine: {$not: {$in: ["Hamburgers", "Bakery", "Irish"]}}});
}

function restaurants10() {
    return db.restaurants.find({cuisine: {$exists: false}});
}

test('restaurants01', async () => {
    const data = await mongo.getResult(restaurants01());
    expect(data.length).toBe(25359);
});

test('restaurants02', async () => {
    const data = await mongo.getResult(restaurants02());
    expect(data.length).toBe(25359);
});

test('restaurants03', async () => {
    const data = await mongo.getResult(restaurants03());
    expect(data.length).toBe(25359);
});

test('restaurants04', async () => {
    const data = await mongo.getResult(restaurants04());
    expect(data.length).toBe(25359);
});

test('restaurants05', async () => {
    const data = await mongo.getResult(restaurants05());
    expect(data.length).toBe(112);
});

test('restaurants06', async () => {
    const data = await mongo.getResult(restaurants06());
    expect(data.length).toBe(433);
});

test('restaurants07', async () => {
    let data = await mongo.getResult(restaurants07());
    expect(data.length).toBe(24926);
    data = await mongo.getResult(restaurants07bis());
    expect(data.length).toBe(24926);
});

test('restaurants08', async () => {
    let data = await mongo.getResult(restaurants08());
    expect(data.length).toBe(1314);
    data = await mongo.getResult(restaurants08bis());
    expect(data.length).toBe(1314);
});

test('restaurants09', async () => {
    let data = await mongo.getResult(restaurants09());
    expect(data.length).toBe(24045);
    data = await mongo.getResult(restaurants09bis());
    expect(data.length).toBe(24045);
});

test('restaurants10', async () => {
    const data = await mongo.getResult(restaurants10());
    console.log(data)
    expect(data.length).toBe(1);
});

afterAll(async () => {
    await mongo.disconnect();
});