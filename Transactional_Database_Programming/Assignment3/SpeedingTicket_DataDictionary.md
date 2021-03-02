##Speeding Ticket Database
####Data Dictionary

This is an effective help desk ticket system that is used in a standard IT department to manage issues. 


####User Table
Contains data about the user

|Key     |Name         |Type    |Size  |NULL/NOT NULL|Default       |Description                       |Sample            |
|:------:|:-----------:|:------:|:----:|:-----------:|:------------:|:--------------------------------:|:----------------:|
|**PK**  |UserID       |INT     |11    |NOT NULL     |IDENTITY      |_A unique sequential number_      |`1234567`         |
|-       |UserFirstName|VARCHAR |32    |NOT NULL     |              |stores the user's first name      |Jamie             |
|-       |UserLastName |VARCHAR |32    |NOT NULL     |              |stores the user's last name       |Lu                |
|-       |UserAddress  |VARCHAR |255   |NOT NULL     |              |stores the user's address         |123 Random Street |
|-       |UserPhoneNum |VARCHAR |32    |NOT NULL     |              |stores the user's contact number  |`19021234567`     |


####Staff Table
Contains data about the staff

|Key     |Name          |Type    |Size  |NULL/NOT NULL|Default       |Description                     |Sample            |
|:------:|:------------:|:------:|:----:|:-----------:|:------------:|:------------------------------:|:----------------:|
|**PK**  |StaffID       |INT     |11    |NOT NULL     |IDENTITY      |_A unique sequential number_    |`1234567`         | 
|-       |StaffFirstName|VARCHAR |32    |NOT NULL     |              |stores the staff's first name   |John              |
|-       |StaffLastName |VARCHAR |32    |NOT NULL     |              |stores the staff's last name    |Doe               |
|-       |StaffAddress  |VARCHAR |255   |NOT NULL     |              |stores the staff's address      |777 Heavenly Road |
|-       |StaffPhoneNum |VARCHAR |32    |NOT NULL     |              |stores the staff's phone number |`19021234567`     |


####Ticket Table
Contains data about the tickets generated

|Key     |Name             |Type    |Size  |NULL/NOT NULL|Default   |Description                                              |Sample               |
|:------:|:---------------:|:------:|:----:|:-----------:|:--------:|:-------------------------------------------------------:|:-------------------:|
|**PK**  |TicketID         |INT     |11    |NOT NULL     |IDENTITY  |_A unique sequential number_                             |`1234567`            |  
|-       |Issue            |VARCHAR |1024  |NOT NULL     |          |describes why the ticket was generated                   |Nothing on screen    |
|-       |DateIssued       |DATETIME|-     |NOT NULL     |          |date and time the ticket was issued                      |`2019-07-11 04:27:07`|
|-       |DateResolved     |DATETIME|-     |NULL         |          |date and time the ticket was resolved, null til resolved |`2019-07-17 04:27:07`|
|**FK**  |UserID           |INT     |11    |NULL         |          |references which user is involved in the ticket          |`1234567`            |
|**FK**  |StaffID          |INT     |11    |NULL         |          |references which staff is involved in the ticket         |`1234567`            |
|**FK**  |TicketCategoryID |INT     |11    |NOT NULL     |          |references which category the ticket belongs to          |`1234567`            |


####TicketCategory
Contains data on the different categories of tickets

|Key     |Name               |Type    |Size  |NULL/NOT NULL|Default    |Description                                     |Sample                           |
|:------:|:-----------------:|:------:|:----:|:-----------:|:---------:|:----------------------------------------------:|:-------------------------------:|
|**PK**  |TicketCategoryID   |INT     |11    |NOT NULL     |IDENTITY   |_A unique sequential number_                    |`1234567`                        |
|-       |CategoryName       |VARCHAR |32    |NOT NULL     |           |stores the name of the ticket category          |Hardware Issue                   |
|-       |CategoryDescription|VARCHAR |255   |NOT NULL     |           |stores information on the ticket category       |problem with the physical aspects|


####Comment
Contains the thread between the user and the staff member, if any.


