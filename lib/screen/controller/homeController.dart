import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:my_chat_app/screen/model/profileModel.dart';

import '../../utils/firebase.dart';
import '../model/chatUserModel.dart';

class HomeController extends GetxController {
  RxList<Contact> contacts = <Contact>[].obs;
  ChatUserModel? chatUserModel;
  ProfileModel? userDetails;

  RxList nameOfUser=[].obs;

  void getContact() async {
    if (await FlutterContacts.requestPermission()) {
      contacts.value = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);
      print(contacts);
    } else {
      print("Error");
    }
  }

  Future<void> getUserName(String name) async {
    print("Name========== $name");

    DocumentSnapshot data =await readOneUser(name);
    Map<String,dynamic> userData =data.data() as Map<String,dynamic>;
    nameOfUser.add(userData['name']);
    print("${nameOfUser}");
  }
}
