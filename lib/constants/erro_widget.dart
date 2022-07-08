import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ErroWidget extends StatelessWidget {
  const ErroWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 250,
            width: 250,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/erro.png'),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Ops...!',
            textAlign: TextAlign.center,
            style: GoogleFonts.urbanist(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Ocorreu algo inesperado, tente reiniciar o aplicativo!',
            textAlign: TextAlign.center,
            style: GoogleFonts.urbanist(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
