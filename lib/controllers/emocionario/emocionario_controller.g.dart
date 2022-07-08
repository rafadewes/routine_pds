// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emocionario_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EmocionarioController on EmocionarioControllerBase, Store {
  late final _$selectedDateAtom =
      Atom(name: 'EmocionarioControllerBase.selectedDate', context: context);

  @override
  DateTime? get selectedDate {
    _$selectedDateAtom.reportRead();
    return super.selectedDate;
  }

  @override
  set selectedDate(DateTime? value) {
    _$selectedDateAtom.reportWrite(value, super.selectedDate, () {
      super.selectedDate = value;
    });
  }

  late final _$calendarSelectDateAtom = Atom(
      name: 'EmocionarioControllerBase.calendarSelectDate', context: context);

  @override
  DateTime get calendarSelectDate {
    _$calendarSelectDateAtom.reportRead();
    return super.calendarSelectDate;
  }

  @override
  set calendarSelectDate(DateTime value) {
    _$calendarSelectDateAtom.reportWrite(value, super.calendarSelectDate, () {
      super.calendarSelectDate = value;
    });
  }

  late final _$newEmotionAsyncAction =
      AsyncAction('EmocionarioControllerBase.newEmotion', context: context);

  @override
  Future<ResultMessage> newEmotion(Emocionario emocionario) {
    return _$newEmotionAsyncAction.run(() => super.newEmotion(emocionario));
  }

  late final _$removeEmotionAsyncAction =
      AsyncAction('EmocionarioControllerBase.removeEmotion', context: context);

  @override
  Future<void> removeEmotion(Emocionario emocionario) {
    return _$removeEmotionAsyncAction
        .run(() => super.removeEmotion(emocionario));
  }

  late final _$EmocionarioControllerBaseActionController =
      ActionController(name: 'EmocionarioControllerBase', context: context);

  @override
  dynamic setSelectedDate(DateTime newDate) {
    final _$actionInfo = _$EmocionarioControllerBaseActionController
        .startAction(name: 'EmocionarioControllerBase.setSelectedDate');
    try {
      return super.setSelectedDate(newDate);
    } finally {
      _$EmocionarioControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic resetSelectedDate() {
    final _$actionInfo = _$EmocionarioControllerBaseActionController
        .startAction(name: 'EmocionarioControllerBase.resetSelectedDate');
    try {
      return super.resetSelectedDate();
    } finally {
      _$EmocionarioControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCalendarSelectDate(DateTime newDate) {
    final _$actionInfo = _$EmocionarioControllerBaseActionController
        .startAction(name: 'EmocionarioControllerBase.setCalendarSelectDate');
    try {
      return super.setCalendarSelectDate(newDate);
    } finally {
      _$EmocionarioControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic resetCalendarSelectDate() {
    final _$actionInfo = _$EmocionarioControllerBaseActionController
        .startAction(name: 'EmocionarioControllerBase.resetCalendarSelectDate');
    try {
      return super.resetCalendarSelectDate();
    } finally {
      _$EmocionarioControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedDate: ${selectedDate},
calendarSelectDate: ${calendarSelectDate}
    ''';
  }
}
