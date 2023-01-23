import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_chat_app/screen/model/profileModel.dart';
import 'package:my_chat_app/utils/firebase.dart';

class SinginScreen extends StatefulWidget {
  const SinginScreen({Key? key}) : super(key: key);

  @override
  State<SinginScreen> createState() => _SinginScreenState();
}

class _SinginScreenState extends State<SinginScreen> {
  TextEditingController txtEmail =TextEditingController();
  TextEditingController txtPassword =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: txtEmail,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: txtPassword,
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async{
                  bool isLogin= await singIn(txtEmail.text, txtPassword.text);
                  if(isLogin)
                  {
                    bool? msg =await createProfile(userDetails());
                    if(msg==true)
                      {
                        Get.toNamed('/homePage');
                      }
                  }
                },
                child: Text("SingIn"),
                style:
                ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed('/signUpPage');
                },
                child: Text("Next"),
                style:
                ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
