import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Form Example',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          title: Text(
            'Flutter Form Example',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: FormScreen(),
        ),
      ),
    );
  }
}

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isChecked = false;
  bool _hasDigitsInName = false;
  bool _hasNonDigitsInPhoneNumber = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Card(
          elevation: 5,
          margin: EdgeInsets.all(100),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 400, 
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Name',
                        ),
                        onChanged: (value) {
                          setState(() {
                            _hasDigitsInName = value.contains(RegExp(r'[0-9]'));
                          });
                          if (_hasDigitsInName) {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text('Warning'),
                                content: Text('Name should not contain digits.'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          } else if (_hasDigitsInName) {
                            return 'Name should not contain digits';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 400, 
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Address',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your address';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 400, 
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                        ),
                        onChanged: (value) {
                          setState(() {
                            _hasNonDigitsInPhoneNumber = !RegExp(r'^[0-9]+$').hasMatch(value);
                          });
                          if (_hasNonDigitsInPhoneNumber) {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text('Warning'),
                                content: Text('Phone number should only contain digits.'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your phone number';
                          } else if (_hasNonDigitsInPhoneNumber) {
                            return 'Phone number should only contain digits';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 400, 
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a password';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          } else if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                            return 'Password must contain at least one special character';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Checkbox(
                          value: _isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              _isChecked = value ?? false;
                            });
                            print('Agree to terms checkbox toggled: $_isChecked');
                          },
                        ),
                        Text('Agree to terms'),
                      ],
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Form submitted')));
                          print('Form submitted');
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
