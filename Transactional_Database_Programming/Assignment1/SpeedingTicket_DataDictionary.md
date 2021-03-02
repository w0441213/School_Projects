##Speeding Ticket Database
####Data Dictionary

This is an effective help desk ticket system that is used in a standard IT department to manage issues. 


####User Table
Contains data about the user

|Key     |Name         |Type    |Size  |NULL/NOT NULL|Default   |Description                       |Sample            |
|:------:|:-----------:|:------:|:----:|:-----------:|:--------:|:--------------------------------:|:----------------:|
|**PK**  |UserID       |INT     |11    |NOT NULL     |IDENTITY  |_A unique sequential number_      |`1234567`         |
|-       |UserFirstName|VARCHAR |32    |NOT NULL     |NAME      |stores the user's first name      |Jamie             |
|-       |UserLastName |VARCHAR |32    |NOT NULL     |NAME      |stores the user's last name       |Lu                |
|-       |UserAddress  |VARCHAR |255   |NOT NULL     |ADDRESS   |stores the user's address         |123 Random Street |
|-       |UserPhoneNum |INT     |11    |NOT NULL     |IDENTITY  |stores the user's contact number  |`19021234567`     |


####Staff Table
Contains data about the staff

|Key     |Name          |Type    |Size  |NULL/NOT NULL|Default   |Description                     |Sample            |
|:------:|:------------:|:------:|:----:|:-----------:|:--------:|:------------------------------:|:----------------:|
|**PK**  |StaffID       |INT     |11    |NOT NULL     |IDENTITY  |_A unique sequential number_    |`1234567`         | 
|-       |StaffFirstName|VARCHAR |32    |NOT NULL     |NAME      |stores the staff's first name   |John              |
|-       |StaffLastName |VARCHAR |32    |NOT NULL     |NAME      |stores the staff's last name    |Doe               |
|-       |StaffAddress  |VARCHAR |255   |NOT NULL     |ADDRESS   |stores the staff's address      |777 Heavenly Road |
|-       |StaffPhoneNum |INT     |11    |NOT NULL     |IDENTITY  |stores the staff's phone number |`19021234567`     |


####Ticket Table
Contains data about the tickets generated

|Key     |Name         |Type    |Size  |NULL/NOT NULL|Default   |Description                                              |Sample               |
|:------:|:-----------:|:------:|:----:|:-----------:|:--------:|:-------------------------------------------------------:|:-------------------:|
|**PK**  |TicketID     |INT     |11    |NOT NULL     |IDENTITY  |_A unique sequential number_                             |`1234567`            |  
|-       |Issue        |VARCHAR |1024  |NOT NULL     |ISSUE     |describes why the ticket was generated                   |Nothing on screen    |
|-       |DateIssued   |DATETIME|-     |NOT NULL     |DATETIME  |date and time the ticket was issued                      |`2019-07-11 04:27:07`|
|-       |DateResolved |DATETIME|-     |NULL         |DATETIME  |date and time the ticket was resolved, null til resolved |`2019-07-17 04:27:07`|
|-       |Hardware     |VARCHAR |32    |NULL         |NAME      |the part/hardware that has an issue, if any              |Monitor              |
|**FK**  |UserID       |INT     |11    |NOT NULL     |IDENTITY  |references which user is involved in the ticket          |`1234567`            |
|**FK**  |StaffID      |INT     |11    |NOT NULL     |IDENTITY  |references which staff is involved in the ticket         |`1234567`            |
|**FK**  |CategoryID   |INT     |11    |NOT NULL     |IDENTITY  |references which category the ticket belongs to          |`1234567`            |


####TicketCategory
Contains data on the different categories of tickets

|Key     |Name               |Type    |Size  |NULL/NOT NULL|Default    |Description                                     |Sample                           |
|:------:|:-----------------:|:------:|:----:|:-----------:|:---------:|:----------------------------------------------:|:-------------------------------:|
|**PK**  |CategoryID         |INT     |11    |NOT NULL     |IDENTITY   |_A unique sequential number_                    |`1234567`                        |
|-       |CategoryName       |VARCHAR |32    |NOT NULL     |NAME       |stores the name of the ticket category          |Hardware Issue                   |
|-       |CategoryDescription|VARCHAR |255   |NOT NULL     |DESCRIPTION|stores information on the ticket category       |problem with the physical aspects|


