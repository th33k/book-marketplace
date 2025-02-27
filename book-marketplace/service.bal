import book_marketplace.data;

import ballerina/http;
import ballerina/persist;
import ballerina/time;

listener http:Listener bookstoreListner = new (9090);
final data:Client dbClient = check new ();

service /book\-marketplace/api/v1 on bookstoreListner {
    resource function get books() returns data:Book[]|error {
        stream<data:Book, persist:Error?> bookStream = dbClient->/books;
        return from data:Book book in bookStream
            select book;
    }

    resource function post books/upload(@http:Header string userId, UploadedBook uploadedBook)
            returns http:Created|http:Forbidden|error {
        if check isInvalidUserType(userId, "AUTHOR") {
            return <http:Forbidden>{body: "You are not authorized to upload a book"};
        }
        data:BookInsert bookInsert = {
            id: generateId(),
            authorId: userId,
            ...uploadedBook
        };
        _ = check dbClient->/books.post([bookInsert]);
        return http:CREATED;
    }

    resource function delete books/[string bookId](@http:Header string userId)
            returns http:NoContent|http:Forbidden|error {
        if check isInvalidUserType(userId, "AUTHOR") {
            return {body: "You are not authorized to upload a book"};
        }
        data:Book book = check dbClient->/books/[bookId];
        if userId != book.authorId {
            return {body: "You are not authorized to delete this book"};
        }
        _ = check dbClient->/books/[bookId].delete();
        return http:NO_CONTENT;
    }

    resource function post books/[string bookId]/purchase(@http:Header string userId, DeliveryAddress address)
            returns http:Created|http:Forbidden|error {
        if check isInvalidUserType(userId, "BUYER") {
            return <http:Forbidden>{body: "You are not authorized to purchase a book"};
        }
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

    resource function post books/[string bookId]/review(@http:Header string userId, string topic, string description)
            returns http:Created|http:Forbidden|error {
        if check isInvalidUserType(userId, "BUYER") {
            return <http:Forbidden>{body: "You are not authorized to review a book"};
        }
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

    resource function put users/[string userIdToBeBanned]/ban(@http:Header string userId) returns http:NoContent|http:Forbidden|error {
        if check isInvalidUserType(userId, "ADMIN") {
            return <http:Forbidden>{body: "You are not authorized to ban a user"};
        }
        _ = check dbClient->/users/[userIdToBeBanned].put({isBanned: true});
        return http:NO_CONTENT;
    }
}

function isInvalidUserType(string userId, string userType) returns boolean|error {
    data:User user = check dbClient->/users/[userId];
    return user.userType != userType;
}
