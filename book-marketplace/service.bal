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
        // TODO: 1. Return the books
    }

    @http:ResourceConfig {
        auth: {
            scopes: ["author"]
        }
    }
    resource function post books/upload(@http:Header string authorization, UploadedBook uploadedBook)
            returns http:Created|http:Forbidden|error {
        string userId = check getUserId(authorization);
        data:BookInsert bookInsert = {
            id: generateId(),
            authorId: userId,
            ...uploadedBook
        };
       // TODO: 2. Insert the book into the database
        return http:CREATED;
    }

    // TODO: 3. Add the scope. Only authors can delete the book
    resource function delete books/[string bookId](@http:Header string authorization)
            returns http:NoContent|http:Forbidden|error {
        string userId = check getUserId(authorization);
        data:Book book = check dbClient->/books/[bookId];
        if userId != book.authorId {
            return {body: "You are not authorized to delete this book"};
        }
        _ = check dbClient->/books/[bookId].delete();
        return http:NO_CONTENT;
    }

    // TODO: 4. Add the scope. Only buyers can purchase the book
    resource function post books/[string bookId]/purchase(@http:Header string authorization, DeliveryAddress address)
            returns http:Created|http:Forbidden|error {
        string userId = check getUserId(authorization);
        data:Book book = check dbClient->/books/[bookId];
        data:PurchaseOrder purchaseOrder = {
            id: generateId(),
            book_id: bookId,
            buyer_id: userId,
            status: data:PENDING,
            timestamp: time:utcNow(),
            ...address
        };
        _ = check dbClient->/purchaseorders.post([purchaseOrder]);

        // TODO: 5. Reduce the remaining quantity of the book in the database.
        // TODO: 6. Use Ballerina transactions to ensure that the purchase order and the book quantity are updated atomically.
        check sendAuthorMail(book.title, book.isbn, "shammi0107@gmail.com");
        return http:CREATED;
    }

    // TODO: 7. Add the scope. Only buyers can review the book
    resource function post books/[string bookId]/review(@http:Header string authorization, string topic, string description)
            returns http:Created|http:Forbidden|error {
        // TODO: 8. Create and insert the review into the database using the db client. Return http:CREATED if successful.
    }

    // TODO: 9. Add the scope. Only admins can ban users
    resource function put users/[string userIdToBeBanned]/ban() returns http:NoContent|http:Forbidden|error {
        // TODO: 10. Update the user's status to BANNED in the database using the db client.
    }
}

function getUserId(string authenticationStr) returns string|error {
    string token = re ` `.split(authenticationStr)[1];
    byte[] decoded = check array:fromBase64(token);
    string decodedString = check string:fromBytes(decoded);
    return re `:`.split(decodedString)[2];
}
