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
                image: new AssetImage("frame.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Container(
              child: Lottie.network(
                "https://lottie.host/9111819e-dd4c-4dd7-9642-14a95bb7ce89/pQYsCc14II.json",
                fit: BoxFit.fill,
              ),
            ),
          ),
          FutureBuilder(
            future: _initialization,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Row(
                  children: [
                    Column(
                      children: [
                        Lottie.network(
                          // "https://lottie.host/dbd2c727-bd2b-4895-9cba-fd8c72ccf15c/VMJxvbNY8G.json",
                          // 'https://lottie.host/bc541e6a-dfc0-49fd-bba4-3c2fb79b6d88/VwGUcKFf0k.json',
                          // 'https://lottie.host/680d06cc-e594-4777-9b45-e867aa7bc42a/3SgiJthyHx.json',
                          'https://lottie.host/c7f97e36-0089-43f7-9b1f-722194fe3006/VQPngUaw9T.json',
                          width: 750,
                          height: 300,
                        ),
                        SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color:Colors.white,
                            border: Border.all(width: 5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Text(
                                '大一直屬 👉 ',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.inter(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SizedBox(width: 3),
                              Text(
                                '${currentFreshman ?? ''}',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.inter(
                                  fontSize: 70,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.deepPurpleAccent,
                                ),
                              ),
                            ],
                          ),
                        ),
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
                                currentFreshman = freshmanQueue.removeFirst();
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
                            'https://lottie.host/9baed0fd-b873-4e87-b237-356b8579f1a0/T3cbB7oWgQ.json',
                            controller: _Controller,
                            width: 200,
                            height: 200,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          SizedBox(height: 30),
                          Container(
                            width: 650,
                            height: 500,
                            decoration: new BoxDecoration(
                              image: new DecorationImage(
                                image: new AssetImage("rule.png"),
                              ),
                            ),
                          ),
                          // Row(
                          //   children: [
                          //     Container(
                          //       child: Lottie.network(
                          //         'https://lottie.host/e7665d8d-7e7c-4bf2-8866-216df20859d0/UjEwkqyPAQ.json',
                          //         width: 100,
                          //         height: 100,
                          //       ),
                          //     ),
                          //     Container(
                          //       child: Lottie.network(
                          //         'https://lottie.host/e7665d8d-7e7c-4bf2-8866-216df20859d0/UjEwkqyPAQ.json',
                          //         width: 100,
                          //         height: 100,
                          //       ),
                          //     ),
                          //     Container(
                          //       child: Lottie.network(
                          //         'https://lottie.host/e7665d8d-7e7c-4bf2-8866-216df20859d0/UjEwkqyPAQ.json',
                          //         width: 100,
                          //         height: 100,
                          //       ),
                          //     ),
                          //     Container(
                          //       child: Lottie.network(
                          //         'https://lottie.host/e7665d8d-7e7c-4bf2-8866-216df20859d0/UjEwkqyPAQ.json',
                          //         width: 100,
                          //         height: 100,
                          //       ),
                          //     ),
                          //     Container(
                          //       child: Lottie.network(
                          //         'https://lottie.host/e7665d8d-7e7c-4bf2-8866-216df20859d0/UjEwkqyPAQ.json',
                          //         width: 100,
                          //         height: 100,
                          //       ),
                          //     ),
                          //     Container(
                          //       child: Lottie.network(
                          //         'https://lottie.host/e7665d8d-7e7c-4bf2-8866-216df20859d0/UjEwkqyPAQ.json',
                          //         width: 100,
                          //         height: 100,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
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
