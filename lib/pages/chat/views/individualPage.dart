// import 'package:camera/camera.dart';
// import 'package:chatapp/CustomUI/CameraUI.dart';
import 'dart:convert';
import 'dart:developer';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/common/models/chat.dart';
import 'package:flutter_course/common/models/message.dart';
import 'package:flutter_course/common/utils/constants.dart';
import 'package:flutter_course/main.dart';
import 'package:flutter_course/pages/chat/views/Widgets/ownImageCard.dart';
import 'package:flutter_course/pages/chat/views/Widgets/ownMessgaeCard.dart';
import 'package:flutter_course/pages/chat/views/Widgets/replyCard.dart';
import 'package:flutter_course/pages/chat/views/Widgets/replyImageCard.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;

class IndividualPage extends StatefulWidget {
  IndividualPage({Key? key, required this.chatModel, required this.sourcechat})
      : super(key: key);
  final ChatModel chatModel;
  final ChatModel sourcechat;

  @override
  _IndividualPageState createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  bool show = false;
  FocusNode focusNode = FocusNode();
  bool sendButton = false;
  List<MessageModel> messages = [];
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  late IO.Socket socket;
  ImagePicker _imagePicker = ImagePicker();
  @override
  void initState() {
    super.initState();
    // connect();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
    connect();
  }

