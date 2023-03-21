import 'package:assisted_pns/views/partnerlist.dart';
import 'package:assisted_pns/views/persons_list.dart';
import 'package:assisted_pns/views/test_results.dart';
import 'package:flutter/material.dart';

import 'analysis_view.dart';
import 'hts_assignments.dart';
import 'notifications.dart';

class loginHomepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView(
         // mainAxisAlignment: MainAxisAlignment.center,
          gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 40,
            crossAxisSpacing: 40,
            crossAxisCount: 2,
            childAspectRatio: 1.0,
        ),


          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ClientslistPage()),
                );
              },
              child: Text("Patients"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PartnerlistPage()),
                );
              },
              child: Text("Trace Visualisation"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => testresultsview()),
                );
              },
              child: Text("Test Results"),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => analysisview()),
                );
              },
              child: Text("Analysis"),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => notificationsView()),
                );
              },
              child: Text("Notifications"),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => assignmentsView()),
                );
              },
              child: Text("MyAssignments"),
            ),
          ],
        ),
      ),
    );
  }
}
