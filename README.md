# carRecords [![CircleCI](https://circleci.com/gh/Dragonlord47/carRecords.svg?style=svg)](https://app.circleci.com/pipelines/github/Dragonlord47)
--------------

reads car records from csv file and displays list of users gotten from a users API
This application was built using the flutter framework. Dart was used to create the user interface and the application logic.
Flutter framework allows the developer to build android and ios apps using one code base, making development of ios and android
versions of the same application quick, easy and less expensive.
----------------------------------------------------------------------

The application has two main pages, cars page and owners page.
The cars page displays a list of car owners with their vehicle information. This is read from a csv file, that is required
by the application. download from this link https://drive.google.com/file/d/1giBv3pK6qbOPo0Y02H-wjT9ULPksfBCm/view.
Save the file car_ownsers_data.csv on the android device, which the application is to be installed on.
The first page of the application is called landing page which contains two clickable buttons to navigate to the cars page and the
users page. on navigating to the cars page for the first time you will be asked to select a folder location to retrieve
the car_ownsers_data.csv before proceeeding. This is only required for the first run, for the location of the file will be saved
for subsequent usage. This page displays the car owners information as a list of cards, which can be clicked to view a car owner's full
details. The list of cars owners gotten from the csv file can be filtered by click the filter icon on the app bar. This navigates the user
to the filter page where filter options can be set to get car owners of a specific set. the user can filter the list using color, country
car model, start data, end date and gender.
The users page can be open by clicking the user page button on the landing page, on navigating to this page the 
application retrieves a list of users from the API and displays the data as list of tiles to the user. This page also 
contains a filter button on the app bar which navigates the user to a page where options like color, country and gender can be used to
generate a new list based on the selected options. To view full details for a user, you can click on a tile to navigate to the user 
details page to view all details about the user.

Note
-----
in the filter pages for both cars and users page, the color and country textFields are used to add one item to a list. so for example to 
enter japan, nigeria as filter requirements. you must enter them one by one in the country textfield followed by the enter key to add
them to the list of countries to be used in filtering the data. this process apply for colors also.

App Demo Video
--------------
https://drive.google.com/file/d/16GImYwl_BD798NQbit3SvE5KAbpzBZCg/view?usp=sharing
