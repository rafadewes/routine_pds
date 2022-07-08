import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/habito/habito_controller.dart';
import '../../models/user.dart';
import 'habito_update.dart';

class CardHabito extends StatelessWidget {
  const CardHabito({
    Key? key,
    required this.habito,
    required this.habitoController,
  }) : super(key: key);

  final Habitos habito;
  final HabitoController habitoController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: ListTile(
          onLongPress: () {
            displayDelete(
              context,
              habito,
              habitoController,
            );
          },
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => HabitoUpdate(
                  habito: habito,
                ),
              ),
            );
          },
          tileColor: const Color(0xff373645),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: Text(
            habito.nomeHabito!,
            style: GoogleFonts.urbanist(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

Future<void> displayDelete(
  BuildContext context,
  Habitos habito,
  HabitoController habitoController,
) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          'Excluir',
          style: GoogleFonts.urbanist(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Você deseja realmente excluir este item?',
          style: GoogleFonts.urbanist(),
        ),
        actions: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: const Color(0xff373645),
              textStyle: const TextStyle(color: Colors.white),
            ),
            child: Text('CANCELAR', style: GoogleFonts.urbanist()),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: const Color(0xffEC008C),
              textStyle: const TextStyle(color: Colors.white),
            ),
            child: Text('SIM', style: GoogleFonts.urbanist()),
            onPressed: () async {
              await habitoController.removeHabito(habito).then((value) {
                Navigator.pop(context);
              });
            },
          ),
        ],
      );
    },
  );
}
