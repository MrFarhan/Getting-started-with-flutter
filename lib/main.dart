import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/constants/routes.dart';
import 'package:myapp/services/auth/auth_service.dart';
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
    home: const HomePage(),
    routes: {
      loginRoute: (context) => LoginView(),
      registerRoute: (context) => RegisterView(),
      notesRoute: (context) => NotesView(),
      verifyEmailRoute: (context) => VerifyEmailView(),
      createOrUpdateNoteRoute: (context) => CreateUpdateNoteView()
    },
  ));
}

// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: AuthService.firebase().initialize(),
//       builder: (context, snapshot) {
//         switch (snapshot.connectionState) {
//           case ConnectionState.done:
//             final user = AuthService.firebase().currentUser;
//             // print(snapshot.connectionState);
//             // print(user);
//             if (user != null) {
//               if (user.isEmailVerified) {
//                 return NotesView();
//               } else {
//                 return VerifyEmailView();
//               }
//             } else {
//               return LoginView();
//             }
//           default:
//             return Center(child: CircularProgressIndicator());
//         }
//       },
//     );
//   }
// }

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Testing Bloc'),
        ),
        body:
            BlocConsumer<CounterBloc, CounterState>(builder: (context, state) {
          final invalidValue =
              state is CounterStateInvalidNumber ? state.invalidValue : '';
          return Column(
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(hintText: 'Enter a number here'),
                keyboardType: TextInputType.number,
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        context
                            .read<CounterBloc>()
                            .add(IncreamentEvent(_controller.text));
                      },
                      child: Text('+')),
                  TextButton(
                      onPressed: () {
                        context
                            .read<CounterBloc>()
                            .add(DecreamentEvent(_controller.text));
                      },
                      child: Text('-'))
                ],
              ),
              Text(
                'Current value is ${state.value}',
              ),
              Visibility(
                child: Text('Invalid input: $invalidValue'),
                visible: state is CounterStateInvalidNumber,
              ),
            ],
          );
        }, listener: (context, state) {
          _controller.clear();
        }),
      ),
    );
  }
}

@immutable
abstract class CounterState {
  final int value;

  const CounterState(this.value);
}

class CounterStateValid extends CounterState {
  const CounterStateValid(int value) : super(value);
}

class CounterStateInvalidNumber extends CounterState {
  final String invalidValue;
  const CounterStateInvalidNumber({
    required this.invalidValue,
    required int previousValue,
  }) : super(previousValue);
}

@immutable
abstract class CounterEvent {
  final String value;
  const CounterEvent(this.value);
}

class IncreamentEvent extends CounterEvent {
  const IncreamentEvent(String value) : super(value);
}

class DecreamentEvent extends CounterEvent {
  const DecreamentEvent(String value) : super(value);
}

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterStateValid(0)) {
    on<IncreamentEvent>((event, emit) {
      final integer = int.tryParse(event.value);
      if (integer == null) {
        emit(CounterStateInvalidNumber(
          invalidValue: event.value,
          previousValue: state.value,
        ));
      } else {
        emit(CounterStateValid(state.value + integer));
      }
    });
    on<DecreamentEvent>((event, emit) {
      final integer = int.tryParse(event.value);
      if (integer == null) {
        emit(CounterStateInvalidNumber(
          invalidValue: event.value,
          previousValue: state.value,
        ));
      } else {
        emit(CounterStateValid(state.value - integer));
      }
    });
  }
}
