import 'dart:async';

import 'package:app/repositories/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({
    @required AuthRepository authRepository,
    @visibleForTesting AuthState initialState,
  })  : _authRepository = authRepository,
        super(initialState ?? AuthLoading());

  String uid;

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthStarted) {
      yield* _mapAuthStartedToState();
    } else if (event is AuthUpdated) {
      yield* _mapAuthUpdatedToState();
    } else if (event is AuthRegistered) {
      yield* _mapAuthRegisteredToState(
        email: event.email,
        password: event.password,
      );
    } else if (event is AuthLoggedin) {
      yield* _mapAuthLoggedinToState(
        email: event.email,
        password: event.password,
      );
    } else if (event is AuthLoggedOut) {
      yield* _mapAuthLoggedOutToState();
    }
  }

  Stream<AuthState> _mapAuthStartedToState() async* {
    uid = await _authRepository.getUid;
    if (uid == null) {
      yield AuthNoUser();
    } else {
      yield AuthNoProfile();
    }
  }

  Stream<AuthState> _mapAuthUpdatedToState() async* {}

  Stream<AuthState> _mapAuthRegisteredToState({
    @required String email,
    @required String password,
  }) async* {
    yield AuthLoading();
    try {
      await _authRepository.register(email: email, password: password);
      // TODO change destination depending on status
      yield AuthNoProfile();
    } on PlatformException catch (e) {
      switch (e.code) {
        case 'ERROR_WEAK_PASSWORD':
          yield AuthNoUser(errorMessage: 'パスワードをより複雑なものにしてください');
          break;
        case 'ERROR_INVALID_EMAIL':
          yield AuthNoUser(errorMessage: '不正なメールアドレスです');
          break;
        case 'ERROR_EMAIL_ALREADY_IN_USE':
          yield AuthNoUser(errorMessage: 'このメールアドレスは既に使われています');
          break;
        default:
          yield AuthNoUser(errorMessage: '不明なエラーが発生しました');
      }
    } catch (e) {
      debugPrint(e);
      yield AuthNoUser(errorMessage: '不明なエラーが発生しました');
    }
  }

  Stream<AuthState> _mapAuthLoggedinToState({
    @required String email,
    @required String password,
  }) async* {
    yield AuthLoading();
    try {
      await _authRepository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // TODO change destination depending on status
      yield AuthNoProfile();
    } on PlatformException catch (e) {
      switch (e.code) {
        case 'ERROR_INVALID_EMAIL':
          yield AuthNoUser(errorMessage: '不正なメールアドレスです');
          break;
        case 'ERROR_WRONG_PASSWORD':
          yield AuthNoUser(errorMessage: 'パスワードが間違っています');
          break;
        case 'ERROR_USER_NOT_FOUND':
          yield AuthNoUser(errorMessage: 'ユーザーが見つかりませんでした');
          break;
        case 'ERROR_USER_DISABLED':
          yield AuthNoUser(errorMessage: 'このユーザーはアカウントを停止されています');
          break;
        case 'ERROR_TOO_MANY_REQUESTS':
          yield AuthNoUser(errorMessage: '時間を置いてからお試しください');
          break;
        case 'ERROR_OPERATION_NOT_ALLOWED':
          yield AuthNoUser(errorMessage: 'メールアドレスとパスワードのログインが許可されていません');
          break;
        default:
          AuthNoUser(errorMessage: '不明なエラーが発生しました');
      }
      debugPrint(e.code);
    } catch (e) {
      yield AuthNoUser(errorMessage: '不明なエラーが発生しました');
      debugPrint(e);
    }
  }

  Stream<AuthState> _mapAuthLoggedOutToState() async* {
    await _authRepository.signOut();
    yield AuthNoUser();
  }
}
