import 'package:get/get.dart';
import 'package:my_chat_app/screen/view/addChatPage.dart';
import 'package:my_chat_app/screen/view/chatPage.dart';
import 'package:my_chat_app/screen/view/profile_screen.dart';
import 'package:my_chat_app/screen/view/registerScreen.dart';
import 'package:my_chat_app/screen/view/spleshPage.dart';

import '../screen/view/homePage.dart';
import '../screen/view/signInPage.dart';

List<GetPage> routeList =[

  GetPage(name: '/', page:() => SpleshScreen(),),
  GetPage(name: '/singInPage', page:() => SinginScreen(),),
  GetPage(name: '/signUpPage', page:() => RegisterScreen(),),
  GetPage(name: '/homePage', page:() => HomePage(),),
  GetPage(name: '/addChatPage', page:() => AddChatPage(),),
  GetPage(name: '/chatPage', page:() => ChatPage(),),
  GetPage(name: '/profilePage', page:() => ProfileScreen(),),
];