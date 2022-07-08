// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habito_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HabitoController on _HabitoControllerBase, Store {
  late final _$notificationAtom =
      Atom(name: '_HabitoControllerBase.notification', context: context);

  @override
  bool get notification {
    _$notificationAtom.reportRead();
    return super.notification;
  }

  @override
  set notification(bool value) {
    _$notificationAtom.reportWrite(value, super.notification, () {
      super.notification = value;
    });
  }

  late final _$diarioAtom =
      Atom(name: '_HabitoControllerBase.diario', context: context);

  @override
  bool get diario {
    _$diarioAtom.reportRead();
    return super.diario;
  }

  @override
  set diario(bool value) {
    _$diarioAtom.reportWrite(value, super.diario, () {
      super.diario = value;
    });
  }

  late final _$valuesAtom =
      Atom(name: '_HabitoControllerBase.values', context: context);

  @override
  List<bool> get values {
    _$valuesAtom.reportRead();
    return super.values;
  }

  @override
  set values(List<bool> value) {
    _$valuesAtom.reportWrite(value, super.values, () {
      super.values = value;
    });
  }

  late final _$horariosAtom =
      Atom(name: '_HabitoControllerBase.horarios', context: context);

  @override
  ObservableList<String> get horarios {
    _$horariosAtom.reportRead();
    return super.horarios;
  }

  @override
  set horarios(ObservableList<String> value) {
    _$horariosAtom.reportWrite(value, super.horarios, () {
      super.horarios = value;
    });
  }

  late final _$addHabitoAsyncAction =
      AsyncAction('_HabitoControllerBase.addHabito', context: context);

  @override
  Future<ResultMessage> addHabito(String text) {
    return _$addHabitoAsyncAction.run(() => super.addHabito(text));
  }

  late final _$removeHabitoAsyncAction =
      AsyncAction('_HabitoControllerBase.removeHabito', context: context);

  @override
  Future<void> removeHabito(Habitos habitos) {
    return _$removeHabitoAsyncAction.run(() => super.removeHabito(habitos));
  }

  late final _$updateHabitoAsyncAction =
      AsyncAction('_HabitoControllerBase.updateHabito', context: context);

  @override
  Future<ResultMessage> updateHabito(Habitos habito, String text) {
    return _$updateHabitoAsyncAction
        .run(() => super.updateHabito(habito, text));
  }

  late final _$_HabitoControllerBaseActionController =
      ActionController(name: '_HabitoControllerBase', context: context);

  @override
  dynamic setHorarios(List<String> oldHours) {
    final _$actionInfo = _$_HabitoControllerBaseActionController.startAction(
        name: '_HabitoControllerBase.setHorarios');
    try {
      return super.setHorarios(oldHours);
    } finally {
      _$_HabitoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setNotification(bool value) {
    final _$actionInfo = _$_HabitoControllerBaseActionController.startAction(
        name: '_HabitoControllerBase.setNotification');
    try {
      return super.setNotification(value);
    } finally {
      _$_HabitoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setDiario(bool value) {
    final _$actionInfo = _$_HabitoControllerBaseActionController.startAction(
        name: '_HabitoControllerBase.setDiario');
    try {
      return super.setDiario(value);
    } finally {
      _$_HabitoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setValues(List<bool> newList) {
    final _$actionInfo = _$_HabitoControllerBaseActionController.startAction(
        name: '_HabitoControllerBase.setValues');
    try {
      return super.setValues(newList);
    } finally {
      _$_HabitoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setValuesIndex(bool value, int index) {
    final _$actionInfo = _$_HabitoControllerBaseActionController.startAction(
        name: '_HabitoControllerBase.setValuesIndex');
    try {
      return super.setValuesIndex(value, index);
    } finally {
      _$_HabitoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addHorario(String horario) {
    final _$actionInfo = _$_HabitoControllerBaseActionController.startAction(
        name: '_HabitoControllerBase.addHorario');
    try {
      return super.addHorario(horario);
    } finally {
      _$_HabitoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removerHorario(int index) {
    final _$actionInfo = _$_HabitoControllerBaseActionController.startAction(
        name: '_HabitoControllerBase.removerHorario');
    try {
      return super.removerHorario(index);
    } finally {
      _$_HabitoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic resetElements() {
    final _$actionInfo = _$_HabitoControllerBaseActionController.startAction(
        name: '_HabitoControllerBase.resetElements');
    try {
      return super.resetElements();
    } finally {
      _$_HabitoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
notification: ${notification},
diario: ${diario},
values: ${values},
horarios: ${horarios}
    ''';
  }
}
