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
  final AuthRepository _authRepository;
  AuthCubit({
    @required AuthRepository authRepository,
    AuthState initialState,
  })  : _authRepository = authRepository,
        super(initialState ?? AuthLoading());

  String _uid;
  StreamSubscription<UserPrivate> _userPrivateSubscription;
  UserPrivate _userPrivate;

  @override
  Future<void> close() {
    _userPrivateSubscription?.cancel();
    return super.close();
  }

  void initialize() async {
    _uid = await _authRepository.getUid;
    if (_uid == null) {
      emit(AuthNoUser());
    } else {
      _userPrivateSubscription?.cancel();
      _userPrivateSubscription =
          _authRepository.userPrivateStream(_uid).listen((userPrivate) {
        _userPrivate = userPrivate;
        if (_userPrivate == null) {
          emit(AuthNoProfile(uid: _uid));
        } else {
          emit(AuthSuccess(uid: _uid, userPrivate: _userPrivate));
        }
      });
    }
  }

  void register({
    @required String email,
    @required String password,
  }) async {
    emit(AuthLoading());
    try {
      _userPrivateSubscription?.cancel();
      _userPrivateSubscription =
          _authRepository.userPrivateStream(_uid).listen((userPrivate) {
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
          emit(AuthNoUser(errorMessage: 'パスワードをより複雑なものにしてください'));
          break;
        case 'ERROR_INVALID_EMAIL':
          emit(AuthNoUser(errorMessage: '不正なメールアドレスです'));
          break;
        case 'ERROR_EMAIL_ALREADY_IN_USE':
          emit(AuthNoUser(errorMessage: 'このメールアドレスは既に使われています'));
          break;
        default:
          emit(AuthNoUser(errorMessage: '不明なエラーが発生しました'));
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(AuthNoUser(errorMessage: '不明なエラーが発生しました'));
    }
  }

  void login({
    @required String email,
    @required String password,
  }) async {
    emit(AuthLoading());
    try {
      _userPrivateSubscription?.cancel();
      _userPrivateSubscription =
          _authRepository.userPrivateStream(_uid).listen((userPrivate) {
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
          emit(AuthNoUser(errorMessage: '不正なメールアドレスです'));
          break;
        case 'ERROR_WRONG_PASSWORD':
          emit(AuthNoUser(errorMessage: 'パスワードが間違っています'));
          break;
        case 'ERROR_USER_NOT_FOUND':
          emit(AuthNoUser(errorMessage: 'ユーザーが見つかりませんでした'));
          break;
        case 'ERROR_USER_DISABLED':
          emit(AuthNoUser(errorMessage: 'このユーザーはアカウントを停止されています'));
          break;
        case 'ERROR_TOO_MANY_REQUESTS':
          emit(AuthNoUser(errorMessage: '時間を置いてからお試しください'));
          break;
        case 'ERROR_OPERATION_NOT_ALLOWED':
          emit(AuthNoUser(errorMessage: 'メールアドレスとパスワードのログインが許可されていません'));
          break;
        default:
          emit(AuthNoUser(errorMessage: '不明なエラーが発生しました'));
      }
      debugPrint(e.code);
    } catch (e) {
      emit(AuthNoUser(errorMessage: '不明なエラーが発生しました'));
      debugPrint(e);
    }
  }

  Future<void> saveProfile({
    @required String name,
    @required File imageFile,
    @required DateTime birthDate,
    @required String sexualOrientation,
    @required String wantSexualOrientation,
  }) async {
    emit(AuthLoading());
    await _authRepository.saveProfile(
      name: name,
      imageFile: imageFile,
      birthDate: birthDate,
      sexualOrientation: sexualOrientation,
      wantSexualOrientation: wantSexualOrientation,
    );
  }

  void logout() async {
    emit(AuthLoading());
    await _authRepository.signOut();
    _userPrivateSubscription?.cancel();
    emit(AuthNoUser());
  }
}
