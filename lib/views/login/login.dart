import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobx/mobx.dart';

import '../../controllers/login/login_controller.dart';
import '../../routes/app_router.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginController? loginController;

  final overlayLoading = OverlayEntry(
    builder: (_) {
      return Container(
        color: Colors.black45,
        alignment: Alignment.center,
        child: const CircularProgressIndicator(
          color: Color(0xffEC008C),
        ),
      );
    },
  );

  @override
  void initState() {
    super.initState();
    loginController = LoginController();

    reaction<bool>((_) => loginController!.loading, (isLoading) {
      if (loginController!.loading) {
        Overlay.of(context)?.insert(overlayLoading);
      } else {
        overlayLoading.remove();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff23212C),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 300,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/routine.png'),
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: 300,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xff373645),
                ),
                onPressed: () async {
                  await loginController!.signInWithGoogle().then(
                    (value) {
                      value
                          ? Navigator.of(Routes.navigatorKey.currentContext!)
                              .pushNamedAndRemoveUntil(
                                  '/home', (route) => false)
                          : debugPrint('Erro');
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/google.png'),
                          ),
                        ),
                      ),
                      Text(
                        'Continuar com o Google',
                        style: GoogleFonts.urbanist(),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
