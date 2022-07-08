import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CronometroBotao extends StatelessWidget {
  final String texto;
  final IconData icone;
  final void Function()? click;

  const CronometroBotao({
    Key? key,
    required this.texto,
    required this.icone,
    this.click,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: const Color(0xff373645),
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 20,
        ),
        textStyle: GoogleFonts.urbanist(fontSize: 25, color: Colors.white),
      ),
      onPressed: click,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(
              icone,
              size: 27,
            ),
          ),
          Text(
            texto,
            style: GoogleFonts.urbanist(fontSize: 25, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
