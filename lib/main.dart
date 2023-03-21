import 'package:assisted_pns/views/homescreen.dart';
import 'package:assisted_pns/views/loginHomeScreen.dart';
import 'package:assisted_pns/views/partner.dart';
import 'package:assisted_pns/views/partnerlist.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      title: 'aPNS',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:  loginHomepage(),
    ),
  );
}




