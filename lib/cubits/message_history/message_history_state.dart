part of 'message_history_cubit.dart';

abstract class MessageHistoryState extends Equatable {
  const MessageHistoryState();
}

class MessageHistoryInitial extends MessageHistoryState {
  @override
  List<Object> get props => <Object>[];
}

class MessageHistorySuccess extends MessageHistoryState {
  const MessageHistorySuccess(this.messageHistory);

  final List<MatchPair> messageHistory;

  @override
  List<Object> get props => <Object>[messageHistory];
}
