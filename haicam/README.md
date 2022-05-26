# Wadera - Android & iOS App 

 Consumer app using Flutter 3.0.0.
 
 ## Design Pattern

 - BLOC design pattern becuase it seprates UI from logic, seperate unit tests are easier and code is event driven. Coordinator/Router Pattern is used to segregate and manage UI routing. independently. 

 ## Project Structure

 - Project is divided into respective folders as the folder name describes.
 - Features Folder: Each feature folder has its own Model, View, Services and router folders.
 - There are commons and helper folder which have global app constans and common utility functions.

 ## Logic

 - All views are added programmatically.
 - There are base classes for view controller and tablle view cell.

 ## Testing 

 - Unit/UI tests.
