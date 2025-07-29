import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ValidatorPage extends StatefulWidget {
  const ValidatorPage({super.key});

  @override
  ValidatorPageState createState() => ValidatorPageState();
}

class ValidatorPageState extends State<ValidatorPage> {
  final _formKey = GlobalKey<FormState>();
  static final RegExp _englishOnlyRegExp = RegExp(r'^[a-zA-Z]+$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('English Input Validator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Username',
                  hintText: 'Enter English letters only',
                ),
                //Optional: Restrict input in real-time
                inputFormatters: [
                  FilteringTextInputFormatter.allow(_englishOnlyRegExp),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  if (!_englishOnlyRegExp.hasMatch(value)) {
                    return 'Only English letters (a-z, A-Z) are allowed';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Input is valid!')),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
