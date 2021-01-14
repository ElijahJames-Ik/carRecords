# carRecords
--------------
badges
-----------------
https://api.codemagic.io/apps/60006ada1b08f34f7453ca1f/60006ada1b08f34f7453ca1e/status_badge.svg
reads car records from csv file
This application was built using the flutter framework. Dart was used to create the user interface and the application logic.
Flutter framework allows the developer to build android and ios using the one code base, making development of ios and android
versions of the same application quick, easy and less expensive.
----------------------------------------------------------------------
Folders
-------
Models: contains classes for users

----------------------------------------------------------------------
The application has two main pages, cars page and owners page.
The cars page displays a list of car owners with their vehicle information. This is read from a csv file, that is required
by the application. download from this link https://drive.google.com/file/d/1giBv3pK6qbOPo0Y02H-wjT9ULPksfBCm/view
download the file car_ownsers_data.csv on the android device, which the application is to be installed on.
The first page of the application called landing page contains two clickable buttons to navigate to the cars page and the
users page. on navigating to the cars page for the first time you will be asked to select a folder location to retrieve
the car_ownsers_data.csv to processed. this is only required for the first run, for the location of the file will be saved
for subsequent usage. This page displays the cars information as a list of cards, which can be clicked to view a car full
details. The users page can be open by clicking the user page button on the landing page, on navigating to this page the 
application retrieves a list of users from the API and displays the data as list of tiles to the user. To view full details
for a user, you can click on a tile to navigate to the user details page to view all details about the user.