|Key     |Name               |Type    |Size  |NULL/NOT NULL|Default      |Description                                     |Sample                                      |
|:------:|:-----------------:|:------:|:----:|:-----------:|:-----------:|:----------------------------------------------:|:------------------------------------------:|
|**PK**  |CommentID          |INT     |11    |NOT NULL     |IDENTITY     |_A unique sequential number_                    |`1234567`                                   |
|-       |CommentDate        |DATETIME|-     |NOT NULL     |CURRENT DATE |date and time comment was made                  |`2019-07-11 04:27:07`                         |
|-       |CommentMade        |VARCHAR |1024  |NOT NULL     |             |contains the comment/communication made         |I would like more information on the issue. |
|**FK**  |UserID             |INT     |11    |NULL         |             |references the user that made the comment       |`1234567`                                   |
|**FK**  |StaffID            |INT     |11    |NULL         |             |references the staff that made the comment      |`1234567`
|**FK**  |TicketID           |INT     |11    |NOT NULL     |             |references which ticket the comment belongs to  |`1234567`                                   |

   
####Task
Contains what task needs to be done to resolve the ticket

|Key     |Name               |Type    |Size  |NULL/NOT NULL|Default      |Description                                     |Sample                                      |
|:------:|:-----------------:|:------:|:----:|:-----------:|:-----------:|:----------------------------------------------:|:------------------------------------------:|
|**PK**  |TaskID             |INT     |11    |NOT NULL     |IDENTITY     |_A unique sequential number_                    |`1234567`                                   |
|-       |TaskName           |VARCHAR |32    |NOT NULL     |             |stores the name of the task                     |Warranty Repair                             |
|-       |TaskInformation    |VARCHAR |255   |NOT NULL     |             |describes the task that has to be done          |replace monitor and install it              |
|-       |DateTaskFinished   |DATETIME|-     |    NULL     |             |the date the comment entry is made              |`2019-07-11 04:27:07`                       |
|**FK**  |TicketID           |INT     |11    |NOT NULL     |             |references which ticket the task belongs to     |`1234567`                                   |
|**FK**  |StaffID            |INT     |11    |    NULL     |             |references which staff is assigned to the task  |`1234567`                                   |


####Hardware
Contains the information on a specific hardware that can be used to resolve a ticket
 
|Key     |Name                |Type      |Size  |NULL/NOT NULL|Default    |Description                                |Sample             |
|:------:|:------------------:|:--------:|:----:|:-----------:|:---------:|:-----------------------------------------:|:-----------------:|
|**PK**  |HardwareID          |INT       |11    |NOT NULL     |IDENTITY   |_A unique sequential number_               |`1234567`          |
|-       |HardwareName        |VARCHAR   |32    |NOT NULL     |           |stores the name of the item                |monitor            |
|-       |HardwareDescription |VARCHAR   |80    |NOT NULL     |           |a short description of the item            |19in x 34in screen |
|-       |PurchaseDate        |DATETIME  |-     |NOT NULL     |           |stores the date the hardware was purchased |`50.25`            |
|        |SerialNumber        |VARCHAR   |32    |NOT NULL     |           |stores the hardware's serial number        |AK07115477WQD      |                                   |



####HardwareTicket
References the many to many relationship between Ticket and Hardware

|Key            |Name               |Type      |Size  |NULL/NOT NULL|Default   |Description                                                |Sample                             |
|:-------------:|:-----------------:|:--------:|:----:|:-----------:|:--------:|:---------------------------------------------------------:|:---------------------------------:|
|**PK** **FK**  |TicketID           |INT       |11    |NOT NULL     |          |_A unique sequential number_                               |`1234567`                          |
|**PK** **FK**  |HardwareID         |INT       |11    |NOT NULL     |          |_A unique sequential number_                               |`1234567`                          |

##Check Constraints
####User Table

|Name               |Definition                                          |Actions  |Comment  |
|:-----------------:|:--------------------------------------------------:|:-------:|:-------:|
|UserPhoneNum_check | [0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9] | Drop    |         |

####Staff Table

|Name               |Definition                                          |Actions  |Comment  |
|:-----------------:|:--------------------------------------------------:|:-------:|:-------:|
|StaffPhoneNum_check | [0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9] | Drop    |         |

