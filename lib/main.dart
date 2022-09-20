import 'package:flutter/material.dart';
import 'package:myapp/constants/routes.dart';
import 'package:myapp/services/auth/auth_service.dart';
import 'package:myapp/views/login_view.dart';
import 'package:myapp/views/notes/new_notes_view.dart';
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
    home: const HomePage(),
    routes: {
      loginRoute: (context) => LoginView(),
      registerRoute: (context) => RegisterView(),
      notesRoute: (context) => NotesView(),
      verifyEmailRoute: (context) => VerifyEmailView(),
      newNoteRoute: (context) => NewNoteView()
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            // print(snapshot.connectionState);
            // print(user);
            if (user != null) {
              if (user.isEmailVerified) {
                return NotesView();
              } else {
                return VerifyEmailView();
              }
            } else {
              return LoginView();
            }
          default:
            return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
