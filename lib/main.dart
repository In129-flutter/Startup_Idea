import 'package:flutter/material.dart';
import 'package:startup_ideas_app/screens/idea_listing.dart';
import 'package:startup_ideas_app/screens/idea_submission.dart';
import 'package:startup_ideas_app/screens/leaderboard.dart';

void main() {
  runApp(MyApp());
}
                     
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Startup Ideas',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: '/',
      routes: {
        '/': (context) => IdeaSubmissionScreen(onToggleTheme: _toggleTheme),
        '/listing': (context) => IdeaListingScreen(onToggleTheme: _toggleTheme),
        '/leaderboard':
            (context) => LeaderboardScreen(onToggleTheme: _toggleTheme),
      },
    );
  }
}
