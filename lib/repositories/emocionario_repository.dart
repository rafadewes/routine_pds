import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../models/result_message.dart';
import '../models/user.dart';


class EmocionarioRepository {
  final firebase = FirebaseFirestore.instance.collection('users');

  Stream<QuerySnapshot>? listEmotions() {
    Stream<QuerySnapshot>? emotions;

    try {
      emotions = firebase
          .where('idUsuario', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots(
            includeMetadataChanges: true,
          );
    } catch (e) {
      debugPrint('Erro ao carregar emoções');
    }

    return emotions;
  }

  Future<ResultMessage> addEmotion(Emocionario emocionario) async {
    emocionario.id = DateTime.now().microsecondsSinceEpoch.toString();
    List<Emocionario>? listEmocionario = [];
    ResultMessage resultMessage =
        ResultMessage(type: 'type', message: 'message');

    try {
      await firebase.doc(FirebaseAuth.instance.currentUser!.uid).get().then(
        (value) {
          var user = UserModel.fromJson(value.data()!);
          listEmocionario = user.emocionario;
        },
      );
    } catch (e) {
      resultMessage = ResultMessage(
        type: 'error',
        message: 'Erro ao carregar usuário, impossível salvar emoção',
      );
    }

    try {
      if (!listEmocionario!
          .any((element) => element.data == emocionario.data)) {
        await firebase.doc(FirebaseAuth.instance.currentUser!.uid).update(
          {
            'emocionario': FieldValue.arrayUnion([emocionario.toMap()]),
          },
        ).then((value) async {
          resultMessage = ResultMessage(
            type: 'success',
            message: 'Emoção adicionada com sucesso',
          );
        }).catchError((error) async {
          resultMessage = ResultMessage(
            type: 'error',
            message: 'Erro ao adicionar emoção: $error',
          );
        });
      } else {
        resultMessage = ResultMessage(
          type: 'info',
          message: 'Você não pode adicionar mais de uma emoção por dia!',
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

  Future<void> removeEmotion(Emocionario emocionario) async {
    try {
      firebase
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(
            {
              'emocionario': FieldValue.arrayRemove([emocionario.toMap()]),
            },
          )
          .then((value) => debugPrint("emocao removed"))
          .catchError((error) => debugPrint("Failed to update emocao: $error"));
    } catch (e) {
      debugPrint('Erro ao salvar emocao $e');
    }
  }

  Future<void> updateEmotion(Emocionario emocionario) async {
    List<Emocionario>? listEmocionario = [];

    try {
      await firebase.doc(FirebaseAuth.instance.currentUser!.uid).get().then(
        (value) {
          var user = UserModel.fromJson(value.data()!);
          listEmocionario = user.emocionario;
        },
      );
    } catch (e) {
      print(e);
    }

    for (var element in listEmocionario!) {
      if (element.id == emocionario.id) {
        element.diario = emocionario.diario;
      }
    }

    var map = [];
    if (listEmocionario!.isNotEmpty) {
      for (var element in listEmocionario!) {
        map.add(element.toMap());
      }
    }

    try {
      firebase
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(
            {
              'emocionario': map,
            },
          )
          .then((value) => debugPrint("emocao Updated"))
          .catchError((error) => debugPrint("Failed to update emocao: $error"));
    } catch (e) {
      debugPrint('Erro ao salvar emoção $e');
    }
  }
}
