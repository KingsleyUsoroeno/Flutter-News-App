import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_news_app/data/service/authentication_service.dart';
import 'package:meta/meta.dart';

import 'auth_event.dart';
import 'auth_state.dart';
import 'model/user.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationService _authenticationService;

  AuthenticationBloc({@required AuthenticationService authenticationService})
      : assert(authenticationService != null),
        _authenticationService = authenticationService;

  @override
  AuthenticationState get initialState => Initial();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is SignUpEvent) {
      yield* _mapSignInEventToState(event.user);
    } else if (event is LogInEvent) {
      yield* _mapLoggedInToState(event.user);
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = await _authenticationService.isSignedIn();
      if (isSignedIn) {
        final name = await _authenticationService.getUser();
        yield Authenticated(name);
      } else {
        yield Unauthenticated();
        yield Initial();
      }
    } catch (_) {
      yield Unauthenticated();
      yield Initial();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState(User user) async* {
    yield Loading();
    try {
      final currentUser = await _authenticationService.loginWithEmail(email: user.email, password: user.password);
      if (currentUser != null) {
        yield Authenticated(currentUser.user.email);
      } else {
        yield Unauthenticated();
        yield Initial();
      }
    } catch (e) {
      yield Unauthenticated(authenticationError: e.toString());
      yield Initial();
    }
  }

  Stream<AuthenticationState> _mapSignInEventToState(User user) async* {
    yield Loading();
    try {
      print("user data is $user");
      final currentUser = await _authenticationService.signUpWithEmail(email: user.email, password: user.password);
      if (currentUser != null) {
        yield Authenticated(currentUser.user.email);
      } else {
        yield Unauthenticated();
        yield Initial();
      }
    } catch (e) {
      yield Unauthenticated(authenticationError: e.toString());
      yield Initial();
    }
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
    _authenticationService.signOut();
  }
}
