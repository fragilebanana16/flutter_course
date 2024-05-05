import 'package:flutter/material.dart';
import 'widgets.dart';

class Welcome extends StatelessWidget {
  Welcome({super.key});

  final PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            children: [
              appOnBoardingPage(_controller,
                  imagePath: "assets/images/reading.png",
                  title: "Learn stack manage",
                  subTitle: "Books, shelf list, all in one page.",
                  index: 1),
              appOnBoardingPage(_controller,
                  imagePath: "assets/images/music.png",
                  title: "Second music",
                  subTitle: "Music management in one project with flutter",
                  index: 2)
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
