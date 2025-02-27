import ballerina/uuid;
import ballerinax/googleapis.gmail;
import ballerina/log;

configurable string refreshToken = ?;
configurable string clientId = ?;
configurable string clientSecret = ?;

function generateId() returns string => uuid:createType1AsString();

function sendAuthorMail(string bookTitle, string isbn, string authorEmail) returns error? {
    gmail:Client gmail = check new ({
        auth: {
            refreshToken,
            clientId,
            clientSecret
        }
    });

    // Compose the email message.

    string htmlContent = string `<html>
    <head>
        <title>Book Purchase Notification</title>
    </head>
    <body>
        <p>Dear Author,</p>
        <p>Your book ${bookTitle} with isbn: ${isbn} available on our site has been sold</p>
    </body>
    </html>`;

    gmail:MessageRequest message = {
        to: [authorEmail],
        subject: "Book Purchase Notification",
        bodyInHtml: htmlContent
    };

    // Send the email message.
    gmail:Message sendResult = check gmail->/users/me/messages/send.post(message);
    log:printInfo("Email sent. Message ID: " + sendResult.id);
}
