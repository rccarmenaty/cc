import 'package:bloc/bloc.dart';
import 'package:cc2021/authentication/data/authenticationRepository.dart';
import 'package:cc2021/authentication/view/forms/models/confirmed_password.dart';
import 'package:cc2021/authentication/view/forms/models/email.dart';
import 'package:cc2021/authentication/view/forms/models/password.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthenticationeRepository _authenticationeRepository;

  SignupCubit(this._authenticationeRepository)
      : assert(_authenticationeRepository != null),
        super(const SignupState());

  void emailChanged(String value) {
    final email = Email.dirty(value: value);

    emit(state.copyWith(
        email: email,
        status:
            Formz.validate([email, state.password, state.confirmedPassword])));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
        password: password,
        status:
            Formz.validate([state.email, password, state.confirmedPassword])));
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword =
        ConfirmedPassword.dirty(password: state.password.value, value: value);

    emit(state.copyWith(
        confirmedPassword: confirmedPassword,
        status:
            Formz.validate([state.email, state.password, confirmedPassword])));
  }

  Future<void> signUpFormSubmit() async {
    if (!state.status.isValidated) return;

    emit(state.copyWith(status: FormzStatus.submissionSuccess));

    try {
      _authenticationeRepository.signUp(
          email: state.email.value, password: state.password.value);

      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
