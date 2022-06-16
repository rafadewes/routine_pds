import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobx/mobx.dart';
import 'package:routine_pds/controllers/login/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController? loginController;

  @override
  void initState() {
    super.initState();
    loginController = LoginController();
  }

  @override
  void didChangeDependencies() {
    autorun((r) {
      if (loginController!.logged == true) {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      }
    });

    super.didChangeDependencies();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff23212C),
        body: SafeArea(
          child: LayoutBuilder(
            builder: ((context, constraints) {
              return SizedBox(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Entrar',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: constraints.maxHeight * .04,
                      ),
                    ),
                    Container(
                      width: constraints.maxWidth * .7,
                      height: constraints.maxHeight * .2,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/routine.png'),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: constraints.maxWidth * .6,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xff373645),
                          ),
                          onPressed: () => loginController!.login(),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: constraints.maxWidth * .07,
                                  height: constraints.maxHeight * .05,
                                  alignment: Alignment.center,
                                  child: SvgPicture.asset(
                                      'assets/icons/google.svg'),
                                ),
                                const SizedBox(width: 20),
                                const Text('Entrar com o Google'),
                              ],
                            ),
                          )),
                    )
                  ],
                ),
              );
            }),
          ),
        ));
  }
}
