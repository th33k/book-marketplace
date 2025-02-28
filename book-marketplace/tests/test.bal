import ballerina/test;

@test:Config
function validateUUIDGeneration() {
    test:assertNotEquals(generateId(), generateId());
    // TODO: Test if the generated UUID is of the correct length. (UUID Type 1 lentgh is 36)
}
