import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:login_with_flutter/Utils/ConstantValues.dart';
import 'package:login_with_flutter/Utils/AllColor.dart' as constColors;
import 'package:login_with_flutter/animation/ScaleTransition.dart';

import 'WelcomePageUi.dart';

class NewUserStateFullWidget extends StatefulWidget {
  final FirebaseUser user;

  NewUserStateFullWidget(this.user);

  @override
  State<StatefulWidget> createState() {
    return _StateFullWidget();
  }
}

class _StateFullWidget extends State<NewUserStateFullWidget> {
  String name;
  String status;

  TextEditingController _nameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          height: 275,
          margin: EdgeInsets.only(top: 350),
          child: Column(
            children: <Widget>[
              //name
              Container(
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: _nameController,
                  decoration: TextFieldStyle().textWidget(
                    "Name",
                    constColors.signUpNameBorderColor,
                    Icon(Icons.perm_identity),
                  ),
                  keyboardType: TextInputType.text,
                ),
                width: 250,
                height: 55,
                margin: EdgeInsets.only(top: 10),
              ),

              //next button
              Container(
                margin: EdgeInsets.only(top: 15),
                height: 43,
                width: 136,
                child: RaisedButton(
                  onPressed: () {
                    setState(() {
                      checkEveryThing();
                    });
                  },
                  color: Color(constColors.signUpButtonColor),
                  child: Text(
                    "Finish",
                    style: TextStyle(color: Colors.white),
                  ),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMessage(String status) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(status),
        action:
            SnackBarAction(label: '', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  void checkEveryThing() {
    setState(() {
      this.name = _nameController.text;

      if(_nameController.text=="" || _nameController.text==null){
        setState(() {
          status = "Enter your name!";
          _showMessage(status);
        });
      }else{
        var databaseReference = FirebaseDatabase.instance.reference();
        databaseReference.child("user").child(widget.user.providerData[0].uid).set({
          'name':'$name',
          'phone':'${widget.user.providerData[0].phoneNumber}'
        }).then((_){
          Navigator.push(context, ScaleRoute(page: WelcomePage()));
        });
      }
    });
  }

}
