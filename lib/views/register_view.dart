import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/constants/routes.dart';

// import '../firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _email,
              decoration: InputDecoration(hintText: "Type email here"),
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(hintText: "Type Password here"),
            ),
            TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                try {
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: email, password: password);
                } on FirebaseAuthException catch (e) {
                  if (e.code == "user-not-found") {
                    log("User not found");
                  } else if (e.code == "wrong-password") {
                    log("Wrong password");
                  }
                }
              },
              child: Title(color: Colors.pink, child: Text("Register")),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(loginRoute, (route) => false);
              },
              child: Title(
                  color: Colors.amberAccent,
                  child: Text("Already registered ? Login here")),
            )
          ],
        ),
      ),
    );
  }
}
