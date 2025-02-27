import book_marketplace.data;

import ballerina/http;
import ballerina/lang.array;
import ballerina/persist;
import ballerina/time;

listener http:Listener bookstoreListner = new (9090);
final data:Client dbClient = check new ();

@http:ServiceConfig {
    auth: [
        {
            oauth2IntrospectionConfig: {
                url: "http://localhost:9444/oauth2/introspect",
                tokenTypeHint: "access_token",
                scopeKey: "scp",
                clientConfig: {
                    customHeaders: {"Authorization": "Basic YXV0aG9yOmF1dGhvcg=="}

                }
            }
        }
    ]
}
service /book\-marketplace/api/v1 on bookstoreListner {
    resource function get books() returns data:Book[]|error {
        stream<data:Book, persist:Error?> bookStream = dbClient->/books;
        return from data:Book book in bookStream
            select book;
    }

    @http:ResourceConfig {
        auth: {
            scopes: ["author"]
        }
    }
    resource function post books/upload(@http:Header string authentication, UploadedBook uploadedBook)
            returns http:Created|http:Forbidden|error {
        string userId = check getUserId(authentication);
        data:BookInsert bookInsert = {
            id: generateId(),
            authorId: userId,
            ...uploadedBook
        };
        _ = check dbClient->/books.post([bookInsert]);
        return http:CREATED;
    }

    @http:ResourceConfig {
        auth: {
            scopes: ["author"]
        }
    }
    resource function delete books/[string bookId](@http:Header string authentication)
            returns http:NoContent|http:Forbidden|error {
        string userId = check getUserId(authentication);
        data:Book book = check dbClient->/books/[bookId];
        if userId != book.authorId {
            return {body: "You are not authorized to delete this book"};
        }
        _ = check dbClient->/books/[bookId].delete();
        return http:NO_CONTENT;
    }

    @http:ResourceConfig {
        auth: {
            scopes: ["buyer"]
        }
    }
    resource function post books/[string bookId]/purchase(@http:Header string authentication, DeliveryAddress address)
            returns http:Created|http:Forbidden|error {
        string userId = check getUserId(authentication);
        data:Book book = check dbClient->/books/[bookId];
        data:PurchaseOrder purchaseOrder = {
            id: generateId(),
            book_id: bookId,
            buyer_id: userId,
            status: data:PENDING,
            timestamp: time:utcNow(),
            ...address
        };
        transaction {
            _ = check dbClient->/purchaseorders.post([purchaseOrder]);
            _ = check dbClient->/books/[bookId].put({quantity: book.quantity - 1});
            check commit;
        }
        check sendAuthorMail(book.title, book.isbn, "shammi0107@gmail.com");
        return http:CREATED;
    }

    @http:ResourceConfig {
        auth: {
            scopes: ["buyer"]
        }
    }
    resource function post books/[string bookId]/review(@http:Header string authentication, string topic, string description)
            returns http:Created|http:Forbidden|error {
        string userId = check getUserId(authentication);
        data:ReviewInsert review = {
            id: generateId(),
            bookId,
            buyerId: userId,
            topic,
            description,
            timestamp: time:utcNow()
        };
        _ = check dbClient->/reviews.post([review]);
        return http:CREATED;
    }

    @http:ResourceConfig {
        auth: {
            scopes: ["admin"]
        }
    }
    resource function put users/[string userIdToBeBanned]/ban() returns http:NoContent|http:Forbidden|error {
        _ = check dbClient->/users/[userIdToBeBanned].put({isBanned: true});
        return http:NO_CONTENT;
    }
}

function getUserId(string authenticationStr) returns string|error {
    byte[] decoded = check array:fromBase64(authenticationStr);
    string decodedString = check string:fromBytes(decoded);
    return re `:`.split(decodedString)[2];
}
