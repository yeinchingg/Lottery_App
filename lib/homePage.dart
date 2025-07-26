import 'package:flutter/material.dart';
import 'package:lottery_app/all_done_page.dart';
import 'package:lottery_app/resultPage.dart';
import 'package:lottie/lottie.dart';
import 'package:lottery_app/services/draw_service.dart';
import 'listPage.dart';
import 'dart:collection';
import 'package:lottery_app/datas/student_names.dart';
import 'package:lottery_app/services/rnwJson.dart';
import 'package:lottery_app/models/pairs.dart';

Queue<String> sophomoreQueue = Queue.from(sophomore);
String? currentSophomore;
final choosingstudent = ChoosingStudent();
int index = 0;
RnWJson json = RnWJson();

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _Controller;
  Future<void>? _initialization;

  @override
  void initState() {
    super.initState();
    _Controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    currentSophomore = sophomoreQueue.removeFirst();
    json.writeJsonToFile([], 'result');
    _initialization = rollback();
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
      body: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot){
            if (snapshot.connectionState == ConnectionState.done){
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '你的直屬： ${currentSophomore ?? ''}',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),

                  GestureDetector(
                    onTap: () async {
                      _Controller.reset();
                      await _Controller.forward();
                      choosingstudent.chooseStudent(index++);
                      final chosen = choosingstudent.showStudent();
                      choosingstudent.deleteStudent();

                      if (sophomoreQueue.isNotEmpty) {
                        setState(() {
                          currentSophomore = sophomoreQueue.removeFirst();
                        });
                      } else {
                        setState(() {
                          currentSophomore = null;
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => AllDonePage()),
                          );
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
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          })

    );
  }

  rollback() async {
    DrawPairs pair = DrawPairs();
    List? temp = await json.readJsonFromFile('temp');
    if (temp != null && temp.isNotEmpty) {
      for (var element in temp) {
        if (element is Map<String, dynamic>) {
          String sophoValue = element['sopho'];
          String freshValue = element['fresh'];
          pair.pushSopho(sophoValue);
          pair.pushFresh(freshValue);
          index++;
          print('Sopho: $sophoValue, Fresh: $freshValue');
        } else {
          print('Warning: List element is not a Map: $element');
        }
      }
      for (int i=0; i<index; i++) {
        currentSophomore = sophomoreQueue.removeFirst();
      }
      for (var paired in pairedFresh) {
        for (int i=0; i<freshman.length; i++) {
          if (freshman[i] == paired) {
            freshman.removeAt(i);
            break;
          }
        }
      }
    } else {
      print('The list is empty or null. No elements to process.');
    }
    if (mounted) {
      setState(() {});
    }
  }
}

// sophomore.forEach((name) {
// print('學生：$name');
// });
