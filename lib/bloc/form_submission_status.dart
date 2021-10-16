
import 'package:user_login/data/model/user_model.dart';

abstract class FormSubmissionStatus {
  const FormSubmissionStatus();
}

class InitialFormStatus extends FormSubmissionStatus {
  const InitialFormStatus();
}

class FormSubmitting extends FormSubmissionStatus {}

class SubmissionSuccess extends FormSubmissionStatus {
  final UserModel userModel;

  SubmissionSuccess(this.userModel);
}

class SubmissionFailed extends FormSubmissionStatus {
  final dynamic exception;

  SubmissionFailed(this.exception);
}