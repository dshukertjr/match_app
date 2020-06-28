part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AuthStarted extends AuthEvent {
  @override
  List<Object> get props => [];
}

class AuthUpdated extends AuthEvent {
  final FirebaseUser user;

  AuthUpdated({@required this.user});

  @override
  List<Object> get props => [user];
}

class AuthRegistered extends AuthEvent {
  final String email;
  final String password;

  AuthRegistered({
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [];
}
