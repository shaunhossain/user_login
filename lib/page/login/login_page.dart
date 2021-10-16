import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_login/bloc/form_submission_status.dart';
import 'package:user_login/bloc/user_login_bloc.dart';
import 'package:user_login/bloc/user_login_state.dart';
import 'package:user_login/data/repository/repository.dart';
import 'package:user_login/page/login/view/login_page_view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            UserLoginBloc(repository: Repository()),
        child: Scaffold(
          appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: const Text("test"),
          ),
          body: userLoginView(),

        ));
  }
  Widget userLoginView(){
    return BlocListener<UserLoginBloc, UserLoginState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionSuccess) {
          _showSnackBar(context, formStatus.userModel.createdAt.toString());
        }
      },child: const LoginPageView() ,);

  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
