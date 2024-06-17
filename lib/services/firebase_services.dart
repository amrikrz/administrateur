import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dart/firebase_dart.dart';
import 'package:flutter/material.dart';
export 'firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference banners =
      FirebaseFirestore.instance.collection('publicité');
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<bool> authenticateAdministrator(
      String username, String password) async {
    try {
      QuerySnapshot<Map<String, dynamic>> result = await FirebaseFirestore
          .instance
          .collection('Administrateur')
          .where('nom', isEqualTo: username)
          .get();
      if (result.docs.isNotEmpty) {
        var adminData = result.docs.first.data();
        if (adminData['motdepasse'] == password) {
          return true;
        }
      }
    } catch (e) {
      print('Error authenticating administrator: $e');
    }
    return false;
  }

  Future<String> uploadBannerImageTo(url) async {
    String downloadUrl = await storage.ref(url).getDownloadURL();
    if (downloadUrl != null) {
      firestore.collection('publicité').add({
        'image': downloadUrl,
      });
    }
    return downloadUrl;
  }

  deleteBannerImageformdb(id) async {
    firestore.collection('publicité').doc(id).delete();
  }


  Future <void> confirmDeleteDialog({
    required String title,
    required String message,
    required BuildContext context,
    required String id,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Supprimer'),
              onPressed: () {
                deleteBannerImageformdb(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showMyDialog({
    required String title,
    required String message,
    required BuildContext context,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('D\'accord'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
