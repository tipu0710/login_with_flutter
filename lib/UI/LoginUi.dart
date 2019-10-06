import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_with_flutter/UI/WelcomePageUi.dart';
import 'package:login_with_flutter/Utils/AllColor.dart' as constColors;
import 'package:login_with_flutter/anim/EnterExitAnim.dart';
import 'package:login_with_flutter/anim/ScaleTransition.dart';

import 'LoginTextField.dart';
import 'SignupUi.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          //background line
          Image.asset(
            "images/login_curves_back.png",
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Center(
            child: Container(
              //computer icon
              child: Image.asset(
                "images/login_icon.png",
                width: 295.41,
                height: 217.94,
              ),
              margin: EdgeInsets.only(top: 0),
              padding: EdgeInsets.only(bottom: 250),
            ),
          ),

          //TextFiled
          TextController(),

          //LoginButton
          Positioned(
            top: 454,
            right: 112,
            height: 43,
            width: 136,

              child: RaisedButton(
                onPressed: () {
                  Navigator.push(context, ScaleRoute(page: WelcomePage()));
                },
                color: Color(constColors.loginButtonColor),
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15.0),
              ),
            ),
          ),

          //sign up button
          Positioned(
            top: 548,
            left: 228,
            height: 71,
            width: 172,
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      EnterExitRoute(exitPage: this, enterPage: SignUpPage())
                  );
                },
                child: Image.asset("images/signup.png")),
          ),

          //google icon
          Positioned(
            top: 562,
            left: 118.53,
            height: 42.65,
            width: 42.65,
            child: Image.asset("images/google.png"),
          ),

          //facebook icon
          Positioned(
            top: 562,
            left: 62.47,
            height: 42.65,
            width: 42.65,
            child: Image.asset("images/facebook.png"),
          ),

          //,or text
          Positioned(
            top: 572,
            left: 28,
            child: Text(
              ",or",
              style: TextStyle(color: Color(constColors.orColor), fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

}