####Comment
Contains the thread between the user and the staff member, if any.


|Key     |Name               |Type    |Size  |NULL/NOT NULL|Default   |Description                                     |Sample                                      |
|:------:|:-----------------:|:------:|:----:|:-----------:|:--------:|:----------------------------------------------:|:------------------------------------------:|
|**PK**  |CommentID          |INT     |11    |NOT NULL     |IDENTITY  |_A unique sequential number_                    |`1234567`                                   |
|-       |CommentDate        |DATETIME|-     |NOT NULL     |DATE      |date and time comment was made                  |`2019-07-11 04:27:07`                         |
|-       |Comment            |VARCHAR |1024  |NOT NULL     |COMMENT   |contains the comment/communication made         |I would like more information on the issue. |
|-       |Commenter          |BIT     |-     |NOT NULL     |IDENTITY  |describes who made the comment(user/staff)      |User                                        |
|**FK**  |TicketID           |INT     |11    |NOT NULL     |IDENTITY  |references which ticket the comment belongs to  |`1234567`                                   |

   
####Task
Contains what task needs to be done to resolve the ticket

|Key     |Name               |Type    |Size  |NULL/NOT NULL|Default    |Description                                     |Sample                                      |
|:------:|:-----------------:|:------:|:----:|:-----------:|:---------:|:----------------------------------------------:|:------------------------------------------:|
|**PK**  |TaskID             |INT     |11    |NOT NULL     |IDENTITY   |_A unique sequential number_                    |`1234567`                                   |
|-       |TaskName           |VARCHAR |32    |NOT NULL     |NAME       |stores the name of the task                     |Warranty Repair                             |
|-       |TaskInformation    |VARCHAR |255   |NOT NULL     |DESCRIPTION|describes the task that has to be done          |replace monitor and install it              |
|**FK**  |TicketID           |INT     |11    |NOT NULL     |IDENTITY   |references which ticket the task belongs to     |`1234567`                                   |


####Item
Contains the information on a specific item that can be used to resolve a ticket through a task
 
|Key     |Name               |Type      |Size  |NULL/NOT NULL|Default    |Description                           |Sample             |
|:------:|:-----------------:|:--------:|:----:|:-----------:|:---------:|:------------------------------------:|:-----------------:|
|**PK**  |ItemID             |INT       |11    |NOT NULL     |IDENTITY   |_A unique sequential number_          |`1234567`          |
|-       |ItemName           |VARCHAR   |32    |NOT NULL     |NAME       |stores the name of the item           |monitor            |
|-       |ItemDescription    |VARCHAR   |80    |NOT NULL     |DESCRIPTION|a short description of the item       |19in x 34in screen |
|-       |ItemPrice          |SMALLMONEY|-     |NOT NULL     |AMOUNT     |price per unit of the item            |`50.25`            |


####Purchase
Contains the information on the purchase made (if any) to get the item/s needed for the ticket to be resolved

|Key     |Name               |Type      |Size  |NULL/NOT NULL|Default   |Description                                                |Sample                             |
|:------:|:-----------------:|:--------:|:----:|:-----------:|:--------:|:---------------------------------------------------------:|:---------------------------------:|
|**PK**  |PurchaseID         |INT       |11    |NOT NULL     |IDENTITY  |_A unique sequential number_                               |`1234567`                          |
|-       |Quantity           |INT       |11    |NOT NULL     |IDENTITY  |contains the number of items ordered to supplement the task|`12`                               |
|-       |PurchaseTotal      |SMALLMONEY|-     |NOT NULL     |AMOUNT    |contains the cost of the items ordered                     |`100.50`                           |
|**FK**  |TaskID             |INT       |11    |NOT NULL     |IDENTITY  |_A unique sequential number_                               |`1234567`                          |
|**FK**  |ItemID             |INT       |11    |NOT NULL     |IDENTITY  |_A unique sequential number_                               |`1234567`                          |