import 'package:flutter/material.dart';
import 'package:lottery_app/services/draw_service.dart';

// void main() {
//   runApp(const MaterialApp(home: TestDrawPage()));
// }
//
// class TestDrawPage extends StatefulWidget {
//   const TestDrawPage({super.key});
//
//   @override
//   State<TestDrawPage> createState() => _TestDrawPageState();
// }
//
// class _TestDrawPageState extends State<TestDrawPage> {
//   final ChoosingStudent chooser = ChoosingStudent();
//
//   String? chosen;
//   List<String> remaining = [];
//
//   void draw() {
//     setState(() {
//       chooser.chooseStudent();
//       chosen = chooser.showStudent();
//       chooser.deleteStudent();
//       remaining = chooser.getRemaining();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('抽籤測試')),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             ElevatedButton(
//               onPressed: draw,
//               child: const Text('抽籤'),
//             ),
//             const SizedBox(height: 20),
//             Text('抽到：${chosen ?? "尚未抽"}'),
//             const SizedBox(height: 20),
//             Text('剩下：$remaining'),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:lottery_app/services/draw_service.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
