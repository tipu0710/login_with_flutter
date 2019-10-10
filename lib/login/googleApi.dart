import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseApi {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static GoogleSignIn _googleSignIn = GoogleSignIn();

  FirebaseUser firebaseUser;

  FirebaseApi(FirebaseUser user) {
    this.firebaseUser = user;
  }

  static Future<FirebaseApi> signInWithGoogle() async {
    _googleSignIn.signOut();
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;

    AuthCredential authCredential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = (await _auth.signInWithCredential(authCredential)).user;

    /* final FirebaseUser user = await _auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    ); */

    assert(user.email != null);
    assert(user.displayName != null);

    assert(await user.getIdToken() != null);

    return FirebaseApi(user);
  }
}