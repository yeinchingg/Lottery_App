// TODO Implement this library.
import 'package:flutter/material.dart';
import 'package:lottery_app/resultPage.dart';
import 'package:lottie/lottie.dart';
import 'package:lottery_app/services/draw_service.dart';
import 'listPage.dart';

final choosingstudent = ChoosingStudent();
int index = 0;

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

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) {
                          return ListPage();
                        }
                    )
                );
              },
              icon: Icon(Icons.history),
          )
        ],
      ),
      body: Center(
          child: GestureDetector(
            onTap: () async {
              _Controller.reset();
              await _Controller.forward();
              choosingstudent.chooseStudent(index++);
              choosingstudent.deleteStudent();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context){
                        return ResultPage(name: choosingstudent.showStudent());
                      }
                  )
              );
            },
            child: Lottie.network(
                'https://lottie.host/9baed0fd-b873-4e87-b237-356b8579f1a0/T3cbB7oWgQ.json',
                controller: _Controller),
          )
      ),
    );
  }
}