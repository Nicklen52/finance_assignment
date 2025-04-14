import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

class PersonPage extends StatefulWidget {
  final String username;

  const PersonPage({super.key, required this.username});

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  void _logout() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove('isLoggedIn');
      prefs.remove('username');

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    });
  }

  String _formattedDate() {
    final now = DateTime.now();
    final weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    final months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${weekdays[now.weekday - 1]}, ${months[now.month - 1]} ${now.day}';
  }

  String _formattedTime(BuildContext context) {
    final now = DateTime.now();
    return TimeOfDay.fromDateTime(now).format(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/gold_blocks.jpg', fit: BoxFit.cover),
          Positioned(
            top: 40,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_formattedDate(),
                    style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold, shadows: [Shadow(blurRadius: 8, color: Colors.black)])),
                Text(_formattedTime(context),
                    style: const TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold, shadows: [Shadow(blurRadius: 8, color: Colors.black)])),
                Text('Welcome, ${widget.username}',
                    style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold, shadows: [Shadow(blurRadius: 8, color: Colors.black)])),
              ],
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: _logout,
              child: const Text("Logout"),
            ),
          )
        ],
      ),
    );
  }
}