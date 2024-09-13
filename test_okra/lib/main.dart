import 'package:flutter/material.dart';
import 'package:okra_widget_official/okra_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Okra Widget Example',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Okra Widget Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => buildWithOptions(context),
              child: const Text('Build with Options'),
            ),
            ElevatedButton(
              onPressed: () => buildWithShortUrl(context),
              child: const Text('Build with Short URL'),
            ),
          ],
        ),
      ),
    );
  }
}

void buildWithOptions(BuildContext context) {
  // var banks = [
  //   "ecobank-nigeria",
  //   "fidelity-bank",
  //   // Add other banks here
  // ];

  Okra.buildWithOptions(
    products: ["auth", ],
    clientName: "clientName",
    context,
    key: '58449ca8-7923-5f69-b308-275c3c78c790',
    token: '63f157fbbad20d13e7664894',
    // Add other options here
    onSuccess: (data) {
      print('Success');
      print(data);
    },
    onError: (message) {
      print('Error');
      print(message);
    },
    onClose: (message) {
      print('Close');
      print(message);
    },
  );
}

void buildWithShortUrl(BuildContext context) {
  Okra.buildWithShortUrl(
    context,
    shortUrl: 'ntgYxoxIx',
    onSuccess: (data) {
      print('Success');
      print(data);
    },
    onError: (message) {
      print('Error');
      print(message);
    },
    onClose: (message) {
      print('Close');
      print(message);
    },
  );
}
