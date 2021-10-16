import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class UserLoginEvent {}

class LoginNameChanged extends UserLoginEvent {
  final String name;

  LoginNameChanged({required this.name});
}

class LoginJobTitleChanged extends UserLoginEvent {
  final String jobTitle;

  LoginJobTitleChanged({required this.jobTitle});
}

class LoginSubmitted extends UserLoginEvent {}