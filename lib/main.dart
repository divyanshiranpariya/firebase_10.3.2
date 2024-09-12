import 'package:firebase_2/views/screens/homepage.dart';
import 'package:firebase_2/views/screens/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '',
    routes: {
      '/': (context) => HomePage(),
      'LoginPage': (context) => LoginPage(),
    },
  ));
}
