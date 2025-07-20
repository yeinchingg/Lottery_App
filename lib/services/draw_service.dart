
import 'package:lottery_app/datas/student_names.dart';
import 'dart:math';


class ChoosingStudent {

  Random rand = Random();
  late int stdnum;
  late String stdname;

  void chooseStudent() {
    stdnum = rand.nextInt(freshman.length);
    stdname = freshman[stdnum];
  }

  String showStudent() {
    return stdname;
  }

  deleteStudent() {
    freshman.removeAt(stdnum);
  }
  List<String> getRemaining() => freshman;
}



