import 'package:bloc/bloc.dart';
import 'package:myapp/services/auth/auth_provider.dart';
import 'package:myapp/services/auth/bloc/auth_event.dart';
import 'package:myapp/services/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider) : super(const AuthStateLoading()) {
    // on initialize
    on<AuthEventInitialize>((event, emit) async {
      await provider.initialize();
      final user = provider.currentUser;
      if (user == null) {
        emit(const AuthStateLoggedOut());
      } else if (!user.isEmailVerified) {
        emit(AuthStateNeedsVerification());
      } else {
        emit(AuthStateLoggedin(user));
      }
    });

    // login
    on<AuthEventLogIn>((event, emit) async {
      emit(AuthStateLoading());
      final email = event.email;
      final password = event.password;
      try {
        final user = await provider.logIn(email: email, password: password);
        emit(AuthStateLoggedin(user));
      } on Exception catch (e) {
        emit(AuthStateLoginFailure(e));
      }
    });

    // logout
    on<AuthEventLogOut>((event, emit) async {
      try {
        emit(AuthStateLoading());
        await provider.logOut();
        emit(AuthStateLoggedOut());
      } on Exception catch (e) {
        emit(AuthStateLogOutFailure(e));
      }
    });
  }
}
