import 'package:flutter/material.dart';
import 'package:login_with_flutter/Utils/AllColor.dart' as constColors;

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Center(
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
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Text(
                    "Welcome X",
                    style: TextStyle(
                        fontSize: 22,
                        color: Color(constColors.welcomeColor),
                        fontWeight: FontWeight.bold),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: RaisedButton(
                    onPressed: () {},
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
        ],
      ),
    );
  }
}
