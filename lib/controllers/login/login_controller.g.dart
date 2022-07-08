// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginController on _LoginControllerBase, Store {
  late final _$loadingAtom =
      Atom(name: '_LoginControllerBase.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$goHomeAtom =
      Atom(name: '_LoginControllerBase.goHome', context: context);

  @override
  bool get goHome {
    _$goHomeAtom.reportRead();
    return super.goHome;
  }

  @override
  set goHome(bool value) {
    _$goHomeAtom.reportWrite(value, super.goHome, () {
      super.goHome = value;
    });
  }

  late final _$signInWithGoogleAsyncAction =
      AsyncAction('_LoginControllerBase.signInWithGoogle', context: context);

  @override
  Future<bool> signInWithGoogle() {
    return _$signInWithGoogleAsyncAction.run(() => super.signInWithGoogle());
  }

  late final _$logoutAsyncAction =
      AsyncAction('_LoginControllerBase.logout', context: context);

  @override
  Future<bool> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  @override
  String toString() {
    return '''
loading: ${loading},
goHome: ${goHome}
    ''';
  }
}
