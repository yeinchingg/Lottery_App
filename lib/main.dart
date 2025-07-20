
import 'package:flutter/material.dart';
import 'homePage.dart';

void main () {
  // var name = ['aaa', 'bbb', 'ccc', 'ddd', 'eee'];
  // var persons = name.length;
  // while (persons > 0) {
  //   var rand = Random().nextInt(persons);
  //   print(rand);
  //   print(name[rand % persons]);
  //   name.remove(name[rand % persons]);
  //   // print(name);
  //   persons--;
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp ({Key? key}) : super (key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}