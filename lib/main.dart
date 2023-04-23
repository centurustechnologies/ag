import 'package:ag_financial_admin_pannel/admincontrol.dart';
import 'package:ag_financial_admin_pannel/login.dart';
import 'package:ag_financial_admin_pannel/report.dart';

import 'package:ag_financial_admin_pannel/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'dart.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyDd0Mys0q9teMWrgy217zSXWLtHus6kolE",
        authDomain: "ag-financial-services.firebaseapp.com",
        projectId: "ag-financial-services",
        storageBucket: "ag-financial-services.appspot.com",
        messagingSenderId: "936184331003",
        appId: "1:936184331003:web:07b9449e193150660c4e5e",
        measurementId: "G-WX66KHW1QQ"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home://Textfi()
       const Login(),
    );
  }
}
