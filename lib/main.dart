import 'package:administrateur/constants.dart';
import 'package:administrateur/pages/HomePage.dart';
import 'package:administrateur/pages/tableau_de_bord/AcceuilPage.dart';
import 'package:administrateur/pages/tableau_de_bord/Administrateurs.dart';
import 'package:administrateur/pages/tableau_de_bord/Ordres.dart';
import 'package:administrateur/pages/tableau_de_bord/Parametres.dart';
import 'package:administrateur/pages/tableau_de_bord/categories.dart';
import 'package:administrateur/pages/tableau_de_bord/notifications.dart';
import 'package:administrateur/pages/tableau_de_bord/pub/gererBannierePub.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyA8Xy8cdyciRA6Z0_AKMQRRrQL2KsmZcAk",
        authDomain: "sportapp-43.firebaseapp.com", // Ensure this is correct
        projectId: "sportapp-43",
        storageBucket: "sportapp-43.appspot.com", // Ensure this is correct
        messagingSenderId: "719953955625",
        appId: "1:719953955625:web:66a99d45228b86bcd8c538",
      
      ),
    );
    print('Firebase initialized successfully!');
  } catch (e) {
    print('Firebase initialization error: $e');
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tableau De Bord D\'administration Du GymBuddy',
      theme: ThemeData(
        primaryColor: Colors.pink.shade200,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink.shade200),
        useMaterial3: true,
      ),
      initialRoute: homePageRoute,
      home: MyHomePage(title: 'Tableau De Bord D\'administration Du GymBuddy'),
      routes: {
        homePageRoute: (context) => MyHomePage(title: 'Tableau De Bord D\'administration Du GymBuddy'),
        acceuilPageRoute: (context) => AcceuilPage(),
        pubPageRoute: (context) => Pub(),
        categoriesPageRoute: (context) => categories(),
        ordresPageRoute: (context) => Ordres(),
        notificationsPageRoute: (context) => notifications(),
        administrateursPageRoute: (context) => Administrateurs(),
        parametresPageRoute: (context) => Parametres(),
      },
    );
  }
}
