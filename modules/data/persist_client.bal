// AUTO-GENERATED FILE. DO NOT MODIFY.

// This file is an auto-generated file by Ballerina persistence layer for model.
// It should not be modified by hand.

import ballerina/jballerina.java;
import ballerina/persist;
import ballerinax/persist.inmemory;

const USER = "users";
const BOOK = "books";
const REVIEW = "reviews";
const PURCHASE_ORDER = "purchaseorders";
final isolated table<User> key(id) usersTable = table [];
final isolated table<Book> key(id) booksTable = table [];
final isolated table<Review> key(id) reviewsTable = table [];
final isolated table<PurchaseOrder> key(id) purchaseordersTable = table [];

public isolated client class Client {
    *persist:AbstractPersistClient;

    private final map<inmemory:InMemoryClient> persistClients;

    public isolated function init() returns persist:Error? {
        final map<inmemory:TableMetadata> metadata = {
            [USER]: {
                keyFields: ["id"],
                query: queryUsers,
                queryOne: queryOneUsers
            },
            [BOOK]: {
                keyFields: ["id"],
                query: queryBooks,
                queryOne: queryOneBooks
            },
            [REVIEW]: {
                keyFields: ["id"],
                query: queryReviews,
                queryOne: queryOneReviews
            },
            [PURCHASE_ORDER]: {
                keyFields: ["id"],
                query: queryPurchaseorders,
                queryOne: queryOnePurchaseorders
            }
        };
        self.persistClients = {
            [USER]: check new (metadata.get(USER).cloneReadOnly()),
            [BOOK]: check new (metadata.get(BOOK).cloneReadOnly()),
            [REVIEW]: check new (metadata.get(REVIEW).cloneReadOnly()),
            [PURCHASE_ORDER]: check new (metadata.get(PURCHASE_ORDER).cloneReadOnly())
        };
    }

    isolated resource function get users(UserTargetType targetType = <>) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "query"
    } external;

    isolated resource function get users/[string id](UserTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "queryOne"
    } external;

    isolated resource function post users(UserInsert[] data) returns string[]|persist:Error {
        string[] keys = [];
        foreach UserInsert value in data {
            lock {
                if usersTable.hasKey(value.id) {
                    return persist:getAlreadyExistsError("User", value.id);
                }
                usersTable.put(value.clone());
            }
            keys.push(value.id);
        }
        return keys;
    }

    isolated resource function put users/[string id](UserUpdate value) returns User|persist:Error {
        lock {
            if !usersTable.hasKey(id) {
                return persist:getNotFoundError("User", id);
            }
            User user = usersTable.get(id);
            foreach var [k, v] in value.clone().entries() {
                user[k] = v;
            }
            usersTable.put(user);
            return user.clone();
        }
    }

    isolated resource function delete users/[string id]() returns User|persist:Error {
        lock {
            if !usersTable.hasKey(id) {
                return persist:getNotFoundError("User", id);
            }
            return usersTable.remove(id).clone();
        }
    }

    isolated resource function get books(BookTargetType targetType = <>) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "query"
    } external;

    isolated resource function get books/[string id](BookTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "queryOne"
    } external;

    isolated resource function post books(BookInsert[] data) returns string[]|persist:Error {
        string[] keys = [];
        foreach BookInsert value in data {
            lock {
                if booksTable.hasKey(value.id) {
                    return persist:getAlreadyExistsError("Book", value.id);
                }
                booksTable.put(value.clone());
            }
            keys.push(value.id);
        }
        return keys;
    }

    isolated resource function put books/[string id](BookUpdate value) returns Book|persist:Error {
        lock {
            if !booksTable.hasKey(id) {
                return persist:getNotFoundError("Book", id);
            }
            Book book = booksTable.get(id);
            foreach var [k, v] in value.clone().entries() {
                book[k] = v;
            }
            booksTable.put(book);
            return book.clone();
        }
    }

    isolated resource function delete books/[string id]() returns Book|persist:Error {
        lock {
            if !booksTable.hasKey(id) {
                return persist:getNotFoundError("Book", id);
            }
            return booksTable.remove(id).clone();
        }
    }

    isolated resource function get reviews(ReviewTargetType targetType = <>) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "query"
    } external;

    isolated resource function get reviews/[string id](ReviewTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "queryOne"
    } external;

    isolated resource function post reviews(ReviewInsert[] data) returns string[]|persist:Error {
        string[] keys = [];
        foreach ReviewInsert value in data {
            lock {
                if reviewsTable.hasKey(value.id) {
                    return persist:getAlreadyExistsError("Review", value.id);
                }
                reviewsTable.put(value.clone());
            }
            keys.push(value.id);
        }
        return keys;
    }

    isolated resource function put reviews/[string id](ReviewUpdate value) returns Review|persist:Error {
        lock {
            if !reviewsTable.hasKey(id) {
                return persist:getNotFoundError("Review", id);
            }
            Review review = reviewsTable.get(id);
            foreach var [k, v] in value.clone().entries() {
                review[k] = v;
            }
            reviewsTable.put(review);
            return review.clone();
        }
    }

    isolated resource function delete reviews/[string id]() returns Review|persist:Error {
        lock {
            if !reviewsTable.hasKey(id) {
                return persist:getNotFoundError("Review", id);
            }
            return reviewsTable.remove(id).clone();
        }
    }

    isolated resource function get purchaseorders(PurchaseOrderTargetType targetType = <>) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "query"
    } external;

    isolated resource function get purchaseorders/[string id](PurchaseOrderTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "queryOne"
    } external;

    isolated resource function post purchaseorders(PurchaseOrderInsert[] data) returns string[]|persist:Error {
        string[] keys = [];
        foreach PurchaseOrderInsert value in data {
            lock {
                if purchaseordersTable.hasKey(value.id) {
                    return persist:getAlreadyExistsError("PurchaseOrder", value.id);
                }
                purchaseordersTable.put(value.clone());
            }
            keys.push(value.id);
        }
        return keys;
    }

    isolated resource function put purchaseorders/[string id](PurchaseOrderUpdate value) returns PurchaseOrder|persist:Error {
        lock {
            if !purchaseordersTable.hasKey(id) {
                return persist:getNotFoundError("PurchaseOrder", id);
            }
            PurchaseOrder purchaseorder = purchaseordersTable.get(id);
            foreach var [k, v] in value.clone().entries() {
                purchaseorder[k] = v;
            }
            purchaseordersTable.put(purchaseorder);
            return purchaseorder.clone();
        }
    }

    isolated resource function delete purchaseorders/[string id]() returns PurchaseOrder|persist:Error {
        lock {
            if !purchaseordersTable.hasKey(id) {
                return persist:getNotFoundError("PurchaseOrder", id);
            }
            return purchaseordersTable.remove(id).clone();
        }
    }

    public isolated function close() returns persist:Error? {
        return ();
    }
}

