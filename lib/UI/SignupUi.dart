import 'package:flutter/material.dart';
import 'package:login_with_flutter/UI/SignUpTextField.dart';
import 'package:login_with_flutter/Utils/AllColor.dart' as constColors;
import 'package:login_with_flutter/Utils/ConstantValues.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUpPage> {
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
                width: 245.9,
                height: 215.16,
              ),
              margin: EdgeInsets.only(top: 0),
              padding: EdgeInsets.only(bottom: 255),
            ),
          ),

          //TextFields
          SignUpTextController(true),
          //phone number
          SignUpTextController(false),
          Center(
            child: Container(
              child: TextFieldStyle().textWidget("Phone Number",
                  constColors.loginBorderColor, Icon(Icons.phone_android)),
              width: 250,
              height: 55,
              margin: EdgeInsets.only(top: 185),
            ),
          ),

          //signup button
          Positioned(
            top: 454,
            right: 112,
            height: 43,
            width: 136,
            child: RaisedButton(
              onPressed: () {},
              color: Color(constColors.signUpButtonColor),
              child: Text(
                "Sign up",
                style: TextStyle(color: Colors.white),
              ),
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(15.0),
              ),
            ),
          ),

          //login button
          Positioned(
            top: 548,
            left: -40,
            height: 71,
            width: 172,
            child: GestureDetector(onTap:() {
              Navigator.pop(context);
            },child: Image.asset("images/login.png")),
          ),

          //,or text
          Positioned(
            top: 572,
            left: 165,
            child: Text(
              ",or",
              style: TextStyle(color: Color(constColors.orColor), fontSize: 18),
            ),
          ),

          //google icon
          Positioned(
            top: 562,
            left: 199.53,
            height: 42.65,
            width: 42.65,
            child: Image.asset("images/google.png"),
          ),

          //facebook icon
          Positioned(
            top: 562,
            left: 255.47,
            height: 42.65,
            width: 42.65,
            child: Image.asset("images/facebook.png"),
          ),
        ],
      ),
    );
  }
}
