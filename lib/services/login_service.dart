import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
  This class encapsulates static methods to authenticate using
  Firebase Auth for e-mail, Google and Facebook login.
 */
class LoginService {
  static FirebaseAuth auth = FirebaseAuth.instance;

  /*
    Retrieves current Firebase user.
  */
  Future<FirebaseUser> getCurrentUser() {
    return FirebaseAuth.instance.currentUser();
  }

  /* Sign in with email and password in FirebaseAuth.
  */
  static Future<void> emailLogin(String email, String password) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  /*
    Connects to Google Auth to get gredential. 
    If successful, authenticate in Firebase with credential. 
   */
  static Future<void> googleLogin() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount user = googleSignIn.currentUser;

    // try sign in silently first
    if (user == null) user = await googleSignIn.signInSilently();
    // if user is still null, then opens sign in pop up
    if (user == null) user = await googleSignIn.signIn();

    GoogleSignInAuthentication googleAuth =
        await googleSignIn.currentUser.authentication;
    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  /*
    Connects to Google Auth to get gredential. 
    If successful, authenticate in Firebase with credential. 
   */
  static Future<void> facebookLogin() async {
    final FacebookLoginResult facebookLoginResult =
        await FacebookLogin().logIn(['email', 'public_profile']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        break;
      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.loggedIn:
        FacebookAccessToken facebookAccessToken =
            facebookLoginResult.accessToken;
        AuthCredential authCredential = FacebookAuthProvider.getCredential(
            accessToken: facebookAccessToken.token);
        await firebaseLoginWithCredential(authCredential);
        break;
    }
  }

  static Future firebaseLoginWithCredential(AuthCredential credential) async {
    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  /*
    Try to logout with every authenticate method.
    In each try, checks first if user using that authentication.
    Always sign out from Firebase and clear shared preferences.
  */
  static Future<void> logOut() async {
    await _googleLogout();
    await _facebookLogout();
    await _firebaseLogout();
    await _clearPreferences();
  }

  static Future _googleLogout() async {
    final GoogleSignIn googleSignIn = new GoogleSignIn();
    bool isSignedInGoogle = await googleSignIn.isSignedIn();
    if (isSignedInGoogle) {
      await googleSignIn.signOut();
      if (!isSignedInGoogle)
        print("Successful logged out from Google");
      else
        print("Couldn't sign out from Google");
    }
  }

  static Future _facebookLogout() async {
    final facebookLogin = FacebookLogin();
    bool isLoggedInFacebook = await facebookLogin.isLoggedIn;
    if (isLoggedInFacebook) {
      await facebookLogin.logOut();
      if (!isLoggedInFacebook)
        print('Successful logged out from Facebook');
      else
        print("Couldn't sign out from Facebook");
    }
  }

  static Future _firebaseLogout() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future _clearPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
