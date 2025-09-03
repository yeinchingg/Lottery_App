import 'package:lottery_app/datas/student_names.dart';
import 'package:lottery_app/datas/student_num.dart';
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
    pairs.pushSophoNum(sophomoreNum[stdnum]);
    pairs.pushFresh(freshman.elementAt(index));
    pairs.pushFreshNum(freshmanNum.elementAt(index));
  }

  void storeStudent(int index) async{
    List? temp = await json.readJsonFromFile('temp');
    Map<String, dynamic> newData = {
      'fresh': freshman.elementAt(index),
      'sopho': stdname,
      'freshNum': freshmanNum.elementAt(index),
      'sophoNum': sophomoreNum.elementAt(stdnum),
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

  deleteSophoStudent() {
    // freshman -> sophomore
    sophomore.removeAt(stdnum);
    sophomoreNum.removeAt(stdnum);
  }

  List<String> getRemaining() => freshman;
}

void equalizeLists() async{
  int lenF = freshman.length;
  int lenS = sophomore.length;
  List? equalizedList = await json.readJsonFromFile('equal');
  List<Map> equalizedWithNum = [];

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

    if (freshman.length == freshmanNum.length) {
      for (int i = 0; i < freshman.length; i++) {
        Map<String, dynamic> newData = {
          'name': freshman.elementAt(i),
          'num': freshmanNum.elementAt(i),
        };
        equalizedWithNum.add(newData);
      }
    }
    json.writeJsonToFile(equalizedWithNum, 'equal'); // freshman -> equalizedList

    print('freshman < sophomore，已將補齊名單寫入equalizedList.json');
  } else {
    for (int i = 0; i < lenF - lenS; i++) {
      bool added = false;
      while (!added) {added = pick(lenS, 'sopho');}
    }

    if (sophomore.length == sophomoreNum.length) {
      for (int i = 0; i < sophomore.length; i++) {
        Map<String, dynamic> newData = {
          'name': sophomore.elementAt(i),
          'num': sophomoreNum.elementAt(i),
        };
        equalizedWithNum.add(newData);
      }
    }
    json.writeJsonToFile(equalizedWithNum, 'equal'); // sophomore -> equalizedList

    print('sophomore < freshman，已將補齊名單寫入equalizedList.json');
  }

  print('✅ 補齊後的大一名單: $freshman');
  print('✅ 補齊後的大一名單(學號): $freshmanNum');
  print('✅ 補齊後的大二名單: $sophomore');
  print('✅ 補齊後的大二名單(學號): $sophomoreNum');
}

bool pick(int length, String type) {
  int randNum = Random().nextInt(length);
  String pick = (type == 'fresh')
  ? freshman[randNum]
  : sophomore[randNum];

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
    if (type == 'fresh') {
      freshman.add(pick);
      freshmanNum.add(freshmanNum[randNum]);
    } else {
      sophomore.add(pick);
      sophomoreNum.add(sophomoreNum[randNum]);
    }
    return true;
  }
}

void rollbackEqualized(List list) {
  // print('equalized list: $list');
  int lenE = list.length;
  if (freshman.length < sophomore.length) {
    for (int i=lenE-freshman.length+1; i<lenE; i++){
      if (list[i] is Map) {
        Map element = list[i];
        freshman.add(element['name']);
        freshmanNum.add(element['num']);
      }
      // freshman.add(list[i]);
    }
    print('freshman after rollback from equalized: $freshman');
    print('freshman numbers after rollback from equalized: $freshmanNum');
  } else if (sophomore.length < freshman.length) {
    for (int i=lenE-sophomore.length+1; i<lenE; i++){
      if (list[i] is Map) {
        Map element = list[i];
        sophomore.add(element['name']);
        sophomoreNum.add(element['num']);
      }
      // sophomore.add(list[i]);
    }
    print('sophomore after rollback from equalized: $sophomore');
    print('sophomore numbers after rollback from equalized: $sophomoreNum');
  } else {}
}