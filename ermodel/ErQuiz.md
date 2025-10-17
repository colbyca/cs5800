1. Buys(Title, Name, Location) 
2. Person(<u>ID</u>, Favorite), Person(Favorite) is a foreign key onto Person(<u>ID</u>)
3. Customer(<u>CustomerID</u>,FriendID,City,State,Street)
4. PreferredCustomer(<u>CustomerID</u>, Discount), PreferredCustomer(<u>CustomerID</u>) is a f.k. onto Customer(<u>CustomerID</u>) 
5. Employee(<u>CustomerID</u>, MID), Employee(MID) is a f.k. onto Employee(CustomerID) 
6.  Student(ID, Name, Age, Birthdate)
EnrolledIn(ID, Code)
Subject(Code)
EnrolledIn(ID) is a f.k. onto Student(ID)
EnrolledIn(Code) is a f.k. onto Subject(Code) 

7. University(<u>Name</u>)
8. weak entity type
9. multi-valued attribute