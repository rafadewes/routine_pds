import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/empty_widget.dart';
import '../../constants/erro_widget.dart';
import '../../constants/loading_widget.dart';
import '../../controllers/emocionario/emocionario_controller.dart';
import '../../models/user.dart';
import '../../repositories/emocionario_repository.dart';
import 'card_emocionario.dart';
import 'custom_fab_emocionario_widget.dart';

class EmocionarioScreen extends StatefulWidget {
  const EmocionarioScreen({Key? key}) : super(key: key);

  @override
  State<EmocionarioScreen> createState() => _EmocionarioState();
}

class _EmocionarioState extends State<EmocionarioScreen> {
  EmocionarioController? emocionarioController;

  @override
  void initState() {
    super.initState();
    emocionarioController = EmocionarioController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff23212C),
      appBar: AppBar(
        backgroundColor: const Color(0xff23212C),
        title: Text(
          'Emocionário',
          style: GoogleFonts.urbanist(
            color: Colors.white,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: EmocionarioRepository().listEmotions(),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return const ErroWidget();
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }

          List<Emocionario> emocionario = [];

          if (snapshot.data!.docs[0]['emocionario'] != null) {
            emocionario = (snapshot.data!.docs[0]['emocionario'] as List)
                .map((e) => Emocionario.fromJson(e))
                .toList();
          }

          if (emocionario.isEmpty) {
            return const EmptyWidget();
          }

          return ListView.builder(
            itemCount: emocionario.length,
            itemBuilder: (context, index) {
              var emocao = emocionario[index];

              return CardEmocionario(
                emocao: emocao,
                emocionarioController: emocionarioController!,
              );
            },
          );
        }),
      ),
      floatingActionButton: const CustomFABEmocionarioWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
