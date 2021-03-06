import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'model/user.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super(props);
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}

class SignUpEvent extends AuthenticationEvent {
  final User user;

  SignUpEvent({this.user});

  @override
  String toString() {
    return 'SignUp{user: $user}';
  }
}

class LogInEvent extends AuthenticationEvent {
  final User user;

  LogInEvent({this.user});

  @override
  String toString() {
    return 'SignUp{user: $user}';
  }
}

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';
}
