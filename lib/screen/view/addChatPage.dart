import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_chat_app/screen/model/chatUserModel.dart';
import 'package:my_chat_app/screen/model/profileModel.dart';

import '../../utils/firebase.dart';
import '../controller/homeController.dart';

class AddChatPage extends StatefulWidget {
  const AddChatPage({Key? key}) : super(key: key);

  @override
  State<AddChatPage> createState() => _AddChatPageState();
}

class _AddChatPageState extends State<AddChatPage> {
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    homeController.getContact();
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
            IconButton(
                onPressed: () {
                  logout();
                  Get.toNamed('/singInPage');
                },
                icon: Icon(Icons.logout))
          ],
        ),
        body: StreamBuilder(
          stream: readAllUser(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (snapshot.hasData) {
              var data = snapshot.data.docs;
              List<ProfileModel> users = [];
              for (var x in data) {
                Map<String, dynamic> data = x.data()! as Map<String, dynamic>;
                ProfileModel p1 = ProfileModel(
                    uid: x['uid'],
                    email: x['email'],
                    name: x['name'],
                    phone: x['phone'],
                    privacy: x['privacy'],
                    imgUrl: x['imgUrl'],);
                print("${x.id}");
                users.add(p1);
              }
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      addChatUser(ChatUserModel(
                          name: users[index].name,
                          phone: users[index].phone,
                          emails: {homeController.userDetails!.uid:homeController.userDetails!.email,users[index].uid:users[index].email},
                          date: "${DateTime.now()}",
                          uids: ["${homeController.userDetails!.uid}", "${users[index].uid}"]));
                    },
                    title: Text("${users[index].email}"),
                    subtitle: Text("${users[index].name}"),
                  );
                },
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
