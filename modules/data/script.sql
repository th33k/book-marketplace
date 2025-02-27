-- AUTO-GENERATED FILE.

-- This file is an auto-generated file by Ballerina persistence layer for model.
-- Please verify the generated scripts and execute them against the target DB server.

DROP TABLE IF EXISTS "User";
DROP TABLE IF EXISTS "Book";
DROP TABLE IF EXISTS "PurchaseOrder";
DROP TABLE IF EXISTS "Review";

CREATE TABLE "Review" (
	"id" VARCHAR(191) NOT NULL,
	"bookId" VARCHAR(191) NOT NULL,
	"buyerId" VARCHAR(191) NOT NULL,
	"topic" VARCHAR(191) NOT NULL,
	"description" VARCHAR(191) NOT NULL,
	"timestamp" TIMESTAMP NOT NULL,
	PRIMARY KEY("id")
);

CREATE TABLE "PurchaseOrder" (
	"id" VARCHAR(191) NOT NULL,
	"book_id" VARCHAR(191) NOT NULL,
	"buyer_id" VARCHAR(191) NOT NULL,
	"status" VARCHAR(9) CHECK ("status" IN ('PENDING', 'DELIVERED', 'CANCELLED')) NOT NULL,
	"deliveryAddrLine1" VARCHAR(191) NOT NULL,
	"deliveryAddrLine2" VARCHAR(191) NOT NULL,
	"deliveryAddrCity" VARCHAR(191) NOT NULL,
	"deliveryAddrZip" VARCHAR(191) NOT NULL,
	"timestamp" TIMESTAMP NOT NULL,
	PRIMARY KEY("id")
);

CREATE TABLE "Book" (
	"id" VARCHAR(191) NOT NULL,
	"authorId" VARCHAR(191) NOT NULL,
	"title" VARCHAR(191) NOT NULL,
	"description" VARCHAR(191) NOT NULL,
	"isbn" VARCHAR(191) NOT NULL,
	"price" FLOAT NOT NULL,
	"quantity" INT NOT NULL,
	PRIMARY KEY("id")
);

CREATE TABLE "User" (
	"id" VARCHAR(191) NOT NULL,
	"name" VARCHAR(191) NOT NULL,
	"email" VARCHAR(191) NOT NULL,
	"userType" VARCHAR(6) CHECK ("userType" IN ('AUTHOR', 'BUYER', 'ADMIN')) NOT NULL,
	"passwordHash" VARCHAR(191) NOT NULL,
	"isBanned" BOOLEAN NOT NULL,
	PRIMARY KEY("id")
);


