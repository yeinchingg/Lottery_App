import 'package:lottery_app/datas/student_names.dart';
import 'package:lottery_app/models/pairs.dart';
import 'dart:math';

class ChoosingStudent {
  DrawPairs pairs = DrawPairs();
  Random rand = Random();
  late int stdnum;
  late String stdname;

  void chooseStudent(int index) {
    stdnum = rand.nextInt(freshman.length);
    stdname = freshman[stdnum];
    pairs.pushFresh(stdname);
    pairs.pushSopho(sophomore.elementAt(index));
  }

  String showStudent() {
    return stdname;
  }

  deleteStudent() {
    freshman.removeAt(stdnum);
  }

  List<String> getRemaining() => freshman;
}



