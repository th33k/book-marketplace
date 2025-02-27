import ballerina/test;

@test:Config
function validateUUIDGeneration() {
    test:assertEquals(generateId().length(), 36);
}
