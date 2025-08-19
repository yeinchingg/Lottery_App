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
  final int numOfFresh =  sophomore.length;

  void chooseStudent(int index) async {
    stdnum = rand.nextInt( sophomore.length);
    stdname =  sophomore[stdnum];
    pairs.pushSopho(stdname);
    pairs.pushFresh(freshman.elementAt(index));
  }

  void storeStudent(int index) async{
    List? temp = await json.readJsonFromFile('temp');
    Map<String, dynamic> newData = {
      'fresh': sophomore.elementAt(index),
      'sopho': stdname,
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

  print('⚙️ equalizeLists 被呼叫了');
  if (lenF == lenS) {
    print('🎯 名單數量相等 ($lenF)，不需補齊');
    return;
  }

  if (lenF < lenS) {
    for (int i = 0; i < lenS - lenF; i++) {
      bool added = false;
      while (!added) {added = pick(lenF, 'fresh');}
    }
  } else {
    for (int i = 0; i < lenF - lenS; i++) {
      bool added = false;
      while (!added) {added = pick(lenS, 'sopho');}
    }
  }

  print('✅ 補齊後的大一名單: $freshman');
  print('✅ 補齊後的大二名單: $sophomore');
}

bool pick(int length, String type) {
  String pick = (type == 'fresh')
  ? freshman[Random().nextInt(length)]
  : sophomore[Random().nextInt(length)];

  int count = 0;
  if (type == 'fresh'){
    for (int j=0; j<freshman.length; j++) {
      if (freshman[j] == pick) {count++;}
    }
  } else {
    for (int j=0; j<sophomore.length; j++) {
      if (sophomore[j] == pick) {count++;}
    }
  }

  if (count >= 2) {
    return false;
  } else {
    if (type == 'fresh') {freshman.add(pick);}
    else {sophomore.add(pick);}
    return true;
  }
}


