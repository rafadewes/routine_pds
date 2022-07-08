import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobx/mobx.dart';

import 'package:provider/provider.dart';

import '../../models/notification_service.dart';
import '../../models/user.dart';
import '../../repositories/user_repository.dart';
import '../../routes/app_router.dart';
part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final userRepository = UserRepository();
  final notificationService = NotificationService();

  @observable
  bool loading = false;

  @observable
  bool goHome = false;

  @action
  Future<bool> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    loading = true;
    if (googleUser == null) {
      loading = false;
      return false;
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final authUser =
        await FirebaseAuth.instance.signInWithCredential(credential);

    if (await userRepository.userExists(authUser.user!.uid)) {
      final user = await userRepository.pickUser(authUser.user!.uid);

      if (user.habitos!.isNotEmpty) {
        for (var element in user.habitos!) {
          element.notificationId = [];
          if (element.lembrete == true) {
            if (element.dias!.every((element) => element == true)) {
              for (var horario in element.horarios!) {
                var notificarionId = Random().nextInt(10000);
                element.notificationId!.add(notificarionId);
                await Provider.of<NotificationService>(
                  Routes.navigatorKey.currentContext!,
                  listen: false,
                ).scheduleDailyNotification(
                  CustomNotification(
                    notificarionId,
                    'Olá usuário!',
                    element.nomeHabito,
                    'habitos',
                  ),
                  horario,
                );
              }
            } else {
              for (var x = 0; x < element.dias!.length; x++) {
                if (element.dias![x]) {
                  for (var elementHour in element.horarios!) {
                    var notificarionId = Random().nextInt(10000);
                    element.notificationId!.add(notificarionId);
                    await Provider.of<NotificationService>(
                      Routes.navigatorKey.currentContext!,
                      listen: false,
                    ).scheduleWeeklyNotification(
                      CustomNotification(
                        notificarionId,
                        'Olá usuário!',
                        element.nomeHabito,
                        'habitos',
                      ),
                      elementHour,
                      x == 0 ? 7 : x,
                    );
                  }
                }
              }
            }
          }
        }
      }

      await userRepository.updateUser(user);

      loading = false;
      return true;
    } else {
      final user = UserModel(
        email: authUser.user!.email,
        nome: authUser.user!.displayName,
        idUsuario: authUser.user!.uid,
        emocionario: [],
        habitos: [],
      );
      bool response = await userRepository.createUser(user);

      loading = false;
      return response;
    }
  }

  @action
  Future<bool> logout() async {
    loading = true;
    try {
      await GoogleSignIn().disconnect();
      FirebaseAuth.instance.signOut();
      notificationService.cancelAllNotifications();
      loading = false;
      return true;
    } catch (e) {
      Exception('Erro ao se desconectar');
    }
    loading = false;
    return false;
  }
}
