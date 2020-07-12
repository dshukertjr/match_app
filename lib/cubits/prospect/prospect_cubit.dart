import 'package:app/models/user_public.dart';
import 'package:cubit/cubit.dart';
import 'package:equatable/equatable.dart';

part 'prospect_state.dart';

class ProspectCubit extends Cubit<ProspectState> {
  ProspectCubit() : super(ProspectInitial());

  List<UserPublic> _prospects;

  void initialize() {
    _prospects = List<UserPublic>.filled(
      20,
      const UserPublic(
        uid: 'aaa',
        name: 'Mike',
        description:
            'Love working out on the weekends. Looking for buddies into "working out" with me if you know what I mean ;)',
        distance: 12,
        imageUrls: <String>[
          'https://66.media.tumblr.com/9c6c8faae2312c070d50b295489e1e19/tumblr_pwucvbk3IT1swrlp8o1_400.jpg',
          'https://i.pinimg.com/originals/f6/c6/0b/f6c60b23077a06f05e1be37726d5b522.jpg',
          'https://i.pinimg.com/originals/0d/2f/22/0d2f22a0b331ac00275df44a92219352.jpg',
          'https://usercontent1.hubstatic.com/8628202.jpg',
          'https://eskipaper.com/images/high-resolution-backgrounds-11.jpg',
        ],
      ),
      growable: true,
    );
    emit(ProspectSuccess(_prospects));
  }

  void like(UserPublic prospect) {
    _prospects.removeAt(0);
    emit(ProspectSuccess(_prospects));
  }
}
