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
import 'package:audioplayers/audioplayers.dart';
import 'package:google_fonts/google_fonts.dart';

late Queue<String> freshmanQueue;

String? currentFreshman;
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
    equalizeLists();

    freshmanQueue = Queue.from(freshman);

    currentFreshman = freshmanQueue.removeFirst();
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
    return new Scaffold(
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
      body: new Stack(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("planetBackground.gif"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Center(
          //   child: Container(
          //     child: Lottie.network(
          //       "https://lottie.host/9111819e-dd4c-4dd7-9642-14a95bb7ce89/pQYsCc14II.json",
          //       fit: BoxFit.fill,
          //     ),
          //   ),
          // ),
          FutureBuilder(
            future: _initialization,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 30),
                        Column(
                          children: [
                            SizedBox(height: 180,),
                            Lottie.network(
                              'https://lottie.host/c7f97e36-0089-43f7-9b1f-722194fe3006/VQPngUaw9T.json',
                              width: 400,
                              height: 180,
                            ),
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    '大一直屬   ',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.inter(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  SizedBox(width: 8 ),
                                  Text(
                                    '${currentFreshman ?? ''}',
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.inter(
                                      fontSize: 60,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.deepPurple[800],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    'Pull the lever 👉👉👉👉 ',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.inter(
                                      fontSize: 35,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Center(
                          child: Column(
                            children: [
                              SizedBox(height: 300),
                              GestureDetector(
                                onTap: () async {
                                  _Controller.reset();
                                  await _Controller.forward();
                                  choosingstudent.chooseStudent(index);
                                  choosingstudent.storeStudent(index++);
                                  final chosen = choosingstudent.showStudent();
                                  choosingstudent.deleteStudent();

                                  if (freshmanQueue.isNotEmpty) {
                                    setState(() {
                                      currentFreshman = freshmanQueue
                                          .removeFirst();
                                    });
                                  } else {
                                    setState(() {
                                      currentFreshman = null;
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AllDonePage(),
                                        ),
                                      );
                                    });
                                  }
                                  playSound();
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
                                  // 'https://lottie.host/9baed0fd-b873-4e87-b237-356b8579f1a0/T3cbB7oWgQ.json',
                                 'https://lottie.host/cb30d6de-ff10-48ce-9cbf-637e1fb0f6ad/d3eB349ROi.json',
                                  controller: _Controller,
                                  width: 350,
                                  height: 350,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(height: 250),
                            Container(
                              width: 400,
                              height: 350,
                              decoration: new BoxDecoration(
                                image: new DecorationImage(
                                  image: new AssetImage("rule.png"),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 30),
                      ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
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
      for (int i = 0; i < index; i++) {
        currentFreshman = freshmanQueue.removeFirst();
      }
      for (var paired in pairedSopho) {
        for (int i = 0; i < sophomore.length; i++) {
          if (sophomore[i] == paired) {
            sophomore.removeAt(i);
            break;
          }
        }
      }
    } else {
      print('The temp list is empty or null. No elements to process.');
    }
    if (mounted) {
      setState(() {});
    }
  }
}

Future<void> playSound() async {
  final player = AudioPlayer();
  String audioPath = 'biubiubiu.m4a';
  await player.play(AssetSource(audioPath));
}
