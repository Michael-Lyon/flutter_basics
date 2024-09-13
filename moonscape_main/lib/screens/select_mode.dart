import 'package:flutter/material.dart';

class ModeSelectionScreen extends StatefulWidget {
  const ModeSelectionScreen({super.key});

  @override
  _ModeSelectionScreenState createState() => _ModeSelectionScreenState();
}

class _ModeSelectionScreenState extends State<ModeSelectionScreen> {
  String selectedMode = '';

  void selectMode(String mode) {
    setState(() {
      selectedMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Sign in mode',
          style: TextStyle(color: Colors.black54),
        ),
        backgroundColor: Colors.grey.shade200,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo at the top
            Padding(
              padding: const EdgeInsets.only(top: 40.0, bottom: 20.0),
              child: Image.asset(
                'assets/logo.png', // Replace with your logo
                height: 40,
              ),
            ),
            const Text(
              'Try Moodscapes for Free!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Select your mode...',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            // Mode selection cards
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildModeCard('Event Planner', Icons.event_available,
                    selectedMode == 'Event Planner'),
                const SizedBox(width: 16),
                _buildModeCard('Vendor', Icons.store, selectedMode == 'Vendor'),
                const SizedBox(width: 16),
                _buildModeCard('Event Center', Icons.location_on,
                    selectedMode == 'Event Center'),
                const SizedBox(width: 16),
                _buildModeCard(
                    'Client', Icons.person, selectedMode == 'Client'),
              ],
            ),
            const SizedBox(height: 40),
            // Login and terms section
            TextButton(
              onPressed: () {
                // Handle login action
              },
              child: const Text(
                'Already have an account? Login here',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Privacy Policy    Terms of Service',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModeCard(String title, IconData icon, bool isSelected) {
    return GestureDetector(
      onTap: () {
        selectMode(title);
      },
      child: Card(
        elevation: isSelected ? 4 : 1,
        shape: RoundedRectangleBorder(
          side: isSelected
              ? BorderSide(color: Colors.blueAccent, width: 2)
              : BorderSide.none,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isSelected ? Colors.blue.shade50 : Colors.grey.shade100,
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 36,
                color: Colors.black54,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
