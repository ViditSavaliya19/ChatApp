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
  void initState() {
    super.initState();
    profileController.userData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              color: Colors.red,
              height: 30.h,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          Obx(
                            () => profileController
                                        .profileModel!.value.imgUrl !=
                                    null
                                ? CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        profileController
                                            .profileModel!.value.imgUrl!),
                                    maxRadius: 8.h,
                                  )
                                : CircleAvatar(
                                    backgroundImage: FileImage(File(
                                        profileController.imgUrl.isEmpty
                                            ? ""
                                            : profileController.imgUrl.value)),
                                    maxRadius: 8.h,
                                  ),
                          ),
                          Positioned(
                            bottom: -2,
                            right: -2,
                            child: IconButton(
                              onPressed: () async {
                                profileController.pickImage();
                              },
                              icon: const Icon(
                                Icons.camera_alt,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(
                      () => Text(
                        "${profileController.profileModel!.value.name}",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ]),
            ),
            Obx(
              () => ListTile(
                leading: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.red,
                ),
                title: Text("${profileController.profileModel!.value.email}"),
                trailing: IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
              ),
            ),
            Obx(
              () => ListTile(
                leading: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.red,
                ),
                title: Text("${profileController.profileModel!.value.phone}"),
                trailing: IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
              ),
            ),
            Obx(
              () => ListTile(
                leading: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.red,
                ),
                title: Text("${profileController.profileModel!.value.uid}"),
                trailing: IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
