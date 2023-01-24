//Login & Register

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_chat_app/screen/model/chatMsgModel.dart';
import 'package:my_chat_app/screen/model/chatUserModel.dart';
import 'package:my_chat_app/screen/model/profileModel.dart';

// Register
void createUser(String email, String password) async {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  await firebaseAuth
      .createUserWithEmailAndPassword(email: email, password: password)
      .then((value) => print("Success"))
      .catchError((error) => print("$error"));
}

// Login
Future<bool> singIn(String email, String password) async {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  await firebaseAuth
      .signInWithEmailAndPassword(email: email, password: password)
      .then((value) => print("Success"))
      .catchError((error) => print("$error"));
  return await checkUser();
}

// Current User
Future<bool> checkUser() async {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  if (await firebaseAuth.currentUser != null) {
    return true;
  }
  return false;
}

//UserDetails
ProfileModel userDetails() {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var user = firebaseAuth.currentUser;
  return ProfileModel(
      email: user!.email,
      imgUrl: user.photoURL,
      name: user.displayName,
      phone: user.phoneNumber,
      privacy: true,
      uid: user.uid);
}

//Logout
void logout() async {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  await firebaseAuth.signOut();
}

//UID
Future<String?> getUID() async {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  return await firebaseAuth.currentUser?.uid;
}

//Profile
Future<bool?> createProfile(ProfileModel model) async {
  bool? isDetails;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  await firestore.collection("profiles").doc(model.uid).set({
    "email": model.email,
    "imgUrl": model.imgUrl,
    "name": model.name,
    "phone": model.phone,
    "privacy": model.privacy,
    "uid": model.uid
  }).then((value) {
    isDetails = true;
  }).catchError((error) {
    isDetails = false;
  });

  return isDetails;
}

//createChat
void addChatUser(ChatUserModel model) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  await firestore.collection("chat").doc().set({
    "date": model.date,
    "docId": model.docId,
    "email": model.emails,
    "msg": model.msg,
    "name": model.name,
    "phone": model.phone,
    "users": model.uids
  });
}

//readAllUser
Stream<QuerySnapshot<Map<String, dynamic>>> readAllUser() {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  return firestore.collection('profiles').snapshots();
}

//readOneUser
Future<DocumentSnapshot<Map<String, dynamic>>> readOneUser(String name) {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  return firestore.collection('profiles').doc(name).get();
}

//readChatUser
Stream<QuerySnapshot<Map<String, dynamic>>> myAllChatUser() {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var user = firebaseAuth.currentUser;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  return firestore
      .collection('chat')
      .where("users", arrayContainsAny: ["${user!.uid}"]).snapshots();
}

//sendMSg
void addChatMsg({ChatMsgModel? chatmodel, ChatUserModel? model}) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  await firestore
      .collection("chat")
      .doc(model!.docId)
      .collection("Message")
      .add({
    "date": chatmodel!.date,
    "docId": model.docId,
    "msg": chatmodel.msg,
    "uid": chatmodel.uid,
  });
}

//read User Wise Chat
Stream<QuerySnapshot<Map<String, dynamic>>> readMsg(String docId) {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var user = firebaseAuth.currentUser;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  print("========= ${user!.uid}");
  return firestore
      .collection('chat')
      .doc("$docId")
      .collection("Message")
      .orderBy('date', descending: true)
      .snapshots();
}

//read userDetails in Database
Future<DocumentSnapshot<Map<String, dynamic>>> readUserDataViaDatabase() {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var user = firebaseAuth.currentUser;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  return firestore.collection("profiles").doc(user!.uid).get();
}
