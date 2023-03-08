import 'dart:convert';
import 'dart:core';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() { //init state is used when we have to parse data to different screen or through an api
    // TODO: implement initState
    super.initState();
    print("This is a init state");
  }

  @override
  void setState(VoidCallback fn) {  //set state is used to produce desired output to a user based on the interaction
    // TODO: implement setState
    super.setState(fn);
    print("Set state called");
  }

  @override
  void dispose() { //dispose is used when we go back to prev screen
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

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(  //search
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(40)
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        print("Search me");
                      },
                        child: Container(
                            child: Icon(Icons.search),
                          margin: EdgeInsets.fromLTRB(2, 0, 5, 0),
                        ),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search $city"
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
