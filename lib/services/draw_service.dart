import 'package:lottery_app/datas/student_names.dart';
import 'package:lottery_app/models/pairs.dart';
import 'dart:math';
import 'rnwJson.dart';

class ChoosingStudent {
  RnWJson json = RnWJson();
  DrawPairs pairs = DrawPairs();
  Random rand = Random();
  late int stdnum;
  late String stdname;
  final int numOfFresh = freshman.length;

  void chooseStudent(int index) async {
    stdnum = rand.nextInt(freshman.length);
    stdname = freshman[stdnum];
    pairs.pushFresh(stdname);
    pairs.pushSopho(sophomore.elementAt(index));
  }

  void storeStudent(int index) async{
    List? temp = await json.readJsonFromFile('temp');
    Map<String, dynamic> newData = {
      'sopho': sophomore.elementAt(index),
      'fresh': stdname,
    };
    temp?.add(newData);
    json.writeJsonToFile(temp!, 'temp');
    if (index + 1 >= numOfFresh) {
      json.writeJsonToFile(temp, 'result');
      json.writeJsonToFile([], 'temp');
    }
    print(temp);
  }

  String showStudent() {
    return stdname;
  }

  deleteStudent() {
    freshman.removeAt(stdnum);
  }

  List<String> getRemaining() => freshman;
}



