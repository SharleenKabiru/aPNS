import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class PatientslistPage extends StatefulWidget {
  @override
  _PatientslistPageState createState() => _PatientslistPageState();
}

class _PatientslistPageState extends State<PatientslistPage> {
  final DatabaseReference _databaseReference =
  FirebaseDatabase.instance.ref().child("patients");
  final List<Map<dynamic, dynamic>> _patients = [];

  @override
  void initState() {
    super.initState();
    _databaseReference.onChildAdded.listen(_onPatientAdded);
  }

  void _onPatientAdded(DatabaseEvent event) {
    final Map<dynamic, dynamic>? value = event.snapshot.value as Map<dynamic, dynamic>?;
    if (value != null) {
      setState(() {
      _patients.add(Map<dynamic, dynamic>.from(value));
    });
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Patients"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _patients.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(_patients[index]["name"]),
              subtitle: Text(_patients[index]["contact"]),
              trailing: _patients[index]["isPatient"]
                  ? Icon(Icons.check_circle, color: Colors.green)
                  : Icon(Icons.cancel, color: Colors.red),
            ),
          );
        },
      ),
    );
  }
}

