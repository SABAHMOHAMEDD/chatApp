import 'package:chat_app/ui/login/login_screen.dart';
import 'package:chat_app/ui/registeration/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blue),
      routes: {
        RegisterScreen.RouteName: (_) => RegisterScreen(),
        LoginScreen.RouteName: (_) => LoginScreen()
      },
      initialRoute: LoginScreen.RouteName,
    );
  }
}


