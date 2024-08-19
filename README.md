Weather App, which shows the current weather for the following cities by default, using Open weather API.
•	London 
•	Paris

It displays 
•	Temperature
•	Humidity
•	Sunset and sunrise times of their respective tome zones.

Add functionality:
We can add new cities by tapping add button, by entering name of the city we will get the following weather details.
Ex. Hyderabad

You will receive Hyderabad’s temperature, humidity, sunrise and sunset weather details

What I have done:

•	Created Open Weather API account and App ID.
•	Project created on MVVM pattern for clean and extensibility purpose.
•	Followed the folder structure and modularized the each file as per MVVM.
•	As per the given designs developed the UI part.
•	Handled errors appropriately, added network status observers to get the network status (online/offline) based on the status, handled the app data.
•	Add functionality implemented, recently added city is displaying on top of the list (Index 0).

Approach I have followed

In Open weather API, to get the city weather details we have the following call

By city name:

We can call by city name or city Id, state code and county code

api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}

This API will fetch the single city weather details, If we have N number of cities we can’t use this API by calling each city and adding the result data in an array / list.

In our case we need to get more than one city details, by default London and Paris city details, we are fetching. In addition to that we have add functionality so we can’t use the above API.

To achieve our functionality, there is a possibility to get current weather data for several cities by making single API call

Call for several city IDs

Open weather API providing more than 200,000 locations to fetch the weather data. So I used city.list JSON file provided by the Open Weather Maps, to get the city ID.

api.openweathermap.org/data/2.5/group?id={id,..,id}&appid={API key}

Storing this JSON file in the bundle and fetching the city Id from city name, provided by the user (In add functionality).

This way we are getting the list of cities weather details and updating the details to  the list.

