import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/empty_widget.dart';
import '../../constants/erro_widget.dart';
import '../../constants/loading_widget.dart';
import '../../controllers/habito/habito_controller.dart';
import '../../models/user.dart';
import '../../repositories/habito_repository.dart';
import 'card_habito.dart';
import 'custom_fab_habitos_widget.dart';

class HabitosScreen extends StatefulWidget {
  const HabitosScreen({Key? key}) : super(key: key);

  @override
  State<HabitosScreen> createState() => _HabitosScreenState();
}

class _HabitosScreenState extends State<HabitosScreen> {
  HabitoController habitoController = HabitoController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff23212C),
      appBar: AppBar(
        backgroundColor: const Color(0xff23212C),
        title: Text(
          'Hábitos',
          style: GoogleFonts.urbanist(
            color: Colors.white,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: HabitoRepository().listHabitos(),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return const ErroWidget();
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }

          List<Habitos> habitos = [];

          if (snapshot.data!.docs[0]['habitos'] != null) {
            habitos = (snapshot.data!.docs[0]['habitos'] as List)
                .map((e) => Habitos.fromJson(e))
                .toList();
          }

          if (habitos.isEmpty) {
            return const EmptyWidget();
          }

          return ListView.builder(
            itemCount: habitos.length,
            itemBuilder: (context, index) {
              var habito = habitos[index];

              return CardHabito(
                habito: habito,
                habitoController: habitoController,
              );
            },
          );
        }),
      ),
      floatingActionButton: const CustomFABHabitoWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
