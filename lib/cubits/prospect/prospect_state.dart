part of 'prospect_cubit.dart';

abstract class ProspectState extends Equatable {
  const ProspectState();
}

class ProspectInitial extends ProspectState {
  @override
  List<Object> get props => <Object>[];
}

class ProspectSuccess extends ProspectState {
  const ProspectSuccess(this.prospects);

  final List<UserPublic> prospects;

  @override
  List<Object> get props => <Object>[prospects];
}

class ProspectEmpty extends ProspectState {
  @override
  List<Object> get props => <Object>[];
}
