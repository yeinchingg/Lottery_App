import 'package:flutter/material.dart';
import 'package:lottery_app/resultPage.dart';
import 'package:lottie/lottie.dart';
import 'package:lottery_app/services/draw_service.dart';
import 'listPage.dart';
import 'dart:collection';
import 'package:lottery_app/datas/student_names.dart';

Queue<String> sophomoreQueue = Queue.from(sophomore);
String? currentSophomore;
final choosingstudent = ChoosingStudent();

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _Controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _Controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    if (sophomoreQueue.isNotEmpty) {
      currentSophomore = sophomoreQueue.removeFirst();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _Controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ListPage();
                  },
                ),
              );
            },
            icon: Icon(Icons.history),
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Text(
                '你的直屬：',
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              (sophomoreQueue.isNotEmpty || currentSophomore != null)
                  ? Text(
                      currentSophomore ?? '',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    )
                  : Text(
                      "沒人啦",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
            ],
          ),

          GestureDetector(
            onTap: () async {
              _Controller.reset();
              await _Controller.forward();
              choosingstudent.chooseStudent();
              final chosen = choosingstudent.showStudent();
              choosingstudent.deleteStudent();

              if (sophomoreQueue.isNotEmpty) {
                setState(() {
                  currentSophomore = sophomoreQueue.removeFirst();
                });
              }else {
                setState(() {
                  currentSophomore = null;
                });
              }

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ResultPage(name: chosen);
                  },
                ),
              );
            },
            child: Lottie.network(
              'https://lottie.host/9baed0fd-b873-4e87-b237-356b8579f1a0/T3cbB7oWgQ.json',
              controller: _Controller,
            ),
          ),
        ],
      ),
    );
  }
}
