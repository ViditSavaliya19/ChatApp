import 'package:flutter/material.dart';
import 'package:my_chat_app/utils/firebase.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                onPressed: () {
                  createUser(txtEmail.text, txtPassword.text);
                },
                child: Text("SingUp"),
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
