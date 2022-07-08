import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import '../../controllers/emocionario/emocionario_controller.dart';
import '../../controllers/login/login_controller.dart';
import '../../models/notification_service.dart';
import '../../routes/app_router.dart';
import 'buttom_navigate.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  LoginController? loginController;
  EmocionarioController? emocionarioController;

  bool valor = false;

  final overlayLoading = OverlayEntry(builder: (_) {
    return Container(
      color: Colors.black45,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(color: Color(0xffEC008C)),
    );
  });

  @override
  void initState() {
    super.initState();
    loginController = LoginController();
    emocionarioController = EmocionarioController();

    setMessage();
    checkNotification();

    reaction<bool>((_) => loginController!.loading, (isLoading) {
      if (loginController!.loading) {
        Overlay.of(context)?.insert(overlayLoading);
      } else {
        overlayLoading.remove();
      }
    });
  }

  checkNotification() async {
    await Provider.of<NotificationService>(context, listen: false)
        .checkForNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff23212C),
      appBar: AppBar(
        backgroundColor: const Color(0xff23212C),
        centerTitle: true,
        title: Container(
          height: 150,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/routine.png'),
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            height: 150,
            width: double.infinity,
            child: Text(
              setMessage(),
              style: GoogleFonts.urbanist(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.count(
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                crossAxisCount: 2,
                children: [
                  ButtonNavigate(
                    text: 'Hábitos',
                    image: 'assets/habitos.png',
                    function: () {
                      Navigator.of(Routes.navigatorKey.currentContext!)
                          .pushNamed('/habitos');
                    },
                  ),
                  ButtonNavigate(
                    text: 'Emocionário',
                    image: 'assets/emocionario.png',
                    function: () {
                      Navigator.of(Routes.navigatorKey.currentContext!)
                          .pushNamed('/emocionario');
                    },
                  ),
                  ButtonNavigate(
                    text: 'Pomodoro',
                    image: 'assets/pomodoro.png',
                    function: () {
                      Navigator.of(Routes.navigatorKey.currentContext!)
                          .pushNamed('/pomodoro');
                    },
                  ),
                  ButtonNavigate(
                    text: 'Sair',
                    image: 'assets/sair.png',
                    function: () async {
                      await loginController!.logout().then(
                        (value) async {
                          value
                              ? Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  '/login',
                                  (route) => false,
                                )
                              : print('ERRO');
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String setMessage() {
    final time = DateTime.now().hour;
    final userName = FirebaseAuth.instance.currentUser!.displayName;

    if (time >= 18) {
      return 'Boa noite, $userName 👋🏼';
    } else if (time >= 13 && time < 18) {
      return 'Boa tarde, $userName 👋🏼';
    } else {
      return 'Bom dia, $userName 👋🏼';
    }
  }
}
