import 'package:flutter/material.dart';
import 'package:flutter_course/common/widgets/text_widgets.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            scrollDirection: Axis.horizontal,
            children: [
              Column(
                children: [
                  Image.asset("assets/images/reading.png"),
                  text24Normal(text: "First learning")
                ],
              )
            ],
          ),
          const Positioned(
            left: 20,
            bottom: 100,
            child: Text("widget1"),
          ),
          const Positioned(
            top: 120,
            left: 200,
            child: Text(
              "widget2",
              style: TextStyle(fontSize: 30),
            ),
          ),
        ],
      ),
    );
  }
}
