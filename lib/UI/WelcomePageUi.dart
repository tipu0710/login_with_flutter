import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_with_flutter/UI/LoginUi.dart';
import 'package:login_with_flutter/Utils/AllColor.dart' as constColors;
import 'package:login_with_flutter/animation/ScaleTransition.dart';

class WelcomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Welcome();
  }
}

class _Welcome extends State<WelcomePage> {
  FirebaseUser user;
  String name;

  Future<String> getName() async {
    user = await FirebaseAuth.instance.currentUser();
    if (user.email == null || user.email == "") {
      setState(() {
        var databaseReference = FirebaseDatabase.instance.reference();
        databaseReference
            .child("user")
            .child(user.uid)
            .child("name")
            .once()
            .then((snapshot) {
          if (snapshot.value == null) {
            name = "Welcome";
          } else {
            name = "Welcome ${snapshot.value}";
          }
        });
      });
      return name;
    } else {
      return "Welcome ${user.displayName}";
    }
  }

  getUser() async {
    user = await FirebaseAuth.instance.currentUser();
    if (user == null) {
      Navigator.pushAndRemoveUntil(
        context,
        ScaleRoute(page: LoginPage()),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  initState() {
    setState(() {
      getUser();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            //background curves
            Image.asset(
              "images/welcome_curves_back.png",
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),

            //human icon
            SingleChildScrollView(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      //computer icon
                      child: Image.asset(
                        "images/welcome_icon.png",
                        width: 301.63,
                        height: 299.02,
                      ),
                      margin: EdgeInsets.only(top: 100),
                    ),

                    //Welcome note
                    FutureBuilder(
                      future: getName(),
                      builder: ((context, snapshot) {
                        return Container(
                          margin: EdgeInsets.only(top: 30),
                          child: Text(
                            snapshot.data != null ? snapshot.data : "",
                            style: TextStyle(
                                fontSize: 22,
                                color: Color(constColors.welcomeColor),
                                fontWeight: FontWeight.bold),
                          ),
                        );
                      }),
                    ),

                    //Logout Button
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      child: RaisedButton(
                        onPressed: () {
                          signOut();
                          Navigator.pushAndRemoveUntil(
                            context,
                            ScaleRoute(page: LoginPage()),
                            (Route<dynamic> route) => false,
                          );
                        },
                        color: Color(constColors.welcomeButtonColor),
                        child: Text(
                          "Logout",
                          style: TextStyle(color: Colors.white),
                        ),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  signOut() async {
    await FirebaseAuth.instance.signOut().then((_) {
      GoogleSignIn _googleSignIn = new GoogleSignIn();
      FacebookLogin _facebookLogin = FacebookLogin();
      _googleSignIn.signOut();
      _facebookLogin.logOut();
    });
  }

  Future<bool> _onBackPressed() async {
    //back press code...
    return SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}
