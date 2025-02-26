import ballerina/http;
import book_marketplace.data;
import ballerina/persist;
import ballerina/time;

listener http:Listener bookstoreListner = new (9090);
final data:Client dbClient = check new ();

service /api on bookstoreListner {
    resource function post auth/login() {
        // TODO: Implement login
    }

    resource function get books() returns data:Book[]|error {
        stream<data:Book, persist:Error?> bookStream = dbClient->/books;
        return from data:Book book in bookStream select book;
    }

    resource function post books/upload(UploadedBook uploadedBook) returns http:Created|error {
        // TODO: get user Id && validate if type is author
        string authorId = "";
        data:BookInsert bookInsert = {
            id: generateId(),
            authorId,
            ...uploadedBook
        };
        _ = check dbClient->/books.post([bookInsert]);
        return http:CREATED;
    }

    resource function delete books/[string bookId]() returns http:NoContent|Forbidden|error {
        // TODO: get user Id && validate if type is author
        string authorId = "";
        data:Book book = check dbClient->/books/[bookId];
        if (authorId != book.authorId) {
            return {body: "You are not authorized to delete this book"};
        }
        _ = check dbClient->/books/[bookId].delete();
        return http:NO_CONTENT;
    }

    resource function post books/[string bookId]/purchase(DeliveryAddress address) returns http:Created|error {
        // TODO: get user id and validate if the type is buyer
        string buyerId = "";
        data:Book book = check dbClient->/books/bookId;
        data:PurchaseOrder purchaseOrder = {
            id: generateId(),
            book_id: bookId,
            buyer_id: buyerId,
            status: data:PENDING,
            timestamp: time:utcNow(),
            ...address
        };
        transaction {
            _ = check dbClient->/purchaseorders.post([purchaseOrder]);
            _ = check dbClient->/books/[bookId].put({quantity: book.quantity - 1});
            check commit;
        }
        return http:CREATED;
    }

    resource function post books/[string bookId]/review(string topic, string description) returns http:Created|error {
        // TODO: get user id and validate if the type is buyer
        string buyerId = "";
        data:ReviewInsert review = {
            id: generateId(),
            bookId: bookId,
            buyerId: buyerId,
            topic,
            description,
            timestamp: time:utcNow()
        };
        _ = check dbClient->/reviews.post([review]);
        return http:CREATED;
    }

    resource function put users/[string userId]/ban() returns http:NoContent|error {
        // TODO: get user Id && validate if type is admin
        _ = check dbClient->/users/[userId].put({isBanned: true});
        return http:NO_CONTENT;
    }
}
