import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      appBar: AppBar(title: const Text('Result')),
      body: Stack(

        children: <Widget>[

          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/frame2.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(
            height: MediaQuery.of(context).size.height - (appBarHeight + statusBarHeight),
            width: double.infinity,
            child: Lottie.network(
              'https://lottie.host/216adf2c-75a4-420c-8986-bfbf12e806ec/VHW7qTjeRi.json',
              fit: BoxFit.cover,
            ),
          ),


          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Lottie.asset(
                  'assets/animation.json',
                  width: 750,
                  height: 700,
                  fit: BoxFit.contain,
                ),

                FittedBox(
                  child: Text(
                    widget.name,
                    style: GoogleFonts.inter(
                      fontSize: 60,
                      fontWeight: FontWeight.w800,
                    ),

                    // style: const TextStyle(
                    //   fontSize: 60,
                    //   // fontWeight: FontWeight.bold,
                    //   color: Colors.black,
                    // ),
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
