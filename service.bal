import ballerina/http;

listener http:Listener bookstoreListner = new (9090);

service /api on bookstoreListner {
    resource function post auth/login() {
        
    }

    resource function get books() {
        
    }

    resource function post books/upload() {
        
    }

    resource function post books/[string bookId]/delete() {
        
    }

    resource function post books/[string bookId]/purchase() {
        
    }

    resource function post books/[string bookId]/review() {
        
    }

    resource function post users/[string userId]/ban() {
        
    }
}