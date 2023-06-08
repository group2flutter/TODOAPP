import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Todo_App/screens/settingScreen.dart';
import 'package:provider/provider.dart';
import 'app_drawer.dart';
import 'screens/home.dart';
import 'screens/settingScreen.dart';

void main() {
  runApp(
    ChangeNotifierProvider<ThemeModel>(
      create: (_) => ThemeModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Consumer<ThemeModel>(
      builder: (context, themeModel, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'ToDo App',
          theme: themeModel.themeData,
          home: const MyAppHome(),
        );
      },
    );
  }
}

class MyAppHome extends StatefulWidget {
  const MyAppHome({Key? key}) : super(key: key);

  @override
  _MyAppHomeState createState() => _MyAppHomeState();
}

class _MyAppHomeState extends State<MyAppHome> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    Home(),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo App'),
      ),
      drawer: AppDrawer(),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class ThemeModel extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeData get themeData => _isDarkMode ? ThemeData.dark() : ThemeData.light();

  void toggleDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }
}
