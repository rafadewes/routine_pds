import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  Future<DocumentSnapshot<Map<String, dynamic>>> userExist(String uid) async {
    final user =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    return user;
  }
}
