import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldStyle {
  InputDecoration textWidget(String hint, int borderColor, Icon icon) {
    return InputDecoration(
      prefixIcon: IconButton(icon: icon, onPressed: null),
      hintText: hint,
      focusedBorder: new OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        borderSide: BorderSide(width: 1, color: Color(borderColor)),
      ),
      disabledBorder: new OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(width: 1, color: Color(borderColor)),
      ),
      enabledBorder: new OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(width: 1, color: Color(borderColor)),
      ),
    );
  }

}
