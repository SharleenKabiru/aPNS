import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:assisted_pns/auth_service.dart';
import 'package:firebase_database/firebase_database.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _databaseReference = FirebaseDatabase.instance.reference();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _numberController = TextEditingController();
  late String _name, _email, _password, _mobileNumber, _number;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Number"),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return "Please enter the number";
                  }
                  return null;
                },
                controller: _numberController,
                onChanged: (value) {
                  _number = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Name"),
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return "Please enter your name";
                  }
                  return null;
                },
                controller: _nameController,
                onChanged: (value) {
                  _name = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Email"),
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return "Please enter your email";
                  }
                  return null;
                },
                controller: _emailController,
                onChanged: (value) {
                  _email = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return "Please enter a password";
                  }
                  return null;
                },
                controller: _passwordController,
                onChanged: (value) {
                  _password = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Mobile Number"),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return "Please enter your mobile number";
                  }
                  return null;
                },
                controller: _mobileNumberController,
                onChanged: (value) {
                  _mobileNumber = value;
                },
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ==true) {
                      _formKey.currentState?.save();
                      registerUser();
                    }
                  },
                  child: Text("Register"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void registerUser() async {
    AuthService auth = AuthService();
    UserCredential? userCredential =
    await auth.createUserWithEmailAndPassword(_email, _password);
    if (userCredential != null) {
      showToast("Registration successful");
      Navigator.pop(context);
    } else {
      showToast("Registration failed");
    }
    DatabaseReference patientRef =
    FirebaseDatabase.instance.ref().child("hts_counsellors").push();
    Map patientInfo = {
      "number": _number,
       "name": _name,
      "email": _email,
      "password": _password,
      "mobileNumber": _mobileNumber,
    };
    patientRef.set(patientInfo);
  }


  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[600],
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}

