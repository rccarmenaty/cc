import 'package:cc2021/authentication/data/authenticationRepository.dart';
import 'package:cc2021/authentication/view/forms/login/cubit/login_cubit.dart';
import 'package:cc2021/authentication/view/forms/login/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider(
          create: (_) => LoginCubit(context.read<AuthenticationeRepository>()),
          child: LoginForm(),
          ),
        ) 
      );
  }
}
