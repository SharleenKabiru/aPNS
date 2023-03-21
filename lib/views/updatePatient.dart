import 'package:assisted_pns/views/persons_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditPatientScreen extends StatefulWidget {
  final Map<dynamic, dynamic> patient;
  final DatabaseReference databaseReference;

   EditPatientScreen({super.key, required this.patient, required this.databaseReference});

  @override
  _EditPatientScreenState createState() => _EditPatientScreenState();
}

class _EditPatientScreenState extends State<EditPatientScreen> {
  final _formKey = GlobalKey<FormState>();

  late String  _id;
  late String _name;
  late String _contact;
  late bool _isPatient;

  get patients => null;

  @override
  void initState() {
    super.initState();
    _id = widget.patient['id'];
    _name = widget.patient['name'];
    _contact = widget.patient['contact'];
    _isPatient = widget.patient['isPatient'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Patient"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                initialValue: _id,
                decoration: const InputDecoration(labelText: "ID"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your national ID number";
                  }
                  return null;
                },
                onChanged: (value) {
                  _id = value;
                },
              ),
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(labelText: "Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a name";
                  }
                  return null;
                },
                onChanged: (value) {
                  _name = value;
                },
              ),
              TextFormField(
                initialValue: _contact,
                decoration: const InputDecoration(labelText: "Contact"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a contact";
                  }
                  return null;
                },
                onChanged: (value) {
                  _contact = value;
                },
              ),
              CheckboxListTile(
                title: const Text("Is Patient"),
                value: _isPatient,
                onChanged: (value) {
                  setState(() {
                    _isPatient = value!;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                child: const Text("Save"),
                onPressed: () {
                  print('${widget.patient['key']}');
                  if (_formKey.currentState!.validate()) {
                    widget.databaseReference.child(widget.patient['key']).update({
                      "key": _formKey,
                      "id": _id,
                      "name": _name,
                      "contact": _contact,
                      "isPatient": _isPatient,
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ClientslistPage())
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updatePatient(String key, Map<dynamic, dynamic> newPatient) {

    DatabaseReference patientRef =
    FirebaseDatabase.instance.ref().child(key).update(patients) as DatabaseReference;
    setState(() {
      int index =
      patients.indexWhere((patient) => patient['key'] == _formKey);
      patients[index] = newPatient;
    });
    patientRef.update(newPatient as Map<String, Object?>);
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