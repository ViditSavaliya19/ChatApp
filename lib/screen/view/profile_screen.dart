import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_chat_app/screen/controller/profile_controller.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileController profileController = ProfileController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  // Obx(
                  //   () =>
                    CircleAvatar(
                  //     // backgroundImage: FileImage(File(
                  //     //     profileController.imgUrl.isEmpty
                  //     //         ? ""
                  //     //         : profileController.imgUrl.value)),
                      maxRadius: 8.h,
                    ),
                  // ),
                  InkWell(
                    onTap: () async {
                      ImagePicker imagePicker = ImagePicker();
                      XFile? xFile = await imagePicker.pickImage(source: ImageSource.gallery);

                      // profileController.pickImage();
                    },
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.camera_alt,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Text(
              "Name...",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
