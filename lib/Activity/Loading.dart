import 'package:flutter/material.dart';
import 'package:mausam/Worker/worker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  late String temp;
  late String humidity;
  late String windSpeed;
  late String desc;
  late String main;

  void startApp() async {
    worker instance = worker(location: "Mumbai");
    await instance.getData();

    temp = instance.temp;
    humidity = instance.humidity;
    windSpeed = instance.windSpeed;
    desc = instance.description;
    main = instance.main;

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(
          //loading screen will be replaced by home screen and back button would not navigate back to loading screen
          context,
          '/home',
          arguments: {
            "temp_val": temp,
            "hum_val": humidity,
            "wind_val": windSpeed,
            "desc_val": desc,
            "main_val": main
          });
    });
  }

  @override
  void initState() {
    startApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 60,
              ),
              Image.asset(
                "images/weather.png",
                height: 150,
                width: 150,
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Mausam App",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const Text(
                "Made by Yuvraj",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 100,
              ),
              const SpinKitDoubleBounce(
                color: Colors.white,
                size: 50.0,
              )
            ],
          ),
        ),
      ),
      backgroundColor: Colors.blue[200],
    );
  }
}
