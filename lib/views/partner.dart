import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_database/firebase_database.dart';

class PartnerPage extends StatefulWidget {
  const PartnerPage({super.key});

  @override
  _PartnerPageState createState() => _PartnerPageState();
}

class _PartnerPageState extends State<PartnerPage> {
  final _formKey = GlobalKey<FormState>();
  int? _patientID, _partnerID, _notID;
  late String  _partnerName, _relationship;
  bool _notified = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Partner"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: "Patient's ID"),
              validator: (value) {
                if (value?.isEmpty == true) {
                  return "Please enter the ID of the index patient";
                }
                return null;
              },
              onSaved: (value) {
                _patientID = int.tryParse(value!) ?? 0;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Partner's ID"),
              validator: (value) {
                if (value?.isEmpty == true) {
                  return "Please enter the ID of the index patient";
                }
                return null;
              },
              onSaved: (value) {
                _partnerID = int.tryParse(value!) ?? 0;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Partner's Name"),
              validator: (value) {
                if (value?.isEmpty == true) {
                  return "Please enter the name";
                }
                return null;
              },
              onSaved: (value) {
                _partnerName = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Relationship"),
              validator: (value) {
                if (value?.isEmpty == true) {
                  return "Please enter the relationship of the partner to the patient";
                }
                return null;
              },
              onSaved: (value) {
                _relationship = value!;
              },
            ),
            SwitchListTile(
              title: const Text("Is there notification sent?"),
              value: _notified,
              onChanged: (bool value) {
                setState(() {
                  _notified = value;
                });
              },
            ),

            TextFormField(
              decoration: const InputDecoration(labelText: "Notification ID"),
              validator: (value) {
                if (value?.isEmpty == true) {
                  return "Please enter the ID of the notification";
                }
                return null;
              },
              onSaved: (value) {
                _notID = int.tryParse(value!) ?? 0;
              },
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ==true) {
                    _formKey.currentState?.save();
                    savePartnerInfo();
                  }
                },
                child: const Text("Save"),
              ),
            ),
          ],
        ),
      ),
    )
    );
  }

  void savePartnerInfo() {
    DatabaseReference patientRef =
    FirebaseDatabase.instance.ref().child("partner").push();
    Map patientInfo = {
      "patientID": _patientID,
      "partnerID": _partnerID,
      "partnerName": _partnerName,
      "relationship": _relationship,
      "notified": _notified,
      "notID": _notID,
    };
    patientRef.set(patientInfo);
    showToast("Partner info is saved successfully");
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