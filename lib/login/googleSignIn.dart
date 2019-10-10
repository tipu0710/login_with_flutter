
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_with_flutter/UI/WelcomePageUi.dart';
import 'package:login_with_flutter/animation/ScaleTransition.dart';
import 'package:login_with_flutter/login/googleApi.dart';

class SignInByGoogle extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _GoogleSignIn();
  }

}

class _GoogleSignIn extends State<SignInByGoogle>{

  FirebaseUser user;

  Future<bool> _loginUser() async {
    final api = await FirebaseApi.signInWithGoogle();
    if (api != null) {
      user = api.firebaseUser;
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
          bool b = await _loginUser();
          if(b){
            Navigator.push(context, ScaleRoute(page: WelcomePage()));
          }else{
            print("Something went wrong");
          }
      },
      child: Image.asset("images/google.png"),
    );
  }


}