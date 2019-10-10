import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:login_with_flutter/UI/WelcomePageUi.dart';
import 'package:login_with_flutter/Utils/ConstantValues.dart';
import 'package:login_with_flutter/Utils/AllColor.dart' as constColors;
import 'package:login_with_flutter/animation/EnterExitAnim.dart';
import 'package:login_with_flutter/animation/ScaleTransition.dart';
import 'package:login_with_flutter/animation/loder.dart';

import 'LoginUi.dart';
import 'NewUseUi.dart';

class LoginStateFullWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StateFullWidget();
  }
}

class _StateFullWidget extends State<LoginStateFullWidget> {
  String phoneNo;
  String smsCode;
  String actualCode;
  String status;
  String countryCode = "880";
  FirebaseAuth firebaseAuth;
  bool isLodingDialogOpen = false;

  var _phoneController = new TextEditingController();

  Future verifyPhone() async {
    var firebaseAuth = FirebaseAuth.instance;
    this.firebaseAuth = firebaseAuth;

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      this.actualCode = verificationId;
      smsCodeDialog(context).then((onValue) {
        print("Sms Dialog");
      });
      setState(() {
        print('Code sent to $phoneNo');
        status = "\nEnter the code sent to " + phoneNo;
      });
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      this.actualCode = verificationId;
      status = "Auto retrieval time out";
      if(isLodingDialogOpen){
        isLodingDialogOpen = false;
        Navigator.pop(context);
      }
      _showMessage(status);
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      setState(() {
        status = '${authException.message}';

        if(isLodingDialogOpen){
          isLodingDialogOpen = false;
          Navigator.pop(context);
        }
        print("Error message: " + status);
        if (authException.message.contains('not authorized')) {
          status = 'Something has gone wrong, please try later';
          _showMessage(status);
        } else if (authException.message.contains('Network')) {
          status = 'Please check your internet connection and try again';
          _showMessage(status);
        } else {
          status = 'Something has gone wrong, please try later';
          _showMessage(status);
        }
      });
    };

    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential auth) {
      setState(() {
        status = 'Auto retrieving verification code';
        //_showMessage(status);
      });
      //_authCredential = auth;

      firebaseAuth.signInWithCredential(auth).then((AuthResult value) {
        if (value.user != null) {
          setState(() {
            status = 'Authentication successful';
            onAuthenticationSuccessful(value.user);
            //_showMessage(status);
          });
          //onAuthenticationSuccessful();
        } else {
          if(isLodingDialogOpen){
            isLodingDialogOpen = false;
            Navigator.pop(context);
          }
          setState(() {
            status = 'Invalid code/invalid authentication';
            _showMessage(status);
          });
        }
      }).catchError((error) {
        if(isLodingDialogOpen){
          isLodingDialogOpen = false;
          Navigator.pop(context);
        }
        setState(() {
          status = 'Something has gone wrong, please try later';
          _showMessage(status);
        });
      });
    };

    firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  Future<bool> smsCodeDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(44),
            ),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            child: Stack(
              children: <Widget>[
                //...bottom card part,
                Container(
                  width: 317,
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.only(top: 15),
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(44),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.0,
                        offset: const Offset(0.0, 10.0),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // To make the card compact
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Text(
                          "Verification Code",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color(int.parse(
                                  "#57B6FF".replaceAll('#', '0xff')))),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Container(
                        width: 193,
                        child: TextField(
                          style: TextStyle(letterSpacing: 10),
                          onChanged: (value) {
                            smsCode = value;
                          },
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(
                                        int.parse("#01A5B8".replaceAll('#', '0xff'))),
                                  ))),
                        ),
                      ),
                      SizedBox(height: 24.0),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 27,
                          width: 86,
                          margin: EdgeInsets.only(bottom: 20),
                          child: RaisedButton(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(8.0),
                            ),
                            color: Color(
                                int.parse("#FCE485".replaceAll('#', '0xff'))),
                            elevation: 4,
                            onPressed: () {
                              FirebaseAuth.instance.currentUser().then((user) {
                                if (user != null) {
                                  Navigator.of(context).pop();
                                  onAuthenticationSuccessful(user);
                                } else {
                                  Navigator.of(context).pop();
                                  _signInWithPhoneNumber(smsCode, firebaseAuth);
                                }
                              });
                            },
                            child: Text(
                              "Verify",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //...top circlular image part,
              ],
            ),
          );
        });
  }

  void onAuthenticationSuccessful(FirebaseUser user) async {
    var databaseReference = FirebaseDatabase.instance.reference();
    databaseReference
        .child("user")
        .child(user.providerData[0].uid)
        .once()
        .then((snapshot) {
      if(isLodingDialogOpen){
        isLodingDialogOpen = false;
        Navigator.pop(context);
      }
      if (snapshot.value != null) {
        Navigator.push(context, ScaleRoute(page: WelcomePage()));
      } else {
        Navigator.push(
            context,
            EnterExitRoute(
                exitPage: LoginPage(), enterPage: NewUserPage(user)));
      }
    });
  }

  void _signInWithPhoneNumber(String smsCode, FirebaseAuth firebaseAuth) async {
    AuthCredential _authCredential = PhoneAuthProvider.getCredential(
        verificationId: actualCode, smsCode: smsCode);
    firebaseAuth.signInWithCredential(_authCredential).catchError((error) {
      setState(() {

        smsCodeDialog(context);
        status = 'Something has gone wrong';
        _showMessage(status);
      });
    }).then((user) async {
      setState(() {
        status = 'Authentication successful';
        //_showMessage(status);
      });
      onAuthenticationSuccessful(user.user);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          width: 251,
          height: 150,
          margin: EdgeInsets.only(top: 325),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10),
                margin: EdgeInsets.only(bottom: 5),
                child: CountryPickerDropdown(
                  initialValue: 'BD',
                  itemBuilder: _buildDropdownItem,
                  onValuePicked: (Country country) {
                    this.countryCode = country.phoneCode.toString();
                  },
                ),
              ),

              //phone
              Container(
                child: TextFormField(
                  textAlign: TextAlign.center,
                  decoration: TextFieldStyle().textWidget(
                    "Phone number",
                    constColors.loginBorderColor,
                    Icon(Icons.phone_android),
                  ),
                  keyboardType: TextInputType.phone,
                  controller: _phoneController,
                ),
                height: 55,
              ),

              //LoginButton
              Container(
                height: 43,
                width: 136,
                margin: EdgeInsets.only(top: 20),
                child: RaisedButton(
                  onPressed: () {
                    //pr.show();
                    setState(() {
                      _onLoading();
                      phoneNo = "+$countryCode" + _phoneController.text;
                      //password = _passwordController.text;
                      verifyPhone();
                    });
                  },
                  color: Color(constColors.loginButtonColor),
                  child: Text(
                    "Login",
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

  Widget _buildDropdownItem(Country country) => Container(
        child: Row(
          children: <Widget>[
            //CountryPickerUtils.getDefaultFlagImage(country),

            Text("(${country.isoCode})+${country.phoneCode}"),
          ],
        ),
      );

  void _showMessage(String status) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 3),
        content: Text(status, textAlign: TextAlign.center,),
      ),
    );
  }


  void _onLoading() {
    isLodingDialogOpen = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: ColorLoader3(),
        );
      },
    );
  }
}
