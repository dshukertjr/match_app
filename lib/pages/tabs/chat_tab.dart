import 'package:app/cubits/message_history/message_history_cubit.dart';
import 'package:app/repositories/auth_repository.dart';
import 'package:app/repositories/message_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

class ChatTab extends StatelessWidget {
  static const String name = 'ChatTab';
  static Widget create() {
    return CubitProvider<MessageHistoryCubit>(
      create: (BuildContext context) => MessageHistoryCubit(
        authRepository: RepositoryProvider.of<AuthRepository>(context),
        messageRepository: RepositoryProvider.of<MessageRepository>(context),
      )..initialize(),
      child: ChatTab(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CubitBuilder<MessageHistoryCubit, MessageHistoryState>(
        builder: (BuildContext context, MessageHistoryState state) {
      return Container();
    });
  }
}
