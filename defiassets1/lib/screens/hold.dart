import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

final _firebase = FirebaseAuth.instance;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  var _isLogin = true;
  var _enteredEmail = '';
  var _enteredPassword = '';
  var _enteredUsername = '';
  var _isAuthenticating = false;

  final _formKey = GlobalKey<FormState>();

  // password check function
  bool isPasswordValid(String? password) {
    // Define your password criteria
    if (password != null) {
      const minLength = 6;
      final hasUppercase = RegExp(r'[A-Z]').hasMatch(password);
      final hasLowercase = RegExp(r'[a-z]').hasMatch(password);
      final hasDigits = RegExp(r'[0-9]').hasMatch(password);
      final hasSpecialCharacters =
          RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password);

      // Check if the password meets all criteria
      return password.length >= minLength &&
          hasUppercase &&
          hasLowercase &&
          hasDigits &&
          hasSpecialCharacters;
    }
    return false;
  }

  void _submit() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Ensure all fields are valid."),
        ),
      );
      return; // Stop processing if form validation fails
    }

    _formKey.currentState!.save();

    try {
      setState(() {
        _isAuthenticating = true;
      });
      if (_isLogin) {
        // Log users in
        final userCredentials = await _firebase.signInWithEmailAndPassword(
          email: _enteredEmail,
          password: _enteredPassword,
        );

        // Handle successful login (e.g., navigate to the next screen)
      } else {
        final userCredentials = await _firebase.createUserWithEmailAndPassword(
          email: _enteredEmail,
          password: _enteredPassword,
        );

        // connect to actual db on FireBase
        await FirebaseFirestore.instance
            .collection("defi_users")
            .doc(userCredentials.user!.uid)
            .set({
          "username": _enteredUsername,
          "email": _enteredEmail,
        });
      }
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message!),
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: SvgPicture.asset(
              'assets/images/Background.svg',
              fit: BoxFit.cover,
            ),
          ),

          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(14.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Container(
                    child: Column(
                      children: [
                        const Text(
                          'Login and start transfering',
                          style: TextStyle(
                            fontSize: 33,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Login',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: 33,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 70,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // height: 350,
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // color: Colors.red,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Email field
                          const TextField(
                            decoration: InputDecoration(
                              hintText: 'Email',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          // Password field with visibility icon
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Password',
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.visibility),
                                onPressed: () {
                                  // TODO: Implement password visibility toggle
                                },
                              ),
                            ),
                          ),
                          // Login button
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                // TODO: Implement login functionality
                              },
                              child: const Text('Login'),
                              style: ElevatedButton.styleFrom(
                                elevation: 5,
                              )),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Create Account'),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
