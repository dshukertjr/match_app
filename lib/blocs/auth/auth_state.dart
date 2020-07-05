part of 'auth_bloc.dart';

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
  AuthNoProfile({String errorMessage}) : super(errorMessage: errorMessage);

  @override
  List<Object> get props => [];
}

/// FirebaseUser and profile both exits
class AuthSuccess extends AuthState {
  AuthSuccess({String errorMessage}) : super(errorMessage: errorMessage);

  @override
  List<Object> get props => [];
}
