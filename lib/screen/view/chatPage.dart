import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_chat_app/screen/model/chatMsgModel.dart';
import 'package:my_chat_app/utils/firebase.dart';
import 'package:sizer/sizer.dart';

import '../controller/homeController.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  HomeController homeController = Get.put(HomeController());
  TextEditingController txtMsg = TextEditingController();
  String? UID;

  @override
  void initState() {
    super.initState();
    readUID();
  }

  void readUID() async {
    UID = await getUID();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("${Get.arguments}"),
          backgroundColor: Colors.redAccent,
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: StreamBuilder(
                  stream: readMsg(homeController.chatUserModel!.docId!),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    } else if (snapshot.hasData) {
                      var data = snapshot.data.docs;
                      List<ChatMsgModel> chats = [];
                      for (var x in data) {
                        Map<String, dynamic> data =
                            x.data()! as Map<String, dynamic>;
                        ChatMsgModel c1 = ChatMsgModel(
                          date: x['date'],
                          msg: x['msg'],
                          uid: x['uid'],
                        );
                        chats.add(c1);
                      }
                      return ListView.builder(
                        itemCount: chats.length,
                        reverse: true,
                        itemBuilder: (context, index) {
                          return Align(
                            alignment: chats[index].uid == UID
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                  color: Colors.red.shade100,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text(
                                "${chats[index].msg}",
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(20)),
                      alignment: Alignment.center,
                      child: TextField(
                        controller: txtMsg,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      var msg = ChatMsgModel(
                          msg: txtMsg.text,
                          date: "${DateTime.now()}",
                          uid: await getUID());
                      addChatMsg(chatmodel: msg, model: homeController.chatUserModel!);
                      txtMsg.clear();
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
