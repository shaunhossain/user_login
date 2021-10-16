import 'package:user_login/bloc/form_submission_status.dart';

class UserLoginState {
  final String name;
  bool get isValidname => name.length > 3;
  bool get isNumber => name.startsWith('sh');

  final String jobTitle;
  bool get isValidjobTitle => jobTitle.length > 6;

  final FormSubmissionStatus formStatus;

  UserLoginState({
    this.name = '',
    this.jobTitle = '',
    this.formStatus = const InitialFormStatus(),
  });

  UserLoginState copyWith({
    String? name,
    String? jobTitle,
    FormSubmissionStatus? formStatus,
  }) {
    return UserLoginState(
      name: name ?? this.name,
      jobTitle: jobTitle ?? this.jobTitle,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}