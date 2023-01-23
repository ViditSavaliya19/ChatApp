import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_chat_app/utils/firebase.dart';

class SpleshScreen extends StatefulWidget {
  const SpleshScreen({Key? key}) : super(key: key);

  @override
  State<SpleshScreen> createState() => _SpleshScreenState();
}

class _SpleshScreenState extends State<SpleshScreen> {
  @override
  Widget build(BuildContext context) {
    checkPath();

    return SafeArea(
      child: Scaffold(
        body: Center(child: FlutterLogo()),
      ),
    );
  }

  void checkPath() async {
    bool isLogin = await checkUser();
    if (isLogin) {
      Timer(Duration(seconds: 3), () => Get.offNamed('/homePage'));
    } else {
      Timer(Duration(seconds: 3), () => Get.offNamed('/singInPage'));
    }
  }
}
