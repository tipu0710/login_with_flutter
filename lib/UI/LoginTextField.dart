import 'package:flutter/material.dart';
import 'package:login_with_flutter/Utils/ConstantValues.dart';
import 'package:login_with_flutter/Utils/AllColor.dart' as constColors;

class TextController extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _TextWidget();
  }

}

class _TextWidget extends State<TextController>{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: TextFieldStyle().textWidget("Phone number",
            constColors.loginBorderColor, Icon(Icons.phone_android)),
        width: 250,
        height: 55,
        margin: EdgeInsets.only(top: 150),
      ),
    );
  }

}