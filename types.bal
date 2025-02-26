import ballerina/http;

# Description for books to be uploaded.
#
# + title - book title
# + isbn - book ISBN
# + description - book description
# + price - book price
# + quantity - remaining book quantity
public type UploadedBook record {|
    string title;
    string isbn;
    string description;
    float price;
    int quantity;
|};

type DeliveryAddress record {|
    string deliveryAddrLine1;
    string deliveryAddrLine2;
    string deliveryAddrCity;
    string deliveryAddrZip;
|};

type Forbidden record {|
    *http:Forbidden;
    string body;
|};
