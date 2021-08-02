import 'package:codeforces_data_flutter/screens/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserName extends StatelessWidget {
  String username;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: Icon(
                  CupertinoIcons.chart_bar_alt_fill,
                  color: Colors.green,
                  size: 70.0,
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the username';
                  }
                  return null;
                },
                onChanged: (newValue) {
                  username = newValue.toString();
                },
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Enter the codeforces username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
                child: MaterialButton(
                  elevation: 10.0,
                  height: 50.0,
                  color: Colors.blue,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(
                            username: username,
                          ),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'SUBMIT',
                    style: TextStyle(color: Colors.white),
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
