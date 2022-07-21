import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/pomodoro/pomodoro.dart';
import 'cronometro_botao.dart';

class Cronometro extends StatefulWidget {
  final PomodoroStore store;
  const Cronometro({Key? key, required this.store}) : super(key: key);

  @override
  State<Cronometro> createState() => _CronometroState();
}

class _CronometroState extends State<Cronometro> {
  static AudioCache player = AudioCache();

  @override
  void initState() {
    super.initState();
    player.load('bell.mp3');
  }

  playsound() {
    player.play('bell.mp3');
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (widget.store.minutos == 0 && widget.store.segundos == 0) {
          playsound();
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.store.estaTrabalhando() ? 'Foco' : 'Descanso',
              style: GoogleFonts.urbanist(fontSize: 40, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Text(
              '${widget.store.minutos.toString().padLeft(2, '0')}:${widget.store.segundos.toString().padLeft(2, '0')}',
              style: GoogleFonts.urbanist(fontSize: 120, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!widget.store.iniciado)
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: CronometroBotao(
                      texto: 'Iniciar',
                      icone: Icons.play_arrow,
                      click: widget.store.iniciar,
                    ),
                  ),
                if (widget.store.iniciado)
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: CronometroBotao(
                      texto: 'Parar',
                      icone: Icons.stop,
                      click: widget.store.parar,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: CronometroBotao(
                    texto: 'Reiniciar',
                    icone: Icons.refresh,
                    click: widget.store.reiniciar,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
