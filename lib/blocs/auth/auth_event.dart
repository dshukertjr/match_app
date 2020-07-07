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
  List<Object> get props => [
        email,
        password,
      ];
}

class AuthLoggedin extends AuthEvent {
  final String email;
  final String password;

  AuthLoggedin({
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [
        email,
        password,
      ];
}

class AuthSetProfile extends AuthEvent {
  final String name;
  final File imageFile;
  final DateTime birthDate;
  final String sexualOrientation;
  final String wantSexualOrientation;

  AuthSetProfile({
    @required this.name,
    @required this.imageFile,
    @required this.birthDate,
    @required this.sexualOrientation,
    @required this.wantSexualOrientation,
  });

  @override
  List<Object> get props => [
        name,
        imageFile,
        birthDate,
        sexualOrientation,
        wantSexualOrientation,
      ];
}

class AuthLoggedOut extends AuthEvent {
  @override
  List<Object> get props => [];
}
