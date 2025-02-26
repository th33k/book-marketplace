import ballerina/persist as _;
import ballerina/time;
import ballerina/sql;

# Description.
#
# + id - user id  
# + name - user name
# + email - user email
# + userType - user type
# + passwordHash - salted user password hash
# + isBanned - user ban status
public type User record {|
    readonly string id;
    string name;
    string email;
    @sql:Column { name: "user_type"}
    UserType userType;
    @sql:Column { name: "password_hash"}
    string passwordHash;
    @sql:Column { name: "is_banned"}
    boolean isBanned;
|};

# Description.
#
# + id - book id
# + authorId - author id
# + title - book title
# + isbn - book ISBN
# + price - book price
# + quantity - remaining book quantity
public type Book record {|
    readonly string id;
    @sql:Column { name: "author_id"}
    string authorId;
    string title;
    string isbn;
    float price;
    int quantity;
|};

# Description.
#
# + id - review id
# + bookId - book id
# + buyerId - buyer id
# + topic - topic of the review
# + description - review description
# + timestamp - review timestamp
public type Review record {|
    readonly string id;
    @sql:Column { name: "book_id"}
    string bookId;
    @sql:Column { name: "buyer_id"}
    string buyerId;
    string topic;
    string description;
    time:Utc timestamp;
|};

# Description.
#
# + id - purchase order id
# + book_id - book id
# + buyer_id - buyer id
# + status - order status
# + deliveryAddrLine1 - address line 1
# + deliveryAddrLine2 - address line 2
# + deliveryAddrCity - address city
# + deliveryAddrZip - address zip
# + timestamp - order timestamp
public type PurchaseOrder record {|
    readonly string id;
    string book_id;
    string buyer_id;
    OrderStatus status;
    @sql:Column { name: "delivery_addr_line1"}
    string deliveryAddrLine1;
    @sql:Column { name: "delivery_addr_line2"}
    string deliveryAddrLine2;
    @sql:Column { name: "delivery_addr_city"}
    string deliveryAddrCity;
    @sql:Column { name: "delivery_addr_zip"}
    string deliveryAddrZip;
    time:Utc timestamp;
|};

public enum UserType {
    AUTHOR,
    BUYER,
    ADMIN
};

public enum OrderStatus {
    PENDING,
    DELIVERED,
    CANCELLED
};
