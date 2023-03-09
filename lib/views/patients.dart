import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_database/firebase_database.dart';

class PatientsPage extends StatefulWidget {
  @override
  _PatientsPageState createState() => _PatientsPageState();
}

class _PatientsPageState extends State<PatientsPage> {
  final _formKey = GlobalKey<FormState>();
  late String _id, _name, _contact;
  bool _isPatient = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Patients"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: "ID"),
              validator: (value) {
                if (value?.isEmpty == true) {
                  return "Please enter the ID";
                }
                return null;
              },
              onSaved: (value) {
                _id = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Name"),
              validator: (value) {
                if (value?.isEmpty == true) {
                  return "Please enter the name";
                }
                return null;
              },
              onSaved: (value) {
                _name = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Contact"),
              validator: (value) {
                if (value?.isEmpty == true) {
                  return "Please enter the contact";
                }
                return null;
              },
              onSaved: (value) {
                _contact = value!;
              },
            ),
            SwitchListTile(
              title: Text("Patient"),
              value: _isPatient,
              onChanged: (bool value) {
                setState(() {
                  _isPatient = value;
                });
              },
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ==true) {
                    _formKey.currentState?.save();
                    savePatientInfo();
                  }
                },
                child: Text("Save"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void savePatientInfo() {
    DatabaseReference patientRef =
    FirebaseDatabase.instance.reference().child("patients").push();
    Map patientInfo = {
      "id": _id,
      "name": _name,
      "contact": _contact,
      "isPatient": _isPatient,
    };
    patientRef.set(patientInfo);
    showToast("Patient info saved successfully");
    Navigator.pop(context);
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[600],
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}