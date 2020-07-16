import 'dart:async';

import 'package:app/models/user_public.dart';
import 'package:app/repositories/auth_repository.dart';
import 'package:app/repositories/prospect_repository.dart';
import 'package:cubit/cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

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

  String _uid;

  Future<void> initialize() async {
    _uid = await _authRepository.getUid;
    _prospectsSubscription?.cancel();
    _prospectsSubscription = _prospectRepository
        .prospectsStream(uid: _uid)
        .listen((List<UserPublic> prospects) {
      _prospects = prospects;
      emit(ProspectSuccess(_prospects));
    });
  }

  void like(UserPublic prospect) {
    _prospects.removeAt(0);
  }

  void unlike(UserPublic prospect) {
    _prospects.removeAt(0);
  }
}
