import 'package:flutter/material.dart';
import 'package:login_with_flutter/Utils/ConstantValues.dart';
import 'package:login_with_flutter/Utils/AllColor.dart' as constColors;

class SignUpTextController extends StatefulWidget{

  final bool isName;

  SignUpTextController(this.isName);

  @override
  State<StatefulWidget> createState() {
    return isName?_TextNameWidget():_TextPhoneWidget();
  }

}

class _TextNameWidget extends State<SignUpTextController>{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: TextFieldStyle().textWidget("Name",
            constColors.signUpNameBorderColor, Icon(Icons.perm_identity)),
        width: 250,
        height: 55,
        margin: EdgeInsets.only(top: 45),
      ),
    );

  }

}

class _TextPhoneWidget extends State<SignUpTextController>{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: TextFieldStyle().textWidget("Phone Number",
            constColors.loginBorderColor, Icon(Icons.phone_android)),
        width: 250,
        height: 55,
        margin: EdgeInsets.only(top: 185),
      ),
    );
  }
}