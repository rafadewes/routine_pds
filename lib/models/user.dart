class UserModel {
  String? idUsuario;
  String? nome;
  String? email;
  List<Habitos>? habitos;
  List<Emocionario>? emocionario;

  UserModel(
      {this.idUsuario, this.nome, this.email, this.habitos, this.emocionario});

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

  Map<String, dynamic> toMap() {
    return {
      'idUsuario': idUsuario,
      'nome': nome,
      'email': email,
      'habitos': habitos,
      'emocionario': emocionario,
    };
  }
}

class Habitos {
  String? idHabitos;
  String? nomeHabito;
  bool? lembrete;
  List<String>? horarios;
  List<bool>? dias;
  List<int>? notificationId;

  Habitos({
    this.idHabitos,
    this.nomeHabito,
    this.lembrete,
    this.horarios,
    this.dias,
    this.notificationId,
  });

  Habitos.fromJson(Map<String, dynamic> json) {
    idHabitos = json['idHabitos'];
    nomeHabito = json['nomeHabito'];
    lembrete = json['lembrete'];
    horarios = json['horarios'].cast<String>();
    dias = json['dias'].cast<bool>();
    notificationId = json['notificationId'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idHabitos'] = idHabitos;
    data['nomeHabito'] = nomeHabito;
    data['lembrete'] = lembrete;
    data['horarios'] = horarios;
    data['dias'] = dias;
    data['notificationId'] = notificationId;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'idHabitos': idHabitos,
      'nomeHabito': nomeHabito,
      'lembrete': lembrete,
      'horarios': horarios,
      'dias': dias,
      'notificationId': notificationId,
    };
  }

  factory Habitos.fromMap(Map<String, dynamic> map) {
    return Habitos(
      idHabitos: map['idHabitos'],
      nomeHabito: map['nomeHabito'],
      lembrete: map['lembrete'],
      horarios: List<String>.from(map['horarios']),
      dias: List<bool>.from(map['dias']),
      notificationId: List<int>.from(map['notificationId']),
    );
  }
}

class Emocionario {
  String? emocao;
  String? data;
  String? diario;
  String? id;

  Emocionario({this.emocao, this.data, this.diario, this.id});

  Emocionario.fromJson(Map<String, dynamic> json) {
    emocao = json['emocao'];
    data = json['data'];
    diario = json['diario'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['emocao'] = emocao;
    data['data'] = data;
    data['diario'] = diario;
    data['id'] = id;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'emocao': emocao,
      'data': data,
      'diario': diario,
      'id': id,
    };
  }

  factory Emocionario.fromMap(Map<String, dynamic> map) {
    return Emocionario(
      emocao: map['emocao'],
      data: map['data'],
      diario: map['diario'],
      id: map['id'],
    );
  }

  @override
  String toString() {
    return 'Emocionario(emocao: $emocao, data: $data, diario: $diario, id: $id)';
  }
}
