import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int counter = 1;

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Activity"),
      ),
      body: Column(children: <Widget>[
        FloatingActionButton(
          onPressed: () => setState(() {
            counter += 1;
          }),
        ),
        Text("$counter")
      ]
    ),
    );
  }
}
