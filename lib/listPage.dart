import 'package:flutter/material.dart';
import 'package:lottery_app/models/pairs.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: Column(
        children: [
          ...List.generate(
              pairedFresh.length,
              (index) {
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Card(
                      child: Column(
                        children: [
                          Text(pairedSopho.elementAt(index)),
                          Text(pairedFresh.elementAt(index)),
                        ],
                      ),
                    ),
                  ),
                );
              }
          )
        ],
      ),
    );
  }
}
