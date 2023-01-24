import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_chat_app/screen/model/profileModel.dart';

import '../../utils/firebase.dart';

class ProfileController extends GetxController {
  RxString imgUrl = "".obs;
  Rx<ProfileModel>? profileModel = ProfileModel().obs;

  void pickImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? xFile = await imagePicker.pickImage(source: ImageSource.gallery);
    imgUrl.value = xFile!.path;
  }

  void userData() async {
    DocumentSnapshot<Map<String, dynamic>> response =
        await readUserDataViaDatabase();
    Map<String, dynamic>? data = response.data();
    print(data!['email']);
    profileModel!.value = ProfileModel(
        email: data!['email'],
        imgUrl: data!['imgUrl'],
        name: data!['name'],
        phone: data!['phone'],
        uid: data!['uid']);
  }
}
