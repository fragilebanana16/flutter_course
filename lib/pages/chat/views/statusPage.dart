import 'package:flutter/material.dart';
import 'package:flutter_course/pages/chat/views/Widgets/otherStatusCard.dart';
import 'package:flutter_course/pages/chat/views/Widgets/ownStatusCard.dart';

class StatusPage extends StatefulWidget {
  StatusPage({Key? key}) : super(key: key);

  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xfffafafa),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 48,
            child: FloatingActionButton(
              heroTag: "statusPageTag",
              backgroundColor: Colors.blueGrey[100],
              elevation: 8,
              onPressed: () {},
              child: Icon(
                Icons.edit,
                color: Colors.blueGrey[900],
              ),
            ),
          ),
          SizedBox(
            height: 13,
          ),
          FloatingActionButton(
            heroTag: "statusPageTag2",
            backgroundColor: Colors.greenAccent[700],
            elevation: 5,
            onPressed: () {},
            child: Icon(
              Icons.camera_alt,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            OwnStatus(),
            Container(
              height: 33,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey[300],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
                child: Text(
                  "Recent updates",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
            ),
            OthersStatus(
              name: "Balram Rathore",
              seen: true,
              statusNum: 1,
              imageName: "assets/images/homeBanner_main.png",
            ),
            OthersStatus(
              name: "Kishor Kumar",
              seen: true,
              statusNum: 2,
              imageName: "assets/images/homeBanner_media.png",
            ),
            OthersStatus(
              name: " Saket Sinha",
              seen: true,
              statusNum: 3,
              imageName: "assets/images/homeBanner_music.png",
            ),
            OthersStatus(
              name: "Bhanudev Som",
              seen: true,
              statusNum: 1,
              imageName: "assets/images/music.png",
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 33,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey[300],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
                child: Text(
                  "Viewed updates",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
            ),
            OthersStatus(
              name: "Balram Rathore",
              seen: false,
              statusNum: 5,
              imageName: "assets/images/homeBanner_main.png",
            ),
            OthersStatus(
              name: "Kishor Kumar",
              seen: false,
              statusNum: 3,
              imageName: "assets/images/reading.png",
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
