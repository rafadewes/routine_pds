import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/user.dart';


class UserRepository {
  final firebase = FirebaseFirestore.instance;

  Future<bool> userExists(String id) async {
    DocumentSnapshot<Map<String, dynamic>?>? user;

    try {
      user = await firebase.collection('users').doc(id).get();
    } catch (e) {
      debugPrint('Erro ao carregar usuario');
    }

    if (user != null && user.exists) {
      return true;
    } else {
      return false;
    }
  }

  Future<UserModel> pickUser(String id) async {
    var user = UserModel();
    try {
      await firebase.collection('users').doc(id).get().then(
        (value) async {
          user = UserModel.fromJson(value.data()!);
        },
      );
    } catch (e) {
      print(e);
    }

    return user;
  }

  Future<void> updateUser(UserModel user) async {
    var emocionario = [];

    for (var element in user.emocionario!) {
      var emocao = Emocionario(
          data: element.data,
          diario: element.diario,
          emocao: element.emocao,
          id: element.id);
      emocionario.add(emocao.toMap());
    }

    var habitos = [];

    for (var element in user.habitos!) {
      var habito = Habitos(
          dias: element.dias,
          horarios: element.horarios,
          idHabitos: element.idHabitos,
          lembrete: element.lembrete,
          nomeHabito: element.nomeHabito,
          notificationId: element.notificationId);
      habitos.add(habito.toMap());
    }

    try {
      await firebase.collection('users').doc(user.idUsuario!).set({
        'email': user.email,
        'idUsuario': user.idUsuario,
        'nome': user.nome,
        'emocionario': emocionario,
        'habitos': habitos,
      });
    } catch (e) {
      print(e);
    }
  }

  Future<bool> createUser(UserModel user) async {
    try {
      await firebase.collection('users').doc(user.idUsuario).set(user.toJson());
      return true;
    } on Exception catch (e) {
      Exception('Fail to create user $e');
      return false;
    }
  }
}