  void connect() {
    // MessageModel messageModel = MessageModel(sourceId: widget.sourceChat.id.toString(),targetId: );
    socket = IO.io("http://192.168.0.107:8000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.emit("signin", widget.sourcechat.id);
    socket.onConnect((data) {
      print("Connected");
      socket.on("message", (msg) {
        print(msg);
        setMessage("destination", msg["message"], msg["imgPath"],
            msg["imgWidth"], msg["imgHeight"]);
        scrollBottomDelayed(1);
      });
    });
    print(socket.connected);

    // socket.emit("/test", 'hello world');
  }

  void sendMessage(
      String message, int sourceId, int targetId, ImageDetail imageDetail) {
    setMessage("source", message, imageDetail.imgPath, imageDetail.imgWidth,
        imageDetail.imgHeight);
    socket.emit("message", {
      "message": message,
      "sourceId": sourceId,
      "targetId": targetId,
      "imgPath": imageDetail.imgPath,
      "imgWidth": imageDetail.imgWidth,
      "imgHeight": imageDetail.imgHeight,
    });

    scrollBottomDelayed(1);
  }

  void scrollBottomDelayed(int seconds) {
    Future.delayed(Duration(seconds: seconds)).then((_) {
      // 延迟滚动操作，确保页面布局和元素高度计算完成后再执行
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  void setMessage(String type, String message, String imgPath, int imgWidth,
      int imgHeight) {
    MessageModel messageModel = MessageModel(
        type: type,
        message: message,
        time: DateTime.now().toString().substring(10, 16),
        image: ImageDetail(
            imgPath: imgPath, imgWidth: imgWidth, imgHeight: imgHeight));
    print(messages);

    setState(() {
      messages.add(messageModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/whatsapp_Back.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: AppBar(
              leadingWidth: 70,
              titleSpacing: 0,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_back,
                      size: 24,
                    ),
                    CircleAvatar(
                      child: widget.chatModel.isGroup
                          ? Icon(Icons.group, size: 36)
                          : Icon(Icons.person, size: 36),
                      radius: 20,
                      backgroundColor: Colors.blueGrey,
                    ),
                  ],
                ),
              ),
              title: InkWell(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.all(6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.chatModel.name,
                        style: TextStyle(
                          fontSize: 18.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "last seen today at 12:05",
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              actions: [
                IconButton(icon: Icon(Icons.videocam), onPressed: () {}),
                IconButton(icon: Icon(Icons.call), onPressed: () {}),
                PopupMenuButton<String>(
                  padding: EdgeInsets.all(0),
                  onSelected: (value) {
                    print(value);
                  },
                  itemBuilder: (BuildContext contesxt) {
                    return [
                      PopupMenuItem(
                        child: Text("View Contact"),
                        value: "View Contact",
                      ),
                      PopupMenuItem(
                        child: Text("Media, links, and docs"),
                        value: "Media, links, and docs",
                      ),
                      PopupMenuItem(
                        child: Text("Whatsapp Web"),
                        value: "Whatsapp Web",
                      ),
                      PopupMenuItem(
                        child: Text("Search"),
                        value: "Search",
                      ),
                      PopupMenuItem(
                        child: Text("Mute Notification"),
                        value: "Mute Notification",
                      ),
                      PopupMenuItem(
                        child: Text("Wallpaper"),
                        value: "Wallpaper",
                      ),
                    ];
                  },
                ),
              ],
            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WillPopScope(
              child: Column(
                children: [
                  Expanded(
                    // height: MediaQuery.of(context).size.height - 150,
                    child: ListView.builder(
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: messages.length + 1,
                      itemBuilder: listItemBuilder,
                    ),
                    //   child: ListView(
                    // children: [OwnImageCard(), ReplyImageCard()],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 60,
                                child: Card(
                                  margin: EdgeInsets.only(
                                      left: 2, right: 2, bottom: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: TextFormField(
                                    controller: _controller,
                                    focusNode: focusNode,
                                    textAlignVertical: TextAlignVertical.center,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 5,
                                    minLines: 1,
                                    onChanged: (value) {
                                      if (value.length > 0) {
                                        setState(() {
                                          sendButton = true;
                                        });
                                      } else {
                                        setState(() {
                                          sendButton = false;
                                        });
                                      }
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Type a message",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      prefixIcon: IconButton(
                                        icon: Icon(
                                          show
                                              ? Icons.keyboard
                                              : Icons.emoji_emotions_outlined,
                                        ),
                                        onPressed: () {
                                          if (!show) {
                                            focusNode.unfocus();
                                            focusNode.canRequestFocus = false;
                                          }
                                          setState(() {
                                            show = !show;
                                          });
                                        },
                                      ),
                                      suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.attach_file),
                                            onPressed: () {
                                              showModalBottomSheet(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  context: context,
                                                  builder: (builder) =>
                                                      bottomSheet());
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.camera_alt),
                                            onPressed: () {
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (builder) =>
                                              //             CameraApp()));
                                            },
                                          ),
                                        ],
                                      ),
                                      contentPadding: EdgeInsets.all(20),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 8,
                                  right: 2,
                                  left: 2,
                                ),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Color(0xFF128C7E),
                                  child: IconButton(
                                    icon: Icon(
                                      sendButton ? Icons.send : Icons.mic,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      if (sendButton) {
                                        sendMessage(
                                            _controller.text,
                                            widget.sourcechat.id,
                                            widget.chatModel.id,
                                            const ImageDetail());
                                        _controller.clear();
                                        setState(() {
                                          sendButton = false;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          show ? emojiSelect() : Container(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              onWillPop: () {
                if (show) {
                  setState(() {
                    show = false;
                  });
                } else {
                  Navigator.pop(context);
                }
                return Future.value(false);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(18.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.insert_drive_file, Colors.indigo,
                      "Document", () {}),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.camera_alt, Colors.pink, "Camera", () {}),
                  SizedBox(
                    width: 40,
                  ),
                  // 发送图片
                  iconCreation(Icons.insert_photo, Colors.purple, "Gallery",
                      sendImageFromGallery),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.headset, Colors.orange, "Audio", () {}),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(
                      Icons.location_pin, Colors.teal, "Location", () {}),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.person, Colors.blue, "Contact", () {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreation(
      IconData icons, Color color, String text, Function()? onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icons,
              // semanticLabel: "Help",
              size: 29,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              // fontWeight: FontWeight.w100,
            ),
          )
        ],
      ),
    );
  }

  Widget emojiSelect() {
    return EmojiPicker();
  }

  // 下方弹框从图库中选择图片发送
  void sendImageFromGallery() async {
    List<XFile>? imageFileList = [];
    List<XFile>? selectedImages = await _imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      imageFileList.addAll(selectedImages);
    }

    // single file
    // XFile? xFile = await _imagePicker.pickImage(
    //     source: ImageSource.gallery);
    // if (xFile == null) {
    //   return;
    // }

    var req = http.MultipartRequest(
        "POST", Uri.parse("${AppConstants.SERVER_API_URL}file/uploadImage"));
    try {
      for (final xFile in imageFileList) {
        req.files.add(await http.MultipartFile.fromPath("img", xFile.path));
      }
    } catch (e) {
      print(e.toString());
    }

    req.headers.addAll({
      "Content-type": "multipart/form-data",
    });

    http.StreamedResponse rsp = await req.send();
    var httpRsp = await http.Response.fromStream(rsp);
    var data = json.decode(httpRsp.body);
    for (final img in data['img']) {
      print(img['filename']);
      String originalPath = img['path'].replaceAll("\\", "/");
      RegExp exp = new RegExp(r'public/'); // remove first public
      String modifiedPath = originalPath.replaceFirst(exp, '');
      sendMessage(
          _controller.text,
          widget.sourcechat.id,
          widget.chatModel.id,
          ImageDetail(
              imgPath: modifiedPath,
              imgWidth: img['width'],
              imgHeight: img['height']));
    }

    navKey.currentState?.pop(); // dont use navigator in async, use global key
  }

  Widget listItemBuilder(BuildContext context, int index) {
    if (index == messages.length) {
      return Container(
        height: 10,
      );
    }
    if (messages[index].type == "source") {
      if (messages[index].isImageNotEmpty()) {
        return OwnImageCard(
          image: messages[index].image,
        );
      } else {
        return OwnMessageCard(
          message: messages[index].message,
          time: messages[index].time,
        );
      }
    } else {
      if (messages[index].isImageNotEmpty()) {
        return ReplyImageCard(
          image: messages[index].image,
        );
      } else {
        return ReplyCard(
          message: messages[index].message,
          time: messages[index].time,
        );
      }
    }
  }
}
