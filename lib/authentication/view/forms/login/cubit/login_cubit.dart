import 'package:bloc/bloc.dart';
import 'package:cc2021/authentication/data/authenticationRepository.dart';
import 'package:cc2021/authentication/view/forms/models/email.dart';
import 'package:cc2021/authentication/view/forms/models/password.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticationRepository _authenticationeRepository;

  LoginCubit(this._authenticationeRepository)
      : assert(_authenticationeRepository != null),
        super(const LoginState());

  void emailChanged(String value) {
    final email = Email.dirty(value: value);
    emit(state.copyWith(
        email: email, status: Formz.validate([email, state.password])));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
        password: password, status: Formz.validate([password, state.email])));
  }

  Future<void> logInWithCredentials() async {
    if (!state.status.isValidated) return;

    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    try {
      await _authenticationeRepository.loginWithEmailAndPassword(
          email: state.email.value, password: state.password.value);

      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  
}
