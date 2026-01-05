import 'package:flutter/material.dart';
import 'package:lottery_app/listPage.dart';
import 'package:lottery_app/homePage.dart';
class AllDonePage extends StatelessWidget {
  const AllDonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
        ),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("大二已全數抽取完畢！", style: Theme.of(context).textTheme.titleMedium),
              SizedBox(height: 12,),
              FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListPage()),
                  );
                },
                label: Text('查看抽取結果列表',style: Theme.of(context).textTheme.bodyMedium),
                icon: Icon(Icons.person_search),
                backgroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black,width: 2),

                  borderRadius: BorderRadius.circular(3),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
