import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'person.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _selectedIndex = 0;
  final String _username = "Guest"; // Replace with actual username when connected to database

  void _enterProfile() {
    SharedPreferences.getInstance().then((prefs) {
      bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      String username = prefs.getString('username') ?? '';

      if (!mounted) return; // now this mounted check is valid

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => isLoggedIn
              ? PersonPage(username: username)
              : const LoginPage(),
        ),
      );
    });
  }

  String _formattedDate() {
    final now = DateTime.now();
    final weekdays = [
      'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
    ];
    final months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${weekdays[now.weekday - 1]}, ${months[now.month - 1]} ${now.day}';
  }

  String _formattedTime() {
    final now = DateTime.now();
    return TimeOfDay.fromDateTime(now).format(context);
  }

  final List<IconData> _icons = [
    Icons.pie_chart, // 明细
    Icons.receipt, // 账单
    Icons.savings, // 存钱
    Icons.person, // 我的
  ];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/gold_blocks.jpg',
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 40,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _formattedDate(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        shadows: [Shadow(blurRadius: 8, color: Colors.black)],
                      ),
                    ),
                    Text(
                      _formattedTime(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        shadows: [Shadow(blurRadius: 8, color: Colors.black)],
                      ),
                    ),
                    Text(
                      'Welcome, $_username',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        shadows: [Shadow(blurRadius: 8, color: Colors.black)],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: SizedBox(
            height: 80,
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: (index) {
                if (index == 3) {
                  _enterProfile();
                } else {
                  setState(() {
                    _selectedIndex = index;
                  });
                }
              },
              selectedItemColor: Colors.amber,
              unselectedItemColor: Colors.white,
              backgroundColor: Colors.black.withOpacity(0.7),
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 14,
              unselectedFontSize: 12,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.pie_chart), label: '明细'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.receipt), label: '账单'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.savings), label: '存钱'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: '我的'),
              ],
            ),
          ),
        ),
        // Circular + button floating above bottom nav
        Positioned(
          bottom: 40,
          left: MediaQuery
              .of(context)
              .size
              .width / 2 - 28, // Centered horizontally
          child: FloatingActionButton(
            onPressed: () {
              // Action on + tap
            },
            backgroundColor: Colors.amber,
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ],
    );
  }
}