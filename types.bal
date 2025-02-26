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

# Description.
#
# + id - book id
# + authorId - author id
# + title - book title
# + isbn - book ISBN
# + description - book description
# + price - book price
# + quantity - remaining book quantity
public type Book record {|
    readonly string id;
    string authorId;
    string title;
    string isbn;
    string description;
    float price;
    int quantity;
|};