USE master
GO
CREATE DATABASE Online_Catering
GO
USE Online_Catering
GO

CREATE TABLE account(
	id int primary key identity(1,1),
	username varchar(100) not null unique,
	[password] varchar(max) null,
	fullname varchar(100) null,
	[address] text null,
	phone varchar(50) null,
	email varchar(100) null,
	gender bit default 1,--1: Male, 0: Female
	[role] int default 0, --1: Caterer, 2: Admin
	[status] bit default 1, -- 1: active, 0: inactive
)
GO

CREATE TABLE customer(
	id int primary key identity(1,1),
	username varchar(100) not null unique,
	[password] varchar(max) null,
	fullname varchar(100) null,
	[address] text null,
	phone varchar(50) null,
	email varchar(100) null,
	gender bit default 1,--1: Male, 0: Female
	[status] bit default 1, -- 1: active, 0: inactive
)
GO

CREATE TABLE category(
	id int primary key identity(1,1),
	name varchar(200) not null unique,
	[image] text null,
	[description] text null
)
GO
CREATE TABLE menuItem(
	id int primary key identity(1,1),
	name varchar(200) not null unique,
	[image] text null,
	price float default 0.0,
	cateId int not null,
	supplierId int not null,
	[description] text null,
	content text null,
	penance float default 0.0,
	[status] bit default 1,
)
GO



CREATE TABLE orders(
	id int primary key identity(1,1),
	cusId int not null,
	createdDate date,
	deliveryDate date,
	deliveryAddress text null,
	peoples int default 0,
	totalPrice float,
	isPaid bit default 0,--Da thanh toan hay chua
	paymentId int not null
)
GO



CREATE TABLE orderdetail(
	orderId int not null,
	menuItemId int not null,
	price float default 0.0,
	CONSTRAINT pk_order_menuitem PRIMARY KEY (orderId,menuItemId)
)
GO



CREATE TABLE favourite(
	cusId int not null,
	menuItemId int not null,
	[status] bit default 1,
	createDate date,
	CONSTRAINT pk_customer_menuitem PRIMARY KEY (cusId,menuItemId)
)
GO



CREATE TABLE orderCancel(
	orderId int not null primary key,
	moneyPenance float default 0.0,
	[status] int default 0 --Da thanh toan hay chua?
)
GO


CREATE TABLE Settings(
	id int primary key identity(1,1),
	name varchar(200) not null unique,
	content text null,
	[type] int default 1,--1:About, 2: Contact...
	[status] bit default 1,--1:active, 0:inactive
)
GO

CREATE TABLE PaymentMethod(
	id int primary key identity(1,1),
	name varchar(200) not null unique,
	[status] bit default 1,--1:active, 0:inactive
)
GO

CREATE TABLE Supplier(
	id int primary key identity(1,1),
	name varchar(200) not null unique,
	[address] text null,
	email text null,
	phone varchar(50) null,
	[status] bit default 1, --1: active, 0: inactive
)
GO

--ALTER TABLE
ALTER TABLE menuItem ADD CONSTRAINT fk_menuitem_category FOREIGN KEY (cateId) REFERENCES category(id)
ALTER TABLE menuItem ADD CONSTRAINT fk_menuitem_supplier FOREIGN KEY (supplierId) REFERENCES supplier(id)
GO

ALTER TABLE orders ADD CONSTRAINT fk_order_customer FOREIGN KEY (cusId) REFERENCES customer(id)
ALTER TABLE orders ADD CONSTRAINT fk_order_paymentmethod FOREIGN KEY (paymentId) REFERENCES paymentMethod(id)
GO

ALTER TABLE orderdetail ADD CONSTRAINT fk_orderdetail_order FOREIGN KEY (orderId) REFERENCES orders(id)
ALTER TABLE orderdetail ADD CONSTRAINT fk_orderdetail_menuitem FOREIGN KEY (menuItemId) REFERENCES menuItem(id)
GO

ALTER TABLE favourite ADD CONSTRAINT fk_favourite_menuitem FOREIGN KEY (menuItemId) REFERENCES menuItem(id)
ALTER TABLE favourite ADD CONSTRAINT fk_favourite_customer FOREIGN KEY (cusId) REFERENCES customer(id)
GO

ALTER TABLE orderCancel ADD CONSTRAINT fk_ordercancel_orders FOREIGN KEY (orderId) REFERENCES orders(id)
GO