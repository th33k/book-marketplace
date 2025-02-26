import ballerina/uuid;

function generateId() returns string => uuid:createType1AsString();

// configurable string gmailAccessToken = ?;

// gmail:Client gmail = check new ({auth: {token: gmailAccessToken}});

// public function sendBookOrderedMail(string authorName, string authorEmail, UploadedBook book) returns error? {
//     string subject = "Book Ordered";
//     string body = "Dear " + authorName + ",\n\n" +
//                   "Your book " + book.title + " has been ordered successfully.\n\n" +
//                   "Thank you for your contribution.\n\n" +
//                   "Regards,\n" +
//                   "The Book Store Team";
//     return sendMail(recipientAddress, subject, body);
// }

// function sendMail(string recipientAddress, string subject, string body) returns error? {

//     gmail:MessageRequest message = {
//         to: [recipientAddress],
//         subject: subject,
//         bodyInText: body
//     };
//     _ = check gmail->/users/me/messages.post(message);
// }
