import 'package:flutter/material.dart';
import 'base_explore_tab.dart';
import 'base_home_tab.dart';
import 'base_profile_tab.dart';

class BaseHomeShell extends StatefulWidget {
  const BaseHomeShell({super.key});

  @override
  State<BaseHomeShell> createState() => _BaseHomeShellState();
}

class _BaseHomeShellState extends State<BaseHomeShell> {
  int _index = 0;

  static const List<Widget> _tabs = [
    BaseHomeTab(),
    BaseExploreTab(),
    BaseProfileTab(),
  ];

  static const List<String> _titles = [
    'Inicio',
    'Explorar',
    'Perfil',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_index]),
      ),
      body: _tabs[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (value) => setState(() => _index = value),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            label: 'Explorar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
