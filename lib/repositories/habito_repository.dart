import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import '../models/result_message.dart';
import '../models/user.dart';

class HabitoRepository {
  final firebase = FirebaseFirestore.instance.collection('users');

  Stream<QuerySnapshot>? listHabitos() {
    Stream<QuerySnapshot>? habitos;

    try {
      habitos = firebase
          .where('idUsuario', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots(
            includeMetadataChanges: true,
          );
    } catch (e) {
      debugPrint('Erro ao carregar emocoes');
    }

    return habitos;
  }

  Future<ResultMessage> addHabito(Habitos habito) async {
    List<Habitos>? listHabitos = [];
    ResultMessage resultMessage =
        ResultMessage(type: 'type', message: 'message');

    try {
      await firebase.doc(FirebaseAuth.instance.currentUser!.uid).get().then(
        (value) {
          var user = UserModel.fromJson(value.data()!);
          listHabitos = user.habitos;
        },
      );
    } catch (e) {
      resultMessage = ResultMessage(
        type: 'error',
        message: 'Erro ao carregar usuario, impossivel salvar emoção',
      );
    }

    try {
      if (!listHabitos!
          .any((element) => element.idHabitos == habito.idHabitos)) {
        await firebase.doc(FirebaseAuth.instance.currentUser!.uid).update(
          {
            'habitos': FieldValue.arrayUnion([habito.toMap()]),
          },
        ).then((value) async {
          resultMessage = ResultMessage(
            type: 'success',
            message: 'Habito adicionado com sucesso',
          );
        }).catchError((error) async {
          resultMessage = ResultMessage(
            type: 'error',
            message: 'Erro ao adicionar Habito: $error',
          );
        });
      } else {
        resultMessage = ResultMessage(
          type: 'info',
          message: 'Você não pode adicionar.',
        );
      }
    } catch (e) {
      resultMessage = ResultMessage(
        type: 'error',
        message: 'Error: $e',
      );
    }

    return resultMessage;
  }

  Future<void> removeHabito(Habitos habito) async {
    try {
      firebase
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(
            {
              'habitos': FieldValue.arrayRemove([habito.toMap()]),
            },
          )
          .then((value) => debugPrint("habito removed"))
          .catchError((error) => debugPrint("Failed to update habito: $error"));
    } catch (e) {
      debugPrint('Erro ao salvar habito $e');
    }
  }

  Future<ResultMessage> updateHabito(Habitos habito) async {
    List<Habitos>? listHabitos = [];
    ResultMessage resultMessage =
        ResultMessage(type: 'info', message: 'message');

    try {
      await firebase.doc(FirebaseAuth.instance.currentUser!.uid).get().then(
        (value) {
          var user = UserModel.fromJson(value.data()!);
          listHabitos = user.habitos;
        },
      );
    } catch (e) {
      print(e);
    }

    for (var element in listHabitos!) {
      if (element.idHabitos == habito.idHabitos) {
        element.horarios = habito.horarios;
        element.lembrete = habito.lembrete;
        element.nomeHabito = habito.nomeHabito;
        element.notificationId = habito.notificationId;
        element.dias = habito.dias;
      }
    }

    var map = [];
    if (listHabitos!.isNotEmpty) {
      for (var element in listHabitos!) {
        map.add(element.toMap());
      }
    }

    try {
      await firebase.doc(FirebaseAuth.instance.currentUser!.uid).update(
        {
          'habitos': map,
        },
      ).then((value) async {
        resultMessage = ResultMessage(
          type: 'success',
          message: 'Habito alterado com sucesso',
        );
      }).catchError((error) async {
        resultMessage = ResultMessage(
          type: 'error',
          message: 'Erro ao alterar Habito: $error',
        );
      });
    } catch (e) {
      resultMessage = ResultMessage(
        type: 'error',
        message: 'Error: $e',
      );
    }

    return resultMessage;
  }
}
