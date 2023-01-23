import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_chat_app/screen/controller/homeController.dart';
import 'package:my_chat_app/screen/model/chatUserModel.dart';
import 'package:my_chat_app/utils/firebase.dart';

import '../model/profileModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    homeController.userDetails = userDetails();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text("MyChat"),
          centerTitle: true,
          actions: [
            PopupMenuButton(itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: InkWell(onTap: (){
                    Get.toNamed('/profilePage');
                  },child: Text("Profile")),

                ),
                PopupMenuItem(
                  child: Text("Logout"),
                  onTap: (){
                    logout();
                    Get.toNamed('/singInPage');
                  },
                ),
              ];
            })
          ],
        ),
        body: StreamBuilder(
          stream: myAllChatUser(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (snapshot.hasData) {
              var data = snapshot.data.docs;
              print("========= $data");
              List<ChatUserModel> users = [];

              for (var x in data) {
                Map<String, dynamic> data = x.data()! as Map<String, dynamic>;

                ChatUserModel c1 = ChatUserModel(
                  date: x['date'],
                  emails: x['email'],
                  name: homeController.userDetails!.uid != x['users'][0]
                      ? x['email'][x['users'][0]]
                      : x['email'][x['users'][1]],
                  phone: x['phone'],
                  msg: x['msg'],
                  docId: x.id,
                  uids: x['users'],
                );
                users.add(c1);

                print("${homeController.nameOfUser} Hello");
              }

              return ListView.builder(
                itemCount: users.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      homeController.chatUserModel = users[index];
                      Get.toNamed("/chatPage", arguments: users[index].name);
                    },
                    title: Text("${users[index].name}"),
                  );
                },
              );
            }
            return CircularProgressIndicator();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed('/addChatPage');
          },
          backgroundColor: Colors.redAccent,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
