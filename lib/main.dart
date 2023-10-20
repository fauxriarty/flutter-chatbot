import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: const LoginPage(),
      routes: {
        '/home': (context) => const HomePage(
              user: null,
            ),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  final User? user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        toolbarHeight: 50,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.1,
          fontFamily: 'OpenSans',
          color: Color.fromARGB(255, 13, 82, 5),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome, ${user?.displayName}!',
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                fontFamily: 'OpenSans',
                color: Color.fromARGB(255, 101, 151, 118),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'You are logged in.',
              style: TextStyle(
                fontSize: 22,
                fontFamily: 'OpenSans',
                color: Color.fromARGB(255, 101, 151, 118),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
