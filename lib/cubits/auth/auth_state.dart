part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState({this.errorMessage});

  final String errorMessage;
}

class AuthLoading extends AuthState {
  const AuthLoading({
    String errorMessage,
  }) : super(errorMessage: errorMessage);

  @override
  List<Object> get props => <Object>[errorMessage];
}

/// FirebaseUser does not exist
class AuthNoUser extends AuthState {
  const AuthNoUser({
    String errorMessage,
  }) : super(errorMessage: errorMessage);

  @override
  List<Object> get props => <Object>[
        errorMessage,
      ];
}

/// FirebaseUser exists, but profile has not been entered yet
class AuthNoProfile extends AuthState {
  const AuthNoProfile({
    @required this.uid,
    String errorMessage,
  }) : super(errorMessage: errorMessage);

  final String uid;

  @override
  List<Object> get props => <Object>[
        uid,
        errorMessage,
      ];
}

/// FirebaseUser and profile both exits
class AuthSuccess extends AuthState {
  const AuthSuccess({
    @required this.uid,
    @required this.userPrivate,
    String errorMessage,
  }) : super(errorMessage: errorMessage);

  final String uid;
  final UserPrivate userPrivate;

  @override
  List<Object> get props => <Object>[
        uid,
        userPrivate,
        errorMessage,
      ];
}
