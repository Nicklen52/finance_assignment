import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'person.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final String _validUsername = "admin";
  final String _validPassword = "123456";

  void _login() {
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (username == _validUsername && password == _validPassword) {
      SharedPreferences.getInstance().then((prefs) {
        prefs.setBool('isLoggedIn', true);
        prefs.setString('username', username);

        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => PersonPage(username: username),
          ),
        );
      });
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid credentials")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/gold_blocks.jpg', fit: BoxFit.cover),
          Center(
            child: Container(
              padding: const EdgeInsets.all(24),
              margin: const EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Login",
                      style: TextStyle(fontSize: 26, color: Colors.white)),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      hintText: "Username",
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      hintText: "Password",
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _login,
                    child: const Text("Login"),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
