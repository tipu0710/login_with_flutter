import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_with_flutter/Utils/AllColor.dart' as constColors;
import 'package:login_with_flutter/login/facebookSignIn.dart';
import 'package:login_with_flutter/login/googleSignIn.dart';

import 'LoginStateFullWidget.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
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
            LoginStateFullWidget(),

            //sign up button
            /*Positioned(
              top: 548,
              left: 228,
              height: 71,
              width: 172,
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        EnterExitRoute(exitPage: this, enterPage: SignUpPage()));
                  },
                  child: Image.asset("images/signup.png")),
            ),*/

            //google icon
            Positioned(
                top: 539,
                left: 187.05,
                height: 42.65,
                width: 42.65,
                child: SignInByGoogle()),

            //facebook icon
            Positioned(
                top: 539,
                left: 131,
                height: 42.65,
                width: 42.65,
                child: FacebookSignIn()),

            //,or text
            Positioned(
              top: 548,
              left: 97,
              child: Text(
                ",or",
                style: TextStyle(color: Color(constColors.orColor), fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<bool> _onBackPressed() async {
    // Your back press code here...
    return SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}
