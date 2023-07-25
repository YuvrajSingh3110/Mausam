import 'dart:core';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController searchController = new TextEditingController();  //to get city name entered by the user

  @override
  void initState() {
    //init state is used when we have to parse data to different screen or through an api
    // TODO: implement initState
    super.initState();
    print("This is a init state");
  }

  @override
  void setState(VoidCallback fn) {
    //set state is used to produce desired output to a user based on the interaction
    // TODO: implement setState
    super.setState(fn);
    print("Set state called");
  }

  @override
  void dispose() {
    //dispose is used when we go back to prev screen
    // TODO: implement dispose
    super.dispose();
    print("Widget destroyed");
  }

  @override
  Widget build(BuildContext context) {
    Map? info = ModalRoute.of(context)?.settings.arguments as Map?;

    var cityName = ["New Delhi", "Mumbai", "Chennai", "Kolkata"];
    final _random = new Random();
    var city = cityName[_random.nextInt(cityName.length)];

    String temp = info!['temp_val'].toString();
    String windSpeed = info['wind_val'].toString();
    if(temp == "NA"){
      print("NA");
    }
    else{
      temp = info['temp_val'].toString().substring(0,4);
      windSpeed = info['temp_val'].toString().substring(0,4);
    }
    String icon = info['icon_val'].toString();
    String city_name = info['city_val'].toString();
    String desc = info['desc_val'].toString();
    String humidity = info['hum_val'].toString();


    return Scaffold(
      resizeToAvoidBottomInset: false,  //to avoid padding issue when keyboard is open
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: NewGradientAppBar(
          gradient: const LinearGradient(
              colors: [Colors.blueAccent, Colors.lightBlueAccent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.blueAccent, Colors.lightBlueAccent])),
            child: Column(
              children: <Widget>[
                Container(
                  //search
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(40)),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if((searchController.text).replaceAll(" ", "") == ""){
                            Fluttertoast.showToast(
                              msg: "Please enter city name",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER);
                          }else {
                            Navigator.pushReplacementNamed(context, "/loading", arguments: {
                              "searchText": searchController.text,
                            });
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: const Icon(Icons.search),
                        ),
                      ),
                      const SizedBox(width: 5,),
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: "Search $city"),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.5)),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          children: [
                            Image.network("https://openweathermap.org/img/wn/$icon@2x.png"),
                            const SizedBox(width: 20,),
                            Column(
                              children: [
                                Text(
                                 desc,
                                  style: const TextStyle(
                                      fontSize: 25, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "In $city_name",
                                  style: const TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          height: 270,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.white.withOpacity(0.5)),
                          margin:
                              const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          padding: const EdgeInsets.all(25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(WeatherIcons.thermometer),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    temp,
                                    style: const TextStyle(fontSize: 100),
                                  ),
                                  const Text(
                                    "C",
                                    style: TextStyle(fontSize: 30),
                                  ),
                                ],
                              )
                            ],
                          )),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.white.withOpacity(0.5)),
                          margin: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                          padding: const EdgeInsets.all(25),
                          height: 200,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Icon(WeatherIcons.day_windy),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Text(
                                windSpeed,
                                style: const TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              const Text("km/hr"),
                            ],
                          )),
                    ),
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.white.withOpacity(0.5)),
                          margin: const EdgeInsets.fromLTRB(10, 0, 20, 0),
                          padding: const EdgeInsets.all(25),
                          height: 200,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Icon(WeatherIcons.humidity),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Text(
                                humidity,
                                style: const TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              const Text("%"),
                            ],
                          )),
                    ),
                  ],
                ),
                const SizedBox(height: 37,),
                Container(
                    padding: const EdgeInsets.all(30),
                    child: const Text("Data provided by Openweathermap.org")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
