import 'dart:async';

import 'package:app/data_providers/auth_provider.dart';
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
      : _authRepository = authRepository;

  @override
  AuthState get initialState => AuthInitial();

  FirebaseUser user;

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthStarted) {
      yield* _mapAuthStartedToState();
    } else if (event is AuthUpdated) {
      yield* _mapAuthUpdatedToState();
    }
  }

  Stream<AuthState> _mapAuthStartedToState() async* {
    user = await _authRepository.currentUser;
    if (user == null) {
      yield AuthNoUser();
    } else {
      yield AuthNoProfile();
    }
  }

  Stream<AuthState> _mapAuthUpdatedToState() async* {}
}
