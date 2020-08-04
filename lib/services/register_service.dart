import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_functions/cloud_functions.dart';

/*
  This class uses external libraries from Firebase, Google and 
  Facebook to register new users in the application.
 */
class RegisterService {
  /*
    Try to register the given e-mail and password in Firebase Auth.
    If successful, register user data in Firestore.
  */
  static Future<void> registerWithEmail(
      String name, String email, String password) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final Firestore firestore = Firestore.instance;

    // creates user in firebase auth
    final result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    print("Successfully created new user ${result.user.uid}");

    // send e-mail verification
    result.user.sendEmailVerification();

    // saves user data in firestore
    firestore.document('users/${result.user.uid}').setData({
      'uid': result.user.uid,
      'email': email,
      'name': name,
      'profileImageUrl':
          "https://upload.wikimedia.org/wikipedia/commons/7/70/User_icon_BLACK-01.png",
    });
  }

  /*
    Inicia um processo de registro com o Google. O processo de autenticação 
    com Google é realizado no app, e as credenciais são em seguida enviadas 
    para registro do usuário via Cloud Functions.
    Para o registro ocorrer com sucesso, é necessário que existam keystores
    de debug e de release (para APK/PlayStore) registradas no projeto no Firebase.
  */
  static Future<bool> registerWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn(scopes: [
        'https://www.googleapis.com/auth/userinfo.email',
        'https://www.googleapis.com/auth/userinfo.profile'
      ]);
      GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      final googleAuth = await googleSignInAccount.authentication;
      return await _registerGoogleUserWithTokens(
          googleAuth.idToken, googleAuth.accessToken);
    } catch (e) {
      return false;
    }
  }

  static Future<bool> _registerGoogleUserWithTokens(
      String idToken, String accessToken) async {
    try {
      final HttpsCallable callable = CloudFunctions.instance
          .getHttpsCallable(functionName: 'registerGoogleUser');
      callable.timeout = const Duration(seconds: 30);
      await callable.call(
          <String, dynamic>{"idToken": idToken, "accessToken": accessToken});
      return true;
    } on CloudFunctionsException catch (e) {
      print(e.code);
      return false;
    } catch (e) {
      print('Caught generic Exception: $e');
      return false;
    }
  }
}