isolated function queryUsers(string[] fields) returns stream<record {}, persist:Error?> {
    table<User> key(id) usersClonedTable;
    lock {
        usersClonedTable = usersTable.clone();
    }
    return from record {} 'object in usersClonedTable
        select persist:filterRecord({
                                        ...'object
                                    }, fields);
}

isolated function queryOneUsers(anydata key) returns record {}|persist:NotFoundError {
    table<User> key(id) usersClonedTable;
    lock {
        usersClonedTable = usersTable.clone();
    }
    from record {} 'object in usersClonedTable
    where persist:getKey('object, ["id"]) == key
    do {
        return {
            ...'object
        };
    };
    return persist:getNotFoundError("User", key);
}

isolated function queryBooks(string[] fields) returns stream<record {}, persist:Error?> {
    table<Book> key(id) booksClonedTable;
    lock {
        booksClonedTable = booksTable.clone();
    }
    return from record {} 'object in booksClonedTable
        select persist:filterRecord({
                                        ...'object
                                    }, fields);
}

isolated function queryOneBooks(anydata key) returns record {}|persist:NotFoundError {
    table<Book> key(id) booksClonedTable;
    lock {
        booksClonedTable = booksTable.clone();
    }
    from record {} 'object in booksClonedTable
    where persist:getKey('object, ["id"]) == key
    do {
        return {
            ...'object
        };
    };
    return persist:getNotFoundError("Book", key);
}

isolated function queryReviews(string[] fields) returns stream<record {}, persist:Error?> {
    table<Review> key(id) reviewsClonedTable;
    lock {
        reviewsClonedTable = reviewsTable.clone();
    }
    return from record {} 'object in reviewsClonedTable
        select persist:filterRecord({
                                        ...'object
                                    }, fields);
}

isolated function queryOneReviews(anydata key) returns record {}|persist:NotFoundError {
    table<Review> key(id) reviewsClonedTable;
    lock {
        reviewsClonedTable = reviewsTable.clone();
    }
    from record {} 'object in reviewsClonedTable
    where persist:getKey('object, ["id"]) == key
    do {
        return {
            ...'object
        };
    };
    return persist:getNotFoundError("Review", key);
}

isolated function queryPurchaseorders(string[] fields) returns stream<record {}, persist:Error?> {
    table<PurchaseOrder> key(id) purchaseordersClonedTable;
    lock {
        purchaseordersClonedTable = purchaseordersTable.clone();
    }
    return from record {} 'object in purchaseordersClonedTable
        select persist:filterRecord({
                                        ...'object
                                    }, fields);
}

isolated function queryOnePurchaseorders(anydata key) returns record {}|persist:NotFoundError {
    table<PurchaseOrder> key(id) purchaseordersClonedTable;
    lock {
        purchaseordersClonedTable = purchaseordersTable.clone();
    }
    from record {} 'object in purchaseordersClonedTable
    where persist:getKey('object, ["id"]) == key
    do {
        return {
            ...'object
        };
    };
    return persist:getNotFoundError("PurchaseOrder", key);
}

