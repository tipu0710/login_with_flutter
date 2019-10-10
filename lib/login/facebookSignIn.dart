import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_with_flutter/UI/WelcomePageUi.dart';
import 'package:login_with_flutter/animation/ScaleTransition.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'facebookApi.dart';

class FacebookSignIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FacebookSignIn();
  }
}

class _FacebookSignIn extends State<FacebookSignIn> {

  FirebaseUser user;
  ProgressDialog pr;

  Future<bool> _loginUser() async {
    final api = await FacebookApi.signInWithFacebook();
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
      child: Image.asset("images/facebook.png"),
    );
  }

}
