List<String> pairedFresh = [];
List<String> pairedSopho = [];
List<int> pairedFreshNum = [];
List<int> pairedSophoNum = [];

class DrawPairs {
  // final String freshman;
  // final String Sophomore;

  // DrawPairs(this.freshman,this.Sophomore);
  void pushFresh (String name) {
    pairedFresh.add(name);
  }
  void pushFreshNum(int num) {
    pairedFreshNum.add(num);
  }
  void pushSopho (String name) {
    pairedSopho.add(name);
  }
  void pushSophoNum(int num) {
    pairedSophoNum.add(num);
  }
}