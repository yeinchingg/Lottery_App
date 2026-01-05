import 'package:lottery_app/datas/student_names.dart';
import 'package:lottery_app/models/pairs.dart';
import 'dart:math';
import 'rnwJson.dart';

RnWJson json = RnWJson();

class ChoosingStudent {
  DrawPairs pairs = DrawPairs();
  Random rand = Random();
  late int stdnum;
  late String stdname;
  final int numOfFresh = freshman.length;

  void chooseStudent(int index) async {
    stdnum = rand.nextInt(sophomore.length);
    stdname = sophomore[stdnum];
    pairs.pushSopho(stdname);
    pairs.pushFresh(freshman.elementAt(index));
  }

  void storeStudent(int index) async{
    List? temp = await json.readJsonFromFile('temp');
    Map<String, dynamic> newData = {
      'fresh': freshman.elementAt(index),
      'sopho': stdname,
    };
    temp?.add(newData);
    json.writeJsonToFile(temp!, 'temp');
    if (index + 1 >= numOfFresh) {
      json.writeJsonToFile(temp, 'result');
      json.writeJsonToFile([], 'temp');
      json.writeJsonToFile([], 'equal');
    }
    print(temp);
  }

  String showStudent() {
    return stdname;
  }

  deleteStudent() {
    // freshman -> sophomore
    sophomore.removeAt(stdnum);
  }

  List<String> getRemaining() => freshman;
}

void equalizeLists() async{
  int lenF = freshman.length;
  int lenS = sophomore.length;
  List? equalizedList = await json.readJsonFromFile('equal');

  print('⚙️ equalizeLists 被呼叫了');

  if (equalizedList != null && equalizedList.isNotEmpty) {
    print('已從上次狀態復原，故不再重新進行equalize');
    rollbackEqualized(equalizedList);
    return;
  } else {
    print('The equalized list is empty or null. No elements to process.');
  }

  if (lenF == lenS) {
    print('🎯 名單數量相等 ($lenF)，不需補齊');
    return;
  }

  if (lenF < lenS) {
    for (int i = 0; i < lenS - lenF; i++) {
      bool added = false;
      while (!added) {added = pick(lenF, 'fresh');}
    }
    json.writeJsonToFile(freshman, 'equal');
    print('freshman < sophomore，已將補齊名單寫入equalizedList.json');
  } else {
    for (int i = 0; i < lenF - lenS; i++) {
      bool added = false;
      while (!added) {added = pick(lenS, 'sopho');}
    }
    json.writeJsonToFile(sophomore, 'equal');
    print('sophomore < freshman，已將補齊名單寫入equalizedList.json');
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

void rollbackEqualized(List list) {
  // print('equalized list: $list');
  int lenE = list.length;
  if (freshman.length < sophomore.length) {
    for (int i=lenE-freshman.length+1; i<lenE; i++){
      freshman.add(list[i]);
    }
    print('freshman after rollback from equalized: $freshman');
  } else if (sophomore.length < freshman.length) {
    for (int i=lenE-sophomore.length+1; i<lenE; i++){
      sophomore.add(list[i]);
    }
    print('sophomore after rollback from equalized: $sophomore');
  } else {}
}