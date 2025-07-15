// TODO Implement this library.
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late final AnimationController _Controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _Controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _Controller.dispose();
  }

  bool clicked = false;

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      body: Center(
          child: GestureDetector(
            onTap: () {
              if (clicked == false) {
                clicked = true;
                _Controller.forward();
              } else {
                clicked = false;
                _Controller.reverse();
              }
            },
            child: Lottie.network(
                'https://lottie.host/9baed0fd-b873-4e87-b237-356b8579f1a0/T3cbB7oWgQ.json',
                controller: _Controller),
          )
      ),
    );
  }
}