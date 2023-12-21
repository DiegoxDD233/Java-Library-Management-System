Library Management System

Tech Stack: Servlet,  Java Server Page(jsp), c3p0 for database connections, BdUtils, BeanUtils. MD5 for hashing
Environment: JDK 1.8, tomcat 8.5, Mysql 5.7, eclipse IDE, Navicat. 

Project Description: (See the demo Video)
I built up a Library Management System to help to manage books and readers. As a reader, 
you could log into the system and search the desired book you want. You could also see the
popular book recommendation to see what books you want. Once you find the desired book, 
you could borrow this book and it would be shown in the Borrowing Information. And once you 
returned this, this would be shown in Borrowing History. Also, as a reader, you could see the 
Best Readers part to see who rented the most books, and give feedback through Feedback 
options. As an administrator, you could log in as an admin user to manage readers and books. 
You could add a new book, delete and change a current book, and modify the book's genre. 

Step to run this project:
Environment: Eclipse IDE, tomcat 8.5, Mysql, Navicat.
1.Import project through eclipse
2.Set up database, we used Navicat
-Create connections: Host:localhost, Port 3306, User Name: root, password: root
-Create database named books. Execute the SQL file named books.sql in to set up database.
-Connect them (Turn green light in Navicat)
3.In eclipse, right click the project name and get into “properties” page, in project facets, make sure “Dynamic Web Module”, “Java”, 
4.Then also in “Properties”, in Java Build Path Page, Add libraries named “Server Runtime” and choose the tomcat version you have
5.Create servers in “Servers” tab, 
Double click the server you create, in the Server Setting page, choose the second option “Use Tomcat installation” in Server Location options. Ctrl S to save. 
Then right click the server, go to add and remove options, add the project into. 

6.Use any Internet browser, go to page: http://localhost:8080/books , you can start looking at the project. 


all the user and admin password are set to 123456, you cannot see it directly in database, since they are encrypted.
you may add or delete account, logging as admin, and do it in user management menu.

all the project is a java dynamic project, which you can find inside the books folder

If you have any question, feel free to ask me at: zw3762@nyu.edu  ^^
