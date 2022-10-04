import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/constants/routes.dart';
import 'package:myapp/services/auth/bloc/auth_bloc.dart';
import 'package:myapp/services/auth/bloc/auth_event.dart';
import 'package:myapp/services/auth/bloc/auth_state.dart';
import 'package:myapp/services/auth/firebase_auth_provider.dart';
import 'package:myapp/views/login_view.dart';
import 'package:myapp/views/notes/create_update_note_view.dart';
import 'package:myapp/views/register_view.dart';
import 'package:myapp/views/verify_email_view.dart';

import 'views/notes/notes_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'My Notes',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(FirebaseAuthProvider()),
      child: HomePage(),
    ),
    routes: {
      loginRoute: (context) => LoginView(),
      registerRoute: (context) => RegisterView(),
      notesRoute: (context) => NotesView(),
      verifyEmailRoute: (context) => VerifyEmailView(),
      createOrUpdateNoteRoute: (context) => CreateUpdateNoteView()
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(AuthEventInitialize());

    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is AuthStateLoggedin) {
        return NotesView();
      } else if (state is AuthStateNeedsVerification) {
        return VerifyEmailView();
      } else if (state is AuthStateLoggedOut) {
        return LoginView();
      } else {
        return Scaffold(body: CircularProgressIndicator());
      }
    });
  }
}