import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  UserService();

  static final _firestore = Firestore.instance;

  static Future<Map<String, dynamic>> getUserInfo(String uid) async {
    DocumentSnapshot snapshot =
        await _firestore.collection('users').document(uid).get();
    return snapshot.data;
  }
}
