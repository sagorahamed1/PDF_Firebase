

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:practice/views/screens/home/home_screen.dart';


Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyCD9dtAOMvqd_SgNsSK65UYRqimgEKaBw4", ///current_key
        appId: "1:685883960151:android:0e5d254fd3cbbfeba92c12", ///mobile sdk id
        messagingSenderId: "685883960151", /// project number
        projectId: "pdf-practice-f5e7c"  /// project id
    )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}
