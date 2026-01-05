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
      body: (pairedFresh.isEmpty)
        ? Center(child: Text('No data to show!',
          style: TextStyle(fontSize: 16),))
        : Column(
          children: [
            ...List.generate(
                pairedFresh.length,
                (index) {
                  return Container(
                    width: double.infinity,
                    height: 80,
                    padding: EdgeInsets.only(left: 10, top: 2, right: 10),
                    child: Card(
                      color: (index % 2 == 0)
                        ? Color.fromARGB(255, 240, 220, 240)
                        : Color.fromARGB(255, 255, 235, 235),
                      // 255, 235, 235 -> light pink
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Text(pairedSopho.elementAt(index),
                              style: TextStyle(fontSize: 20),),
                            Text(' <-> ',
                              style: TextStyle(fontSize: 20),),
                            Text(pairedFresh.elementAt(index),
                              style: TextStyle(fontSize: 20),),
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
