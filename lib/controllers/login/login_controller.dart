import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobx/mobx.dart';
import 'package:routine_pds/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  @observable
  Exception? error;



  @observable
  bool logged = false;

  @action
  Future<void> login() async {

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((auth) async {
        if (auth.user != null) {
          final user = await FirebaseFirestore.instance
              .collection('users')
              .doc(auth.user!.uid)
              .get();

          if (user.exists) {
            final prefs = await SharedPreferences.getInstance();
            try {
              await prefs.setBool('logged', true);
              logged = true;
            } catch (e) {
              print(e.toString());
            }
          } else {
            final user = UserModel(
              email: auth.user!.email,
              idUsuario: auth.user!.uid,
              nome: auth.user!.displayName,
              emocionario: [],
              habitos: [],
            );

            await FirebaseFirestore.instance
                .collection('users')
                .doc(auth.user!.uid)
                .set(
                  user.toJson(),
                ).then((value) {
                  logged = true;
                });
          }
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
