import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2)).then(
      (_) async {
        try {
          final user = FirebaseAuth.instance.currentUser;
          var response = await FirebaseFirestore.instance
              .collection('users')
              .doc(user!.uid)
              .get();

          if (response.exists) {
            if (!mounted) return;
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/home',
              (route) => false,
            );
          } else {
            if (!mounted) return;
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/login',
              (route) => false,
            );
          }
        } catch (e) {
          Navigator.pushNamedAndRemoveUntil(
              context, '/login', (route) => false);
        }
      },
    );

    return Container(
      color: const Color(0xff23212C),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: const Color(0xff373645),
                borderRadius: BorderRadius.circular(100),
                image: const DecorationImage(
                  image: AssetImage('assets/r.png'),
                ),
              ),
            ),
            const SizedBox(height: 80),
            const CircularProgressIndicator(
              color: Color(0xffEC008C),
            ),
          ],
        ),
      ),
    );
  }
}
