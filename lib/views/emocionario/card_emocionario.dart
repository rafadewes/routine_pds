import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../controllers/emocionario/emocionario_controller.dart';
import '../../models/user.dart';
import '../../repositories/emocionario_repository.dart';

class CardEmocionario extends StatefulWidget {
  final EmocionarioController emocionarioController;
  const CardEmocionario({
    Key? key,
    required this.emocao,
    required this.emocionarioController,
  }) : super(key: key);

  final Emocionario emocao;

  @override
  State<CardEmocionario> createState() => _CardEmocionarioState();
}

class _CardEmocionarioState extends State<CardEmocionario> {
  TextEditingController textFieldController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    textFieldController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ListTile(
        onLongPress: () async {
          await displayDelete(
            context,
            widget.emocao,
            widget.emocionarioController,
          );
        },
        contentPadding: const EdgeInsets.all(12),
        tileColor: const Color(0xff373645),
        title: Text(
          widget.emocao.data!.substring(0, 5),
          style: GoogleFonts.urbanist(color: Colors.white),
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/emojis/${setImage(widget.emocao.emocao!)}.png',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.emocao.emocao!,
                  style: GoogleFonts.urbanist(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                )
              ],
            ),
            TextButton(
              onPressed: () {
                displayTextInputDialog(context, widget.emocao.diario!);
              },
              child: Text(
                widget.emocao.diario == ''
                    ? 'Escreva algo mais sobre seu dia'
                    : widget.emocao.diario!,
                style: GoogleFonts.urbanist(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String setImage(String emocao) {
    switch (emocao) {
      case 'Feliz':
        return 'smile';
      case 'Normal':
        return 'neutral';
      case 'Irritado':
        return 'angry';
      case 'Triste':
        return 'crying';
      case 'Apaixonado':
        return 'love';
      case 'Chateado':
        return 'sick';
      case 'Cansado':
        return 'sleep';
      case 'Animado':
        return 'cute';
      default:
        return '';
    }
  }

  Future<void> displayTextInputDialog(
    BuildContext context,
    String initial,
  ) async {
    if (initial.isNotEmpty && initial != 'Escreva algo mais sobre seu dia') {
      textFieldController.text = initial;
    }
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: TextField(
            maxLength: 140,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            controller: textFieldController,
            decoration: const InputDecoration(
              hintText: "Escreva algo mais sobre seu dia",
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xffEC008C)),
              ),
            ),
            cursorColor: const Color(0xffEC008C),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xff373645),
                textStyle: const TextStyle(color: Colors.white),
              ),
              child: const Text('CANCEL'),
              onPressed: () {
                textFieldController.clear();
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xffEC008C),
                textStyle: const TextStyle(color: Colors.white),
              ),
              child: const Text('OK'),
              onPressed: () async {
                print(textFieldController.text);
                setState(() {
                  widget.emocao.diario = textFieldController.text;
                });
                textFieldController.clear();
                await EmocionarioRepository().updateEmotion(widget.emocao).then(
                  (value) async {
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> displayDelete(
    BuildContext context,
    Emocionario emocionario,
    EmocionarioController emocionarioController,
  ) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Excluir',
              style: GoogleFonts.urbanist(fontWeight: FontWeight.bold)),
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
                await emocionarioController.removeEmotion(widget.emocao).then(
                  (value) {
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}
