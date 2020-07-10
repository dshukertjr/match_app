import 'dart:async';
import 'dart:io';

import 'package:app/models/profile.dart';
import 'package:app/repositories/auth_repository.dart';
import 'package:cubit/cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    @required AuthRepository authRepository,
    AuthState initialState,
  })  : _authRepository = authRepository,
        super(initialState ?? const AuthLoading());

  final AuthRepository _authRepository;

  String _uid;
  StreamSubscription<UserPrivate> _userPrivateSubscription;
  UserPrivate _userPrivate;

  @override
  Future<void> close() {
    _userPrivateSubscription?.cancel();
    return super.close();
  }

  Future<void> initialize() async {
    _uid = await _authRepository.getUid;
    if (_uid == null) {
      emit(const AuthNoUser());
    } else {
      _userPrivateSubscription?.cancel();
      _userPrivateSubscription = _authRepository
          .userPrivateStream(_uid)
          .listen((UserPrivate userPrivate) {
        _userPrivate = userPrivate;
        if (_userPrivate == null) {
          emit(AuthNoProfile(uid: _uid));
        } else {
          emit(AuthSuccess(uid: _uid, userPrivate: _userPrivate));
        }
      });
    }
  }

  Future<void> register({
    @required String email,
    @required String password,
  }) async {
    emit(const AuthLoading());
    try {
      _userPrivateSubscription?.cancel();
      _userPrivateSubscription = _authRepository
          .userPrivateStream(_uid)
          ?.listen((UserPrivate userPrivate) {
        _userPrivate = userPrivate;
        if (_userPrivate == null) {
          emit(AuthNoProfile(uid: _uid));
        } else {
          emit(AuthSuccess(uid: _uid, userPrivate: _userPrivate));
        }
      });
      _uid = await _authRepository.register(email: email, password: password);
      emit(AuthNoProfile(uid: _uid));
    } on PlatformException catch (e) {
      switch (e.code) {
        case 'ERROR_WEAK_PASSWORD':
          emit(const AuthNoUser(errorMessage: 'パスワードをより複雑なものにしてください'));
          break;
        case 'ERROR_INVALID_EMAIL':
          emit(const AuthNoUser(errorMessage: '不正なメールアドレスです'));
          break;
        case 'ERROR_EMAIL_ALREADY_IN_USE':
          emit(const AuthNoUser(errorMessage: 'このメールアドレスは既に使われています'));
          break;
        default:
          emit(const AuthNoUser(errorMessage: '不明なエラーが発生しました'));
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(const AuthNoUser(errorMessage: '不明なエラーが発生しました'));
    }
  }

  Future<void> login({
    @required String email,
    @required String password,
  }) async {
    emit(const AuthLoading());
    try {
      _userPrivateSubscription?.cancel();
      _userPrivateSubscription = _authRepository
          .userPrivateStream(_uid)
          .listen((UserPrivate userPrivate) {
        _userPrivate = userPrivate;
        if (_userPrivate == null) {
          emit(AuthNoProfile(uid: _uid));
        } else {
          emit(AuthSuccess(uid: _uid, userPrivate: _userPrivate));
        }
      });
      _uid = await _authRepository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on PlatformException catch (e) {
      switch (e.code) {
        case 'ERROR_INVALID_EMAIL':
          emit(const AuthNoUser(errorMessage: '不正なメールアドレスです'));
          break;
        case 'ERROR_WRONG_PASSWORD':
          emit(const AuthNoUser(errorMessage: 'パスワードが間違っています'));
          break;
        case 'ERROR_USER_NOT_FOUND':
          emit(const AuthNoUser(errorMessage: 'ユーザーが見つかりませんでした'));
          break;
        case 'ERROR_USER_DISABLED':
          emit(const AuthNoUser(errorMessage: 'このユーザーはアカウントを停止されています'));
          break;
        case 'ERROR_TOO_MANY_REQUESTS':
          emit(const AuthNoUser(errorMessage: '時間を置いてからお試しください'));
          break;
        case 'ERROR_OPERATION_NOT_ALLOWED':
          emit(const AuthNoUser(errorMessage: 'メールアドレスとパスワードのログインが許可されていません'));
          break;
        default:
          emit(const AuthNoUser(errorMessage: '不明なエラーが発生しました'));
      }
      debugPrint(e.code);
    } catch (e) {
      emit(const AuthNoUser(errorMessage: '不明なエラーが発生しました'));
      debugPrint(e.toString());
    }
  }

  Future<void> saveProfile({
    @required String name,
    @required File imageFile,
    @required DateTime birthDate,
    @required String sexualOrientation,
    @required String wantSexualOrientation,
  }) async {
    emit(const AuthLoading());
    await _authRepository.saveProfile(
      name: name,
      imageFile: imageFile,
      birthDate: birthDate,
      sexualOrientation: sexualOrientation,
      wantSexualOrientation: wantSexualOrientation,
    );
  }

  Future<void> logout() async {
    emit(const AuthLoading());
    await _authRepository.signOut();
    _userPrivateSubscription?.cancel();
    emit(const AuthNoUser());
  }
}
