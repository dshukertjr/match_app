part of 'message_history_cubit.dart';

abstract class MessageHistoryState extends Equatable {
  const MessageHistoryState();
}

class MessageHistoryInitial extends MessageHistoryState {
  @override
  List<Object> get props => <Object>[];
}

class MessageHistorySuccess extends MessageHistoryState {
  const MessageHistorySuccess({
    @required this.messageHistories,
    @required this.uid,
  });

  final List<MatchPair> messageHistories;
  final String uid;

  @override
  List<Object> get props => <Object>[
        messageHistories,
        uid,
      ];
}

class MessageHistoryEmpty extends MessageHistoryState {
  @override
  List<Object> get props => <Object>[];
}
