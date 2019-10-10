import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_with_flutter/UI/NewUserStateFullWidget.dart';

class NewUserPage extends StatelessWidget {
  final FirebaseUser user;

  NewUserPage(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          //background curves
          Image.asset(
            "images/signup_curves_back.png",
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),

          //human icon
          Center(
            child: Container(
              //computer icon
              child: Image.asset(
                "images/signup_icon.png",
                width: 208.8,
                height: 182.7,
              ),
              margin: EdgeInsets.only(top: 0),
              padding: EdgeInsets.only(bottom: 200),
            ),
          ),

          //phone number
          new NewUserStateFullWidget(user),
        ],
      ),
    );
  }
}


