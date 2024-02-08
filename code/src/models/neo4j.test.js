const neo4j = require('./neo4j');

beforeAll(async () => {
    await neo4j.connect();
});


function movie01() {
    return neo4j.cypher("MATCH (n) RETURN n")
}

function movie05() {
    return neo4j.cypher("MATCH (n:Person)-->(:Movie) RETURN n")
}

test('movie01', async () => {
    const data = await movie01();
    expect(data.records.length).toBeGreaterThan(0); //
});

test('movie05', async () => {
    const data = await movie05();
    expect(data.records.length).toBeGreaterThan(0); // .toBe(134);
});

afterAll(async () => {
    await neo4j.disconnect();
});