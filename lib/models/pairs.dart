List<String> pairedFresh = [];
List<String> pairedSopho = [];

class DrawPairs {
  // final String freshman;
  // final String Sophomore;

  // DrawPairs(this.freshman,this.Sophomore);
  void pushFresh (String name) {
    pairedFresh.add(name);
  }
  void pushSopho (String name) {
    pairedSopho.add(name);
  }
}