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

void equalizeLists() {
  int lenF = freshman.length;
  int lenS = sophomore.length;
  final rand = Random();

  print('⚙️ equalizeLists 被呼叫了');
  if (lenF == lenS) {
    print('🎯 名單數量相等 ($lenF)，不需補齊');
    return;
  }

  if (lenF < lenS) {
    for (int i = 0; i < lenS - lenF; i++) {
      freshman.add(freshman[rand.nextInt(lenF)]);
    }
  } else {
    for (int i = 0; i < lenF - lenS; i++) {
      sophomore.add(sophomore[rand.nextInt(lenS)]);
    }
  }

  print('✅ 補齊後的大一名單: $freshman');
  print('✅ 補齊後的大二名單: $sophomore');
}


