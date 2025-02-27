
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

# Description for delivery address.
# 
# + deliveryAddrLine1 - address line 1
# + deliveryAddrLine2 - address line 2
# + deliveryAddrCity - address city
# + deliveryAddrZip - address zip
public type DeliveryAddress record {|
    string deliveryAddrLine1;
    string deliveryAddrLine2;
    string deliveryAddrCity;
    string deliveryAddrZip;
|};
