import 'package:assisted_pns/views/partner.dart';
import 'package:assisted_pns/views/persons.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'loginHomeScreen.dart';

class PartnerlistPage extends StatefulWidget {
  const PartnerlistPage({Key? key}) : super(key: key);

  @override
  _PartnerlistPageState createState() => _PartnerlistPageState();
}

class _PartnerlistPageState extends State<PartnerlistPage> {
  final DatabaseReference _databaseReference =
  FirebaseDatabase.instance.ref().child("partner");
  final List<Map<dynamic, dynamic>> _partner = [];

  @override
  void initState() {
    super.initState();
    _databaseReference.onChildAdded.listen(_onPartnerAdded);
  }

  void _onPartnerAdded(DatabaseEvent event) {
    final Map<dynamic, dynamic>? value = event.snapshot.value as Map<dynamic, dynamic>?;
    if (value != null) {
      setState(() {
        _partner.add(Map<dynamic, dynamic>.from(value));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Partners"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => loginHomepage()),
              );
            },
          ),

          IconButton(
            icon: const Icon(Icons.add_circle_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PartnerPage()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _partner.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PatientsPage()),
            );
          },
            child: Card(
              child: ListTile(
                title: Text(_partner[index]["patientID"].toString()),
                subtitle: Text(_partner[index]["partnerID"].toString()),
                  trailing: Text(_partner[index]["partnerName"].toString())
              ),
            ),
          );
        },
      ),
    );
  }
}

