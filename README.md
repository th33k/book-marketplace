# book-marketplace

This sample project is a book marketplace where,
- Sellers can sell books.
- Buyers can buy books from sellers.
- Admin can ban sellers and buyers.

![Overview of the book market](/resources/er_diagram.png)

You will learn the following topics by completing the tasks in this project.

1. Writing REST APIs
2. Using `bal persist` to connect with databases
3. Adding configurable variables
4. Ballerina package structure
5. Using connectors - gmail
6. Writing unit tests.
7. OAuth2 authentication

## Notes

### Note 1

Start the oauth ballerina-sts service by executing the following command.

```bash
$ cd ballerina-sts
$ bal run sts
```

This will start a service that will provide the oauth2 functionality for the book-marketplace service.

### Note 2

Gmail API configurations can be obtained from [this google doc](https://docs.google.com/document/d/1i_nlEQeNwMTICqpGNAswIGlaj1nPJmiyZsP6PVrzCh4/edit?usp=sharing).

### Step 3

You can use [this postman collection](https://www.postman.com/sasnaka/workspace/uom/collection/8343289-0fe2a425-352e-4614-be7c-e46f5da5d8b4?action=share&creator=8343289) to test the APIs. Note that there is a header `Authorization` that is already set. This header contains the token from the oauth service.
