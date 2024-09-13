import 'package:flutter/material.dart';
import 'package:okra_widget_official/okra_widget.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  void buildWithOptions() {
    var banks = [
      "ecobank-nigeria",
      "fidelity-bank",
      "first-bank-of-nigeria",
      "first-city-monument-bank",
      "guaranty-trust-bank",
      "access-bank",
      "unity-bank",
      "alat",
      "polaris-bank",
      "stanbic-ibtc-bank",
      "standard-chartered-bank",
      "sterling-bank",
      "union-bank-of-nigeria",
      "united-bank-for-africa",
      "wema-bank",
      "rubies-bank",
      "kuda-bank"
    ];

    Okra.buildWithOptions(context,
        key: '53720c4d-5adc-5326-bfbf-84160d15b3fa',
        token: '63f157fbbad20d13e7664894',
        color: '#9013fe',
        products: ['auth', 'identity', 'balance', 'transactions'],
        chargeAmount: 1000,
        chargeNote: 'testing',
        chargeType: 'one-time',
        chargeCurrency: 'NGN',
        environment: 'production',
        clientName: 'PaySkul',
        customerBvn: '00000000000',
        logo: 'null',
        limit: 3,
        currency: 'NGN',
        isCorporate: false,
        showBalance: true,
        geoLocation: true,
        payment: false,
        connectMessage: 'Which account do you want to connect with?',
        callbackUrl: 'https://payskul-demo.up.railway.app/core/webhook/',
        redirectUrl: '',
        widgetSuccess: 'Your account was successfully linked to PaySkul',
        widgetFailed: 'An unknown error occurred, please try again.',
        guarantors: {
          'status': false,
          'message': "Okra requires you to add guarantors",
          'number': 3,
        },
        filters: {'industry_type': 'all', 'banks': banks},
        meta: "Test Meta",
        options: {"name": "Flutter Options Test"}, onSuccess: (data) {
      print('Success');
      print(data);
    }, onError: (message) {
      print('error');
      print(message);
    }, onClose: (message) {
      print('close');
      print(message);
    });
  }

  void buildWithShortUrl() {
    Okra.buildWithShortUrl(context, shortUrl: "mZXkiLSAn", onSuccess: (data) {
      print('Success');
      print(data);
    }, onError: (message) {
      print('error');
      print(message);
    }, onClose: (message) {
      print('close');
      print(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle = ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
      Colors.green,
    ));
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("PaySkul Demo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Click button to open Okra Widget'),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                buildWithOptions();
              },
              child: const Text(
                "Build With Options",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                buildWithShortUrl();
              },
              child: const Text(
                "Build With ShortUrl",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
    // This trailing comma makes auto-formatting nicer for build methods.
  }
}
