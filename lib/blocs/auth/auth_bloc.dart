import 'dart:async';

import 'package:app/repositories/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({@required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthInitial());

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
    await _authRepository.register(email: email, password: password);
    // TODO change destination depending on status
    yield AuthNoProfile();
  }

  Stream<AuthState> _mapAuthLoggedinToState({
    @required String email,
    @required String password,
  }) async* {
    await _authRepository.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    // TODO change destination depending on status
    yield AuthNoProfile();
  }
}
