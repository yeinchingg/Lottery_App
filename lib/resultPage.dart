import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({
    super.key,
    required this.name,
  });

  final String name;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
      ),
      body: Center(
        child: Column(
          children: [
            Stack(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Image(image: ),
                    FittedBox(
                      child: Text(widget.name, style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                      )),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 56,
                      width: double.infinity,
                      child: Lottie.network(
                        'https://lottie.host/216adf2c-75a4-420c-8986-bfbf12e806ec/VHW7qTjeRi.json',
                      ),
                    ),
                  ],
                ),
              ]
            ),
          ],
        ),
      ),
    );
  }
}
