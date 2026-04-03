import 'package:flutter/material.dart';

import '../../core/colors/app_colors.dart';
import '../views/home/home_view.dart';
import '../views/stub_screen.dart';
import '../widgets/navigation/bottom_nav_bar.dart';

/// Shell widget that wraps the bottom navigation bar around tab content.
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  static const _screens = <Widget>[
    HomeView(),
    StubScreen(title: 'Search'),
    StubScreen(title: 'Summarize'),
    StubScreen(title: 'Fact Check'),
    StubScreen(title: 'Vault'),
    StubScreen(title: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
      ),
    );
  }
}
