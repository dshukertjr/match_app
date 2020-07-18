part of 'prospect_cubit.dart';

abstract class ProspectState extends Equatable {
  const ProspectState();
}

class ProspectInitial extends ProspectState {
  @override
  List<Object> get props => <Object>[];
}

class ProspectSuccess extends ProspectState {
  const ProspectSuccess({
    @required this.prospects,
    @required this.userPrivate,
  });

  final List<UserPublic> prospects;
  final UserPrivate userPrivate;

  @override
  List<Object> get props => <Object>[
        prospects,
        userPrivate,
      ];
}

class ProspectEmpty extends ProspectState {
  @override
  List<Object> get props => <Object>[];
}
