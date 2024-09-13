import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:defiassets/models/transaction.dart';
import 'package:defiassets/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

final _firebase = FirebaseAuth.instance;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  var _enteredEmail = '';
  var _enteredPassword = '';
  var _enteredUsername = '';
  var _enteredFirstname = '';
  var _enteredLastname = '';
  var _enteredReferee = '';
  var _isAuthenticating = false;
  var _showPassword = false;
  var _enteredPhone = '';

  final _formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  String initialCountry = 'NG';
  PhoneNumber number = PhoneNumber(isoCode: 'NG');

  Plan _selectedPlan = Plan.silver;

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
      final userCredentials = await _firebase.createUserWithEmailAndPassword(
        email: _enteredEmail,
        password: _enteredPassword,
      );
      // connect to actual db on FireBase
      await FirebaseFirestore.instance
          .collection("defi_users")
          .doc(userCredentials.user!.uid)
          .set({
        "first_name": _enteredFirstname,
        "last_name": _enteredLastname,
        "username": _enteredUsername,
        "email": _enteredEmail,
        "phone": _enteredPhone,
        "referee": _enteredReferee,
        "plan": _selectedPlan.name,
      });
    } on FirebaseAuthException catch (error) {
      setState(() {
        _isAuthenticating = false;
      });
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 70,
              ),
              const Text(
                'Signup and start transfering',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
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
                      // First Name field
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'First Name',
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
                          _enteredFirstname = value!;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // Last Name field
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Last Name',
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
                          _enteredLastname = value!;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //  Username field
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Username',
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
                          _enteredUsername = value!;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
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
                        height: 10,
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

                      const SizedBox(
                        height: 10,
                      ),

                      // intl number
                      InternationalPhoneNumberInput(
                        onInputChanged: (PhoneNumber number) {
                          print(number.phoneNumber);
                        },
                        onInputValidated: (value) {
                          print(value);
                        },
                        selectorConfig: const SelectorConfig(
                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        ),
                        ignoreBlank: false,
                        autoValidateMode: AutovalidateMode.disabled,
                        selectorTextStyle: const TextStyle(color: Colors.black),
                        initialValue: number,
                        textFieldController: phoneController,
                        formatInput: true,
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                        inputBorder: const OutlineInputBorder(),
                        onSaved: (number) {
                          _enteredPhone = "${number.phoneNumber}";
                        },
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      DropdownButtonFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2),
                          ),
                        ),
                        value: _selectedPlan,
                        items: Plan.values
                            .map(
                              (plan) => DropdownMenuItem(
                                value: plan,
                                child: Text(
                                  plan.name.toUpperCase(),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedPlan = value;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // Password field with visibility icon
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Referee',
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (value) {
                          _enteredReferee = value ?? "none";
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      if (_isAuthenticating)
                        const CircularProgressIndicator()
                      else
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _submit,
                            style: ElevatedButton.styleFrom(
                              elevation: 5,
                            ),
                            child: const Text('SignUp'),
                          ),
                        ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => const LoginScreen()));
                        },
                        child: const Text('Already signed up? Login'),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
