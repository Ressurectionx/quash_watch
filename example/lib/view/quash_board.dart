import 'package:flutter/material.dart';

import 'screens/app_crash_screen.dart';
import 'screens/network_log_screen.dart';
import 'screens/screen_shot_screen.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.photo),
            label: 'Screenshot',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bug_report),
            label: 'Crash',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.network_check_rounded),
            label: 'Network',
          ),
        ],
      ),
    );
  }

  Widget _getBody(int index) {
    switch (index) {
      case 0:
        return const ScreenshotScreen();
      case 1:
        return const AppCrashScreen();
      case 2:
        return const NetworkLogScreen();
      default:
        return Container();
    }
  }
}
