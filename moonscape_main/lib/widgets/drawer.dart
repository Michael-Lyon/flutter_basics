import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onSelectScreen});

  final void Function(String identifier) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Section
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            margin: const EdgeInsets.all(0),
            accountName: const Text(
              "Martins Osodi",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            accountEmail: const Text(
              "martins.osodi@gmail.com",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              child: const Text(
                "MO",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            otherAccountsPictures: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close, color: Colors.grey),
              ),
            ],
          ),
          // Free trial expired message
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  'Free trial expired',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Upgrade Section
          Container(
            width: double.infinity,
            color: const Color.fromARGB(255, 216, 254, 173),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 169, 246, 121),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 32,
                    ),
                  ),
                  child: const Text(
                    'Upgrade Now',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Get Full Access to Moodscapes',
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Drawer Options
          ListTile(
            leading: const Icon(Icons.dashboard, color: Colors.black54),
            title: const Text(
              'Dashboard',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            onTap: () {
              onSelectScreen('dashboard');
            },
          ),
          ListTile(
            leading: const Icon(Icons.format_quote, color: Colors.black54),
            title: const Text(
              'Quotes',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            onTap: () {
              onSelectScreen('quotes');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.black54),
            title: const Text(
              'Account Settings',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            onTap: () {
              onSelectScreen('account-settings');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.support, color: Colors.black54),
            title: const Text(
              'Support Center',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            onTap: () {
              onSelectScreen('support-center');
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.black54),
            title: const Text(
              'Log Out',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            onTap: () {
              onSelectScreen('log-out');
            },
          ),
        ],
      ),
    );
  }
}
