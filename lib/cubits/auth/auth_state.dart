part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  final String errorMessage;
  AuthState({this.errorMessage});
}

class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}

/// FirebaseUser does not exist
class AuthNoUser extends AuthState {
  AuthNoUser({String errorMessage}) : super(errorMessage: errorMessage);

  @override
  List<Object> get props => [];
}

/// FirebaseUser exists, but profile has not been entered yet
class AuthNoProfile extends AuthState {
  final String uid;
  AuthNoProfile({
    @required this.uid,
    String errorMessage,
  }) : super(errorMessage: errorMessage);

  @override
  List<Object> get props => [];
}

/// FirebaseUser and profile both exits
class AuthSuccess extends AuthState {
  final String uid;
  final UserPrivate userPrivate;
  AuthSuccess({
    @required this.uid,
    @required this.userPrivate,
    errorMessage,
  }) : super(errorMessage: errorMessage);

  @override
  List<Object> get props => [];
}
