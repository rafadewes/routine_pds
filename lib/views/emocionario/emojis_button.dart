import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../controllers/emocionario/emocionario_controller.dart';
import '../../models/result_message.dart';
import '../../models/user.dart';

class EmojiButton extends StatelessWidget {
  final String image;
  final String emocao;
  final double a;
  final double b;
  final EmocionarioController emocionarioController;
  const EmojiButton({
    Key? key,
    required this.image,
    required this.emocao,
    required this.a,
    required this.b,
    required this.emocionarioController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(a, b),
      child: SizedBox(
        height: 55,
        width: 55,
        child: IconButton(
          tooltip: emocao,
          onPressed: () async {
            final emotion = Emocionario(
                data: DateFormat('dd/MM/yyyy')
                    .format(emocionarioController.selectedDate!),
                emocao: emocao,
                diario: 'Escreva algo mais sobre seu dia');

            emocionarioController.newEmotion(emotion).then((value) {
              showResponse(value, context);
              if (value.type == 'success') {
                emocionarioController.resetCalendarSelectDate();
                emocionarioController.resetSelectedDate();
                Navigator.pop(context);
              }
            });
          },
          icon: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
              ),
            ),
          ),
        ),
      ),
    );
  }

  showResponse(ResultMessage message, BuildContext context) {
    switch (message.type) {
      case 'error':
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: message.message,
            textStyle: GoogleFonts.urbanist(color: Colors.white),
          ),
        );
        break;
      case 'success':
        showTopSnackBar(
          context,
          CustomSnackBar.success(
            message: message.message,
            textStyle: GoogleFonts.urbanist(color: Colors.white),
          ),
        );
        break;
      case 'info':
        showTopSnackBar(
          context,
          CustomSnackBar.info(
            backgroundColor: Colors.orange,
            message: message.message,
            textStyle: GoogleFonts.urbanist(color: Colors.white),
          ),
        );
        break;
      default:
        print('erro');
    }
  }
}
