# WeatherApp
A weather App, fetching data from openweathermap's API. 

This app takes current latitude and longitude (if user allows) and displays its Weather details. If user does not choose that, he/she can enter city in search bar and can see its weather details or can even search by map as well. Following are its button functionalities :

<b>Search bar : </b> Enter City Name and it will show you its details

<b>Save this City :</b> It saves city, so that users can access it later on from "Menu" button on top and see its weather details

<b>Next 15 days:</b> This takes to new view, where next 15 days forecast can be seen. Right now, we can only search for cities which are “one word“ for instance, we can see 15 days forecast for “Paris”, but can not see for “New York”. Also, it will not show 15 days forecast for cities with Special Characters in them. These are certain limitations for now, can be removed later on.

<b>Menu:</b> It is empty initially but users can fill it by clicking "Save this City", so that they can easily access the saved "city" and see that city's weather conditions. This list stays saved even if app is closed and opened again.

<b>SEARCH BY MAP:</b> It takes to another view, where map is shown. By "long press gesture", temperature and description of weather is shown for that specific location
