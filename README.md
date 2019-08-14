# DICE_TEST
Dice iOS Technical Excercise

## Application is built using MVVM architecture.

1. TagListResponseModel(Model) - consists the properties related to Tag list API.
2. TagDetailResponseModel(Model) - consists the properties related to Tag detail API.
3. TagListViewController(View) - consists the actions and loading of UI objects on the view consisting of Tag List.
4. TagDetailListViewController(View) - consists the actions and loading of UI objects on the view consisting of Tag Detail List.
5. TagListViewModel(ViewModel) - consists of the business logic where the network call is made for fetching and loading the tag list data to tableview.
6. TagDetailListViewModel(ViewModel) - consists of the business logic where the network call is made for fetching and loading the tag detail list data to tableview.
7. TagListViewCell - consists the cell which is getting loaded depending on the tag list data provided
8. TagDetailListViewCell - consists the cell which is getting loaded depending on the tag detail list data provided


## Network Layer is seperate with generic methods for reading the files using URLSession. It consists of 

1. NetworkManager - Consisting of the genric protocol based methods for fetching and decoding JSONs.
2. Reachability - To check the connectivity to internet.
3. TagListGetRequest/TagListGetManager - Creation and triggering of the URL request for fetching the tags list from the json.
4. TagDetailGetRequest/TagDetailGetManager - Creation and triggering of the URL request for fetching the tags detail from the json.


## Utils classes are also present which give generic functionality which can be used throughout the applications

1. Extensions - Extensions written for classes(i.e UIViewController, DateFormatter) for adding alerts, activity indicator, convert date from string etc.
2. AppConstants - Application constants used throughout the app. Strings, Enums, Errors etc.


## Unit and UI XCTestCases with coverage of 90.5%(screenshot added).

1. TagListTests - Testing the tag list tableview with and without data.
2. TagDetailListTests - Testing the tag detail list tableview with and without data.
3. NetworkTests - Testing the NetworkManager methods
4. Dice_TestUITests - Testing the app flow, scroll down to load data, pull to refresh and UIApplication background and foreground .
