import 'dart:async';

import 'package:app/models/user_private.dart';
import 'package:app/models/user_public.dart';
import 'package:app/repositories/auth_repository.dart';
import 'package:app/repositories/prospect_repository.dart';
import 'package:cubit/cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

part 'prospect_state.dart';

class ProspectCubit extends Cubit<ProspectState> {
  ProspectCubit({
    @required ProspectRepository prospectRepository,
    @required AuthRepository authRepository,
  })  : _prospectRepository = prospectRepository,
        _authRepository = authRepository,
        super(ProspectInitial());

  final ProspectRepository _prospectRepository;
  final AuthRepository _authRepository;

  StreamSubscription<List<UserPublic>> _prospectsSubscription;
  List<UserPublic> _prospects;

  StreamSubscription<UserPrivate> _userPrivateSubscription;
  UserPrivate _userPrivate;

  String _uid;

  Future<void> initialize() async {
    _uid = await _authRepository.getUid;

    _prospectsSubscription?.cancel();
    _prospectsSubscription = _prospectRepository
        .prospectsStream(uid: _uid)
        .listen((List<UserPublic> prospects) {
      _prospects = prospects;
      _emitProspectSuccess();
    });

    _userPrivateSubscription?.cancel();
    _userPrivateSubscription = _authRepository
        .userPrivateStream(_uid)
        .listen((UserPrivate userPrivate) {
      _userPrivate = userPrivate;
      _emitProspectSuccess();
    });
  }

  Future<void> like(UserPublic prospect) async {
    final String uid = await _authRepository.getUid;
    final UserPublic selfUserPublic = UserPublic.fromUserPrivate(_userPrivate);
    _prospectRepository.like(
      prospect: prospect,
      selfUserPublic: selfUserPublic,
      uid: uid,
    );
  }

  void unlike(UserPublic prospect) {
    _prospects.removeAt(0);
  }

  void _emitProspectSuccess() {
    if (_prospects != null && _userPrivate != null) {
      emit(ProspectSuccess(prospects: _prospects, userPrivate: _userPrivate));
    }
  }
}
