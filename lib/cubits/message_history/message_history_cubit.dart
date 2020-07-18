import 'dart:async';

import 'package:app/models/match_pair.dart';
import 'package:app/repositories/auth_repository.dart';
import 'package:app/repositories/message_repository.dart';
import 'package:cubit/cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'message_history_state.dart';

class MessageHistoryCubit extends Cubit<MessageHistoryState> {
  MessageHistoryCubit({
    @required MessageRepository messageRepository,
    @required AuthRepository authRepository,
  })  : _messageRepository = messageRepository,
        _authRepository = authRepository,
        super(MessageHistoryInitial());

  final AuthRepository _authRepository;
  final MessageRepository _messageRepository;

  StreamSubscription<List<MatchPair>> _messagePairSubscription;
  List<MatchPair> _messageHistories;

  String _uid;

  Future<void> initialize() async {
    _uid = await _authRepository.getUid;
    _messagePairSubscription?.cancel();
    _messagePairSubscription = _messageRepository
        .messageHistoryStream(_uid)
        .listen((List<MatchPair> messageHistory) {
      _messageHistories = messageHistory;
      if (_messageHistories.isEmpty) {
        emit(MessageHistoryEmpty());
      } else {
        emit(MessageHistorySuccess(
            messageHistories: _messageHistories, uid: _uid));
      }
    });
  }
}
