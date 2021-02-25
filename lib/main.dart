import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoApp/providers/todos_provider.dart';
import 'package:todoApp/screen/detail_screen.dart';
import './screen/tabscreen.dart';
import 'package:firebase_core/firebase_core.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool _initialized = false;
  bool _error = false;

  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return Center(
        child: Text('erreur'),
      );
    }
    if (!_initialized) {
      return MaterialApp(
        title: 'Todo',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: RefreshProgressIndicator(),
          ),
        ),
      );
    }
    return ChangeNotifierProvider(
      create: (_) => Todo(),
      child: MaterialApp(
        title: 'Todo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // primarySwatch: Colors.black87,
          // accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        // home: TabsScreen(),
        initialRoute: '/',
        routes: {
          '/': (context) => TabsScreen(),
          DetailScreen.routeName: (context) => DetailScreen(),
        },
      ),
    );
  }
}
