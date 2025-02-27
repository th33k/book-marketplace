// AUTO-GENERATED FILE. DO NOT MODIFY.

// This file is an auto-generated file by Ballerina persistence layer for model.
// It should not be modified by hand.

import ballerina/jballerina.java;
import ballerina/persist;
import ballerina/sql;
import ballerinax/h2.driver as _;
import ballerinax/java.jdbc;
import ballerinax/persist.sql as psql;

const USER = "users";
const BOOK = "books";
const REVIEW = "reviews";
const PURCHASE_ORDER = "purchaseorders";

public isolated client class Client {
    *persist:AbstractPersistClient;

    private final jdbc:Client dbClient;

    private final map<psql:SQLClient> persistClients;

    private final record {|psql:SQLMetadata...;|} & readonly metadata = {
        [USER]: {
            entityName: "User",
            tableName: "User",
            fieldMetadata: {
                id: {columnName: "id"},
                name: {columnName: "name"},
                email: {columnName: "email"},
                userType: {columnName: "userType"},
                passwordHash: {columnName: "passwordHash"},
                isBanned: {columnName: "isBanned"}
            },
            keyFields: ["id"]
        },
        [BOOK]: {
            entityName: "Book",
            tableName: "Book",
            fieldMetadata: {
                id: {columnName: "id"},
                authorId: {columnName: "authorId"},
                title: {columnName: "title"},
                description: {columnName: "description"},
                isbn: {columnName: "isbn"},
                price: {columnName: "price"},
                quantity: {columnName: "quantity"}
            },
            keyFields: ["id"]
        },
        [REVIEW]: {
            entityName: "Review",
            tableName: "Review",
            fieldMetadata: {
                id: {columnName: "id"},
                bookId: {columnName: "bookId"},
                buyerId: {columnName: "buyerId"},
                topic: {columnName: "topic"},
                description: {columnName: "description"},
                timestamp: {columnName: "timestamp"}
            },
            keyFields: ["id"]
        },
        [PURCHASE_ORDER]: {
            entityName: "PurchaseOrder",
            tableName: "PurchaseOrder",
            fieldMetadata: {
                id: {columnName: "id"},
                book_id: {columnName: "book_id"},
                buyer_id: {columnName: "buyer_id"},
                status: {columnName: "status"},
                deliveryAddrLine1: {columnName: "deliveryAddrLine1"},
                deliveryAddrLine2: {columnName: "deliveryAddrLine2"},
                deliveryAddrCity: {columnName: "deliveryAddrCity"},
                deliveryAddrZip: {columnName: "deliveryAddrZip"},
                timestamp: {columnName: "timestamp"}
            },
            keyFields: ["id"]
        }
    };

    public isolated function init() returns persist:Error? {
        jdbc:Client|error dbClient = new (url = url, user = user, password = password, options = connectionOptions);
        if dbClient is error {
            return <persist:Error>error(dbClient.message());
        }
        self.dbClient = dbClient;
        self.persistClients = {
            [USER]: check new (dbClient, self.metadata.get(USER), psql:H2_SPECIFICS),
            [BOOK]: check new (dbClient, self.metadata.get(BOOK), psql:H2_SPECIFICS),
            [REVIEW]: check new (dbClient, self.metadata.get(REVIEW), psql:H2_SPECIFICS),
            [PURCHASE_ORDER]: check new (dbClient, self.metadata.get(PURCHASE_ORDER), psql:H2_SPECIFICS)
        };
    }

    isolated resource function get users(UserTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.H2Processor",
        name: "query"
    } external;

    isolated resource function get users/[string id](UserTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.H2Processor",
        name: "queryOne"
    } external;

    isolated resource function post users(UserInsert[] data) returns string[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(USER);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from UserInsert inserted in data
            select inserted.id;
    }

    isolated resource function put users/[string id](UserUpdate value) returns User|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(USER);
        }
        _ = check sqlClient.runUpdateQuery(id, value);
        return self->/users/[id].get();
    }

    isolated resource function delete users/[string id]() returns User|persist:Error {
        User result = check self->/users/[id].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(USER);
        }
        _ = check sqlClient.runDeleteQuery(id);
        return result;
    }

    isolated resource function get books(BookTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.H2Processor",
        name: "query"
    } external;

    isolated resource function get books/[string id](BookTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.H2Processor",
        name: "queryOne"
    } external;

    isolated resource function post books(BookInsert[] data) returns string[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(BOOK);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from BookInsert inserted in data
            select inserted.id;
    }

    isolated resource function put books/[string id](BookUpdate value) returns Book|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(BOOK);
        }
        _ = check sqlClient.runUpdateQuery(id, value);
        return self->/books/[id].get();
    }

    isolated resource function delete books/[string id]() returns Book|persist:Error {
        Book result = check self->/books/[id].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(BOOK);
        }
        _ = check sqlClient.runDeleteQuery(id);
        return result;
    }

    isolated resource function get reviews(ReviewTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.H2Processor",
        name: "query"
    } external;

    isolated resource function get reviews/[string id](ReviewTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.H2Processor",
        name: "queryOne"
    } external;

    isolated resource function post reviews(ReviewInsert[] data) returns string[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(REVIEW);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from ReviewInsert inserted in data
            select inserted.id;
    }

    isolated resource function put reviews/[string id](ReviewUpdate value) returns Review|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(REVIEW);
        }
        _ = check sqlClient.runUpdateQuery(id, value);
        return self->/reviews/[id].get();
    }

    isolated resource function delete reviews/[string id]() returns Review|persist:Error {
        Review result = check self->/reviews/[id].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(REVIEW);
        }
        _ = check sqlClient.runDeleteQuery(id);
        return result;
    }

    isolated resource function get purchaseorders(PurchaseOrderTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.H2Processor",
        name: "query"
    } external;

    isolated resource function get purchaseorders/[string id](PurchaseOrderTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.H2Processor",
        name: "queryOne"
    } external;

    isolated resource function post purchaseorders(PurchaseOrderInsert[] data) returns string[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(PURCHASE_ORDER);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from PurchaseOrderInsert inserted in data
            select inserted.id;
    }

    isolated resource function put purchaseorders/[string id](PurchaseOrderUpdate value) returns PurchaseOrder|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(PURCHASE_ORDER);
        }
        _ = check sqlClient.runUpdateQuery(id, value);
        return self->/purchaseorders/[id].get();
    }

    isolated resource function delete purchaseorders/[string id]() returns PurchaseOrder|persist:Error {
        PurchaseOrder result = check self->/purchaseorders/[id].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(PURCHASE_ORDER);
        }
        _ = check sqlClient.runDeleteQuery(id);
        return result;
    }

    remote isolated function queryNativeSQL(sql:ParameterizedQuery sqlQuery, typedesc<record {}> rowType = <>) returns stream<rowType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.H2Processor"
    } external;

    remote isolated function executeNativeSQL(sql:ParameterizedQuery sqlQuery) returns psql:ExecutionResult|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.H2Processor"
    } external;

    public isolated function close() returns persist:Error? {
        error? result = self.dbClient.close();
        if result is error {
            return <persist:Error>error(result.message());
        }
        return result;
    }
}

