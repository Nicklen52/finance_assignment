import 'package:flutter/material.dart';

void main() {
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
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/gold_blocks.jpg',
            fit: BoxFit.cover,
          ),
          Center(
            child: Text(
              'Welcome to Your Finance Dashboard',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(blurRadius: 10, color: Colors.black)],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    bottomNavigationBar: SizedBox(
    height: 80, // 👈 increase this value as needed
    child: BottomNavigationBar(
    currentIndex: _selectedIndex,
    onTap: (index) {
    setState(() {
    _selectedIndex = index;
    });
    },
    selectedItemColor: Colors.amber,
    unselectedItemColor: Colors.white,
    backgroundColor: Colors.black.withOpacity(0.7),
    type: BottomNavigationBarType.fixed,
    selectedFontSize: 14,
    unselectedFontSize: 12,
    items: const [
    BottomNavigationBarItem(
    icon: Icon(Icons.pie_chart),
    label: '明细',
    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.receipt),
    label: '账单',
    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.savings),
    label: '存钱',
    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.person),
    label: '我的',
    ),
    ],
    ),
    )
    );
  }
}