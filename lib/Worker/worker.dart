import 'package:http/http.dart';
import 'dart:convert';

class worker {
  late String location;
  late String temp;
  late String humidity;
  late String windSpeed;
  late String description;
  late String main;
  late String icon;

  worker({required this.location}) {
    //{named parameter}
    location = this.location;
  }

  Future<void> getData() async {
    try {
      var url = Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=68ee752b5472f87b8c57c25598770bd4');
      Response response = await get(url);
      Map data = jsonDecode(response.body);

      //location
      String getLocation = data["name"];

      //getting description
      List weatherData = data['weather'];
      Map weatherMainData = weatherData[0];
      String getMainDesc = weatherMainData['main'];
      String getDesc = weatherMainData['description'];
      //weather icon
      icon = weatherMainData['icon'];

      //getting temp,humidity
      Map tempData = data['main'];
      double getTemp = tempData['temp'] - 273.15;  //degree C
      int getHumidity = tempData['humidity'];   //%

      //getting wind speed
      Map wind = data["wind"];
      double getWindSpeed = wind["speed"] * 3.6;  //km/hr

      //assigning values
      temp = getTemp.toString();
      humidity = getHumidity.toString();
      windSpeed = getWindSpeed.toString();
      description = getDesc;
      main = getMainDesc;
      location = getLocation;
    } catch (e) {
      temp = "NA";
      humidity = "NA!";
      windSpeed = "NA";
      description = "Can't find data";
      main = "NA";
      icon = "09d";
    }   //try and catch is used to handle errors
  }
}
