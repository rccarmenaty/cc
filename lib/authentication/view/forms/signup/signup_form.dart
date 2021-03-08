import 'package:cc2021/authentication/view/forms/signup/cubit/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class SignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignupState>(
      listener: (context, state) {
      if (state.status == FormzStatus.submissionFailure) {
        Scaffold.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(content: Text('Sign Up Failure'))
          );
      }
    },
    child: Align(
      alignment: const Alignment(0, -1/3),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [],),
    )
    
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      
    );
  }
}
