import 'dart:convert';

import 'package:NewsApp/Extentions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../Items/LoginModel.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LoginUi());
  }

  Widget LoginUi() {
    return Center(
      child: Container(
          alignment: Alignment.center,
          height: 400,
          width: 500,
          child: Column(children: [
            Material(
              borderRadius: BorderRadius.circular(20),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                  hintText: "Email",
                  hintStyle: TextStyle(fontFamily: "Yekan"),
                  icon: Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Icon(Icons.perm_identity),
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ).addNeumorphism(),
            SizedBox(
              height: 20,
            ),
            Material(
              borderRadius: BorderRadius.circular(20),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                  hintText: "Password",
                  hintStyle: TextStyle(fontFamily: "Yekan"),
                  icon: Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Icon(Icons.lock_outlined),
                  ),
                ),
                obscureText: true,
                textAlign: TextAlign.center,
              ),
            ).addNeumorphism(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: (() => sendLoginRequest(
                    emailController.text, passwordController.text, context)),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.red[400],
                    ),
                    alignment: Alignment.center,
                    height: 60,
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    )).addNeumorphism(),
              ),
            )
          ])),
    );
  }

  void sendLoginRequest(String username, String password, context) async {
    var url = "http://modibitapi.freehost.io/php-auth-api/login.php";
    var body = '{"email":"$username","password":"$password"}';
    //body["username"] = username;
    //body["password"] = password;
    Response response = await post(Uri.parse(url), body: body);
    if (response.statusCode == 200) {
      var LoginJson = json.decode(utf8.decode(response.bodyBytes));

      LoginResponseModel model =
          LoginResponseModel(LoginJson["success"], LoginJson["message"]);
      print(model.message);
      if (model.success == 0) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  content: Text(
                    model.message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: "Yekan",
                      fontSize: 15,
                    ),
                  ),
                ));
      } else if (model.success == 1) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          model.message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: "Yekan",
            fontSize: 15,
          ),
        )));

        //Navigator.of(context);
      }
    }
  }
}
