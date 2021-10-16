import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_login/bloc/form_submission_status.dart';
import 'package:user_login/bloc/user_login_bloc.dart';
import 'package:user_login/bloc/user_login_event.dart';
import 'package:user_login/bloc/user_login_state.dart';
import 'package:user_login/data/model/user_model.dart';

class LoginPageView extends StatefulWidget {
  const LoginPageView({Key? key}) : super(key: key);

  @override
  _LoginPageViewState createState() => _LoginPageViewState();
}

class _LoginPageViewState extends State<LoginPageView> {
  late UserModel _user;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController jobController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<UserLoginBloc, UserLoginState>(
            builder: (BuildContext context, UserLoginState state) {
              return Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _usernameField(),
                      _passwordField(),
                    ],
                  ),
                ),
              );
            }),
        floatingActionButton: _loginButton());
  }

  Widget _usernameField() {
    return BlocBuilder<UserLoginBloc, UserLoginState>(builder: (context, state) {
      return TextFormField(
        decoration: const InputDecoration(
          icon: Icon(Icons.person),
          hintText: 'Name',
        ),
        validator: (value) => state.isValidname ? null : 'Name is too short',
        onChanged: (value) => context.read<UserLoginBloc>().add(
          LoginNameChanged(name: value),
        ),
      );
    });
  }

  Widget _passwordField() {
    return BlocBuilder<UserLoginBloc, UserLoginState>(builder: (context, state) {
      return TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.security),
          hintText: 'Password',
        ),
        validator: (value) =>
        state.isValidjobTitle ? null : 'Password is too short',
        onChanged: (value) => context.read<UserLoginBloc>().add(
          LoginJobTitleChanged(jobTitle: value),
        ),
      );
    });
  }

  Widget _loginButton() {
    return BlocBuilder<UserLoginBloc, UserLoginState>(builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? CircularProgressIndicator()
          : FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            context.read<UserLoginBloc>().add(LoginSubmitted());
          }
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      );
    });
  }
}
