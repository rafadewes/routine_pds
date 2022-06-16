class UserModel {
  String? idUsuario;
  String? nome;
  String? email;
  List<Habitos>? habitos;
  List<Emocionario>? emocionario;

  UserModel({this.idUsuario, this.nome, this.email, this.habitos, this.emocionario});

  UserModel.fromJson(Map<String, dynamic> json) {
    idUsuario = json['idUsuario'];
    nome = json['nome'];
    email = json['email'];
    if (json['habitos'] != null) {
      habitos = <Habitos>[];
      json['habitos'].forEach((v) {
        habitos!.add(Habitos.fromJson(v));
      });
    }
    if (json['emocionario'] != null) {
      emocionario = <Emocionario>[];
      json['emocionario'].forEach((v) {
        emocionario!.add(Emocionario.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idUsuario'] = idUsuario;
    data['nome'] = nome;
    data['email'] = email;
    if (habitos != null) {
      data['habitos'] = habitos!.map((v) => v.toJson()).toList();
    }
    if (emocionario != null) {
      data['emocionario'] = emocionario!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Habitos {
  String? idHabitos;
  String? nomeHabito;
  bool? repeticao;
  bool? lembrete;
  List<String>? horarios;

  Habitos(
      {this.idHabitos,
      this.nomeHabito,
      this.repeticao,
      this.lembrete,
      this.horarios});

  Habitos.fromJson(Map<String, dynamic> json) {
    idHabitos = json['idHabitos'];
    nomeHabito = json['nomeHabito'];
    repeticao = json['repeticao'];
    lembrete = json['lembrete'];
    horarios = json['horarios'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idHabitos'] = idHabitos;
    data['nomeHabito'] = nomeHabito;
    data['repeticao'] = repeticao;
    data['lembrete'] = lembrete;
    data['horarios'] = horarios;
    return data;
  }
}

class Emocionario {
  String? emocao;
  String? dia;
  String? diario;

  Emocionario({this.emocao, this.dia, this.diario});

  Emocionario.fromJson(Map<String, dynamic> json) {
    emocao = json['emocao'];
    dia = json['dia'];
    diario = json['diario'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['emocao'] = emocao;
    data['dia'] = dia;
    data['diario'] = diario;
    return data;
  }
}