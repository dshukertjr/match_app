part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

/// FirebaseUser does not exist
class AuthNoUser extends AuthState {
  @override
  List<Object> get props => [];
}

/// FirebaseUser exists, but profile has not been entered yet
class AuthNoProfile extends AuthState {
  @override
  List<Object> get props => [];
}

/// FirebaseUser and profile both exits
class AuthSuccess extends AuthState {
  @override
  List<Object> get props => [];
}
