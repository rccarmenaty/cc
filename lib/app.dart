import 'package:cc2021/authentication/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'authentication/data/authenticationRepository.dart';
import 'authentication/view/login.dart';
import 'authentication/view/splash.dart';
import 'home/home.dart';

class App extends StatelessWidget {
  final AuthenticationRepository authenticationeRepository;

  const App({Key key, @required this.authenticationeRepository})
      : assert(authenticationeRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: authenticationeRepository,
        child: BlocProvider(
          create: (_) => AuthenticationBloc(
              authenticationeRepository: authenticationeRepository),
          child: AppView(),
        ));
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: _navigatorKey,
        onGenerateRoute: (_) => Splash.route(),
        builder: (context, child) {
          return BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                switch (state.status) {
                  case AuthenticationStatus.authenticated:
                    print('Authenticated');
                    _navigator.pushAndRemoveUntil<void>(
                        HomePage.route(), (route) => false);
                    break;
                  case AuthenticationStatus.unauthenticated:
                  print('UNAuthenticated');
                    _navigator.pushAndRemoveUntil<void>(
                        LoginPage.route(), (route) => false);
                    break;
                  default:
                  print('UNKNOWN');
                    break;
                }
              },
              child: child);
        });
  }
}
