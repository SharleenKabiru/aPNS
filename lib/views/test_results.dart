import 'package:assisted_pns/views/testresult_form.dart';
import 'package:flutter/material.dart';

import 'loginHomeScreen.dart';

class testresultsview extends StatefulWidget {
  const testresultsview({Key? key}) : super(key: key);

  @override
  State<testresultsview> createState() => _testresultsviewState();
}

class _testresultsviewState extends State<testresultsview> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text("Test Results"),
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
              MaterialPageRoute(builder: (context) => testresultsform()),
            );
          },
        ),
      ],
    ),
    );
}