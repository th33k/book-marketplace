// AUTO-GENERATED FILE. DO NOT MODIFY.

// This file is an auto-generated file by Ballerina persistence layer for model.
// It should not be modified by hand.

import ballerina/time;

public enum UserType {
    AUTHOR,
    BUYER,
    ADMIN
}

public enum OrderStatus {
    PENDING,
    DELIVERED,
    CANCELLED
}

public type User record {|
    readonly string id;
    string name;
    string email;
    UserType userType;
    string passwordHash;
    boolean isBanned;
|};

public type UserOptionalized record {|
    string id?;
    string name?;
    string email?;
    UserType userType?;
    string passwordHash?;
    boolean isBanned?;
|};

public type UserTargetType typedesc<UserOptionalized>;

public type UserInsert User;

public type UserUpdate record {|
    string name?;
    string email?;
    UserType userType?;
    string passwordHash?;
    boolean isBanned?;
|};

public type Book record {|
    readonly string id;
    string authorId;
    string title;
    string description;
    string isbn;
    float price;
    int quantity;
|};

public type BookOptionalized record {|
    string id?;
    string authorId?;
    string title?;
    string description?;
    string isbn?;
    float price?;
    int quantity?;
|};

public type BookTargetType typedesc<BookOptionalized>;

public type BookInsert Book;

public type BookUpdate record {|
    string authorId?;
    string title?;
    string description?;
    string isbn?;
    float price?;
    int quantity?;
|};

public type Review record {|
    readonly string id;
    string bookId;
    string buyerId;
    string topic;
    string description;
    time:Utc timestamp;
|};

public type ReviewOptionalized record {|
    string id?;
    string bookId?;
    string buyerId?;
    string topic?;
    string description?;
    time:Utc timestamp?;
|};

public type ReviewTargetType typedesc<ReviewOptionalized>;

public type ReviewInsert Review;

public type ReviewUpdate record {|
    string bookId?;
    string buyerId?;
    string topic?;
    string description?;
    time:Utc timestamp?;
|};

public type PurchaseOrder record {|
    readonly string id;
    string book_id;
    string buyer_id;
    OrderStatus status;
    string deliveryAddrLine1;
    string deliveryAddrLine2;
    string deliveryAddrCity;
    string deliveryAddrZip;
    time:Utc timestamp;
|};

public type PurchaseOrderOptionalized record {|
    string id?;
    string book_id?;
    string buyer_id?;
    OrderStatus status?;
    string deliveryAddrLine1?;
    string deliveryAddrLine2?;
    string deliveryAddrCity?;
    string deliveryAddrZip?;
    time:Utc timestamp?;
|};

public type PurchaseOrderTargetType typedesc<PurchaseOrderOptionalized>;

public type PurchaseOrderInsert PurchaseOrder;

public type PurchaseOrderUpdate record {|
    string book_id?;
    string buyer_id?;
    OrderStatus status?;
    string deliveryAddrLine1?;
    string deliveryAddrLine2?;
    string deliveryAddrCity?;
    string deliveryAddrZip?;
    time:Utc timestamp?;
|};

