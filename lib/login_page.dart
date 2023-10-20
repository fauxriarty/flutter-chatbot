import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  bool isLoading = false;
  String? errorMessage;

  Future<User?> signInWithGoogle() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        return userCredential.user;
      }
    } catch (error) {
      setState(() {
        errorMessage = "Error logging in. Please try again.";
      });
      // ignore: avoid_print
      print(error);
      return null;
    } finally {
      setState(() {
        isLoading = false;
      });
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter Demo Login',
          style: TextStyle(color: Color.fromARGB(255, 13, 68, 37)),
        ),
        centerTitle: true,
        elevation: 0, // to make it flush with the body
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade400, Colors.green.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (isLoading)
                const CircularProgressIndicator()
              else
                const Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(
                          'assets/wgq1m1806tz51.jpg'), // your app logo
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Welcome to Flutter Apps!",
                      style: TextStyle(
                          fontSize: 24, color: Color.fromARGB(255, 9, 75, 5)),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "One stop solution for all your needs.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16, color: Color.fromARGB(153, 5, 53, 35)),
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              ElevatedButton.icon(
                icon: const Icon(Icons.login,
                    size: 20, color: Color.fromARGB(255, 12, 85, 51)),
                label: const Text(
                  " Login with Google",
                  style: TextStyle(
                      color: Color.fromARGB(255, 11, 74, 44), fontSize: 16),
                ),
                onPressed: () async {
                  User? user = await signInWithGoogle();
                  if (user != null) {
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage(user: user)),
                    );
                  }
                },
              ),
              const SizedBox(height: 70),
              if (errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    errorMessage!,
                    style: const TextStyle(color: Colors.redAccent),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
