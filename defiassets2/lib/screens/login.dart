import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:defiassets/screens/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

final _firebase = FirebaseAuth.instance;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  var _enteredEmail = '';
  var _enteredPassword = '';
  var _isAuthenticating = false;
  var _showPassword = false;

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
      // Log users in
      final userCredentials = await _firebase.signInWithEmailAndPassword(
        email: _enteredEmail,
        password: _enteredPassword,
      );
      print(userCredentials);

      // Handle successful login (e.g., navigate to the next screen)
    } on FirebaseAuthException catch (error) {
      print(error.message!);
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
    return Scaffold(
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
              padding: const EdgeInsets.all(14.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  Column(
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
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Email',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !(value.length > 4)) {
                                return "Please enter a valid value";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredEmail = value!;
                            },
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          // Password field with visibility icon
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Password',
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: Icon(!_showPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _showPassword = !_showPassword;
                                  });
                                },
                              ),
                            ),
                            obscureText: !_showPassword,
                            validator: (value) {
                              if (isPasswordValid(value)) {
                                return null;
                              }
                              return "Must be 6+, upper and lower case, special characters";
                            },
                            onSaved: (value) {
                              _enteredPassword = value!;
                            },
                          ),
                          // Login button
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  if (_isAuthenticating)
                    const CircularProgressIndicator()
                  else
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _submit,
                              style: ElevatedButton.styleFrom(
                                elevation: 5,
                              ),
                              child: const Text('Login'),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => const SignUpScreen()));
                            },
                            child: const Text(
                              "Don't have an account? Signup",
                            ),
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
    );
  }
}
