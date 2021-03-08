import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cc2021/authentication/data/authenticationRepository.dart';
import 'package:cc2021/authentication/data/user.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:pedantic/pedantic.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationeRepository _authenticationeRepository;
  StreamSubscription<User> _userSuscription;

  AuthenticationBloc(
      {@required AuthenticationeRepository authenticationeRepository})
      : assert(authenticationeRepository != null),
        _authenticationeRepository = authenticationeRepository,
        super(const AuthenticationState.unknown()) {
    _userSuscription = _authenticationeRepository.user
        .listen((user) => add(AuthenticationUserChanged(user)));
  }

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationUserChanged) {
      if (event.user != User.empty)
        yield AuthenticationState.authenticated(event.user);
      else
        yield AuthenticationState.unauthenticated();
    } else if (event is AuthenticationLogoutRequested) {
      unawaited(_authenticationeRepository.logout());
    }
  }

  @override
  Future<void> close() {
    _userSuscription?.cancel();
    return super.close();
  }
}
