import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:user_login/bloc/form_submission_status.dart';
import 'package:user_login/bloc/user_login_event.dart';
import 'package:user_login/bloc/user_login_state.dart';
import 'package:user_login/data/model/user_model.dart';
import 'package:user_login/data/repository/repository.dart';

class UserLoginBloc extends Bloc<UserLoginEvent, UserLoginState>{

  UserLoginBloc({required this.repository}) : super(UserLoginState());

  final Repository repository;

  @override
  Stream<UserLoginState> mapEventToState(UserLoginEvent event) async* {
    if (event is LoginNameChanged) {
      yield state.copyWith(name: event.name);

      // Password updated
    } else if (event is LoginJobTitleChanged) {
      yield state.copyWith(jobTitle: event.jobTitle);

      // Form submitted
    } else if (event is LoginSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        UserModel userModel = await repository.sendRequestToServer(state.name, state.jobTitle);
        yield state.copyWith(formStatus: SubmissionSuccess(userModel));
      }on SocketException {
        yield state.copyWith(formStatus: SubmissionFailed('No Internet'));
      } on HttpException {
        yield state.copyWith(formStatus: SubmissionFailed('No Service Found'));
      } on FormatException {
        yield state.copyWith(formStatus: SubmissionFailed('Invalid Response format'));
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e));
      }
    }
  }
}