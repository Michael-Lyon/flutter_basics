import 'package:defiassets/widgets/rounded_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        toolbarHeight: 110,
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Material(
            color: Theme.of(context).colorScheme.primary,
            shape: const CircleBorder(),
          ),
        ),
        title: const Text(
          "Hi, Amanda",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: const Center(
        child: Text('Your app content goes here'),
      ),
      bottomNavigationBar: RoundedBottomNavBar()
    );
  }
}
