import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String email;
  final String password;

  User({this.email, this.password});

  @override
  String toString() {
    return 'User{email: $email, password: $password}';
  }
}
