import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key, required this.name});

  final String name;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    final double appBarHeight = AppBar().preferredSize.height;
  final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(title: const Text('Result')), // 建議加上 const
      body: Stack(

        children: <Widget>[

          Container(
            decoration: const BoxDecoration( // 建議加上 const
              image: DecorationImage(
                image: AssetImage("assets/frame2.png"), // 確保你的圖片路徑是 assets/frame2.png
                fit: BoxFit.cover, // 讓圖片填滿整個空間
              ),
            ),
          ),


          SizedBox(
            height: MediaQuery.of(context).size.height - (appBarHeight + statusBarHeight),
            width: double.infinity, // 寬度填滿
            child: Lottie.network(
              'https://lottie.host/216adf2c-75a4-420c-8986-bfbf12e806ec/VHW7qTjeRi.json',
              fit: BoxFit.cover,
            ),
          ),


          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // 本地 JSON 動畫
                Lottie.asset(
                  'assets/animation.json',
                  width: 450,
                  height: 450,
                  fit: BoxFit.contain, // 讓動畫完整顯示在指定大小內
                ),

                FittedBox(
                  child: Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
