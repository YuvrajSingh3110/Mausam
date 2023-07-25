import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
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
  late String icon;
  late String? location = _currentAddress;

  String? _currentAddress;
  Position? _currentPosition;

  void startApp(String city) async {
    worker instance = worker(location: city);
    await instance.getData();

    temp = instance.temp;
    humidity = instance.humidity;
    windSpeed = instance.windSpeed;
    desc = instance.description;
    main = instance.main;
    icon = instance.icon;

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
            "main_val": main,
            "icon_val": icon,
            "city_val": location
          });
    });
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

@override
Widget build(BuildContext context) {
  // Map? search = ModalRoute.of(context)?.settings.arguments as Map?;
  // if(search?.isNotEmpty ?? false){  //if search is null it will return false
  //   location = search!['searchText'];
  // }
  //startApp(location);

  return Scaffold(
    body: SingleChildScrollView(
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 150,
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
              // const Text(
              //   "Made by Yuvraj",
              //   style: TextStyle(
              //       fontSize: 15,
              //       fontWeight: FontWeight.w500,
              //       color: Colors.white),
              // ),
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
    ),
    backgroundColor: Colors.blue[200],
  );
}
