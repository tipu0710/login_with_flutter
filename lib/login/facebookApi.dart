import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class FacebookApi{
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static FacebookLogin _facebookLogin = new FacebookLogin();

  FirebaseUser firebaseUser;

  FacebookApi(FirebaseUser user){
    this.firebaseUser = user;
  }

  static Future<FacebookApi> signInWithFacebook() async{
    final FacebookLoginResult result = await _facebookLogin.logIn(['email', 'public_profile']);
    AuthCredential authCredential = FacebookAuthProvider.getCredential(
      accessToken: result.accessToken.token,
    );

    FirebaseUser user = (await _auth.signInWithCredential(authCredential)).user;

    return FacebookApi(user);
  }
}