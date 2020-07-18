import 'package:app/cubits/message_history/message_history_cubit.dart';
import 'package:app/models/match_pair.dart';
import 'package:app/models/user_public.dart';
import 'package:app/repositories/auth_repository.dart';
import 'package:app/repositories/message_repository.dart';
import 'package:app/utilities/time_since.dart';
import 'package:app/widgets/custom_loader.dart';
import 'package:app/widgets/profile_image.dart';
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
        if (state is MessageHistorySuccess) {
          final List<MatchPair> messageHistories = state.messageHistories;
          final String uid = state.uid;
          return ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              final MatchPair messageHistory = messageHistories[index];
              final UserPublic opponent = messageHistory.opponent(uid);
              return Ink(
                color: Colors.white,
                child: ListTile(
                  onTap: () {},
                  leading: ProfileImage(
                    opponent,
                    size: 50,
                  ),
                  title: Text(opponent.name),
                  subtitle: Row(
                    children: <Widget>[
                      if (messageHistory.lastMessage.isSentByYou(uid))
                        Icon(Icons.replay),
                      Text(
                        messageHistory.lastMessage.getMessageLabel,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  trailing: Text(
                    TimeSince.label(messageHistory.lastMessage.createdAt),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
            itemCount: messageHistories.length,
          );
        } else if (state is MessageHistoryEmpty) {
          return const Center(
            child: Text('まだマッチがありません'),
          );
        } else {
          return Center(
            child: CustomLoader(),
          );
        }
      },
    );
  }
}
