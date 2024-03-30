import 'package:anx_reader/page/bookshelf_page.dart';
import 'package:anx_reader/page/notes_page.dart';
import 'package:anx_reader/page/settinds_page/settings_page.dart';
import 'package:anx_reader/page/statistics_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const BookshelfPage(),
    const NotesPage(),
    const StatisticPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: _onBottomTap,
        destinations: _bottomBarItems(),
      ),
    );
  }

  void _onBottomTap(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<NavigationDestination> _bottomBarItems() {
    return [
      const NavigationDestination(
        icon: Icon(Icons.book),
        label: 'Bookshelf',
      ),
      const NavigationDestination(
        icon: Icon(Icons.show_chart),
        label: 'Statistics',
      ),
      const NavigationDestination(
        icon: Icon(Icons.note),
        label: 'Notes',
      ),
      const NavigationDestination(
        icon: Icon(Icons.settings),
        label: 'Settings',
      ),
    ];

  }
}