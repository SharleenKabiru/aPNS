import 'package:assisted_pns/views/persons.dart';
import 'package:assisted_pns/views/updatePatient.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'loginHomeScreen.dart';

class ClientslistPage extends StatefulWidget {
  @override
  _ClientslistPageState createState() => _ClientslistPageState();
}

class _ClientslistPageState extends State<ClientslistPage> {
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => loginHomepage()),
              );
            },
          ),

          IconButton(
            icon: Icon(Icons.add_circle_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PatientsPage()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _patients.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditPatientScreen(
                patient: _patients[index],
                databaseReference: _databaseReference,
                   ),
                ),
              );
              },
            child: Card(
              child: ListTile(
                title: Text(_patients[index]["name"]),
                subtitle: Text(_patients[index]["id"]),
                trailing: _patients[index]["isPatient"]
                    ? const Icon(Icons.check_circle, color: Colors.green)
                    : const Icon(Icons.cancel, color: Colors.red),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditPatientScreen(
                        patient: _patients[index],
                        databaseReference: _databaseReference,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

