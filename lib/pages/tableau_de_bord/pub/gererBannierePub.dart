import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:firebase_storage/firebase_storage.dart' as fb;
import 'package:administrateur/services/firebase_services.dart';
import 'package:administrateur/pages/tableau_de_bord/sidebar.dart';
import 'package:administrateur/pages/tableau_de_bord/pub/pub_widget.dart';

class Pub extends StatefulWidget {
  static const String id = 'pub-page';

  @override
  State<Pub> createState() => _PubState();
}

class _PubState extends State<Pub> {
  late ProgressDialog progressDialog;
  bool _visible = false;
  SideBarwidget _sideBarwidget = SideBarwidget();
  var _fileNameTextController = TextEditingController();
  bool _imageselected = true;
  late String _url;
  FirebaseServices _services = FirebaseServices();

  @override
  void initState() {
    super.initState();
    progressDialog = ProgressDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    SideBarwidget _sideBar = SideBarwidget();

    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Tableau de bord de l\'application GymBuddy',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black87,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      sideBar: _sideBar.SideBarMenu(context, Pub.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Publicité page',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
              Text(
                'Ajouter/supprimer des images de bannière de l\'écran d\'accueil',
              ),
              Divider(
                thickness: 5,
              ),
              PubWidget(),
              Divider(
                thickness: 5,
              ),
              Container(
                color: Colors.grey,
                width: MediaQuery.of(context).size.width,
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Row(
                    children: [
                      Visibility(
                        visible: _visible,
                        child: Container(
                          child: Row(
                            children: [
                              AbsorbPointer(
                                absorbing: true,
                                child: SizedBox(
                                  width: 300,
                                  height: 30,
                                  child: TextField(
                                    controller: _fileNameTextController,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 1,
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'no image selected',
                                      border: OutlineInputBorder(),
                                      contentPadding:
                                          EdgeInsets.only(left: 20),
                                    ),
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  _pickImage();
                                },
                                child: Text(
                                  'Télécharger une image',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              AbsorbPointer(
                                absorbing: _imageselected,
                                child: TextButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.black),
                                  ),
                                  onPressed: () {
                                    progressDialog.show();

                                    _services
                                        .uploadBannerImageTo(_url)
                                        .then((downloadUrl) {
                                      if (downloadUrl != null) {
                                        progressDialog.dismiss();
                                        _services.showMyDialog(
                                          title: 'Nouvelle pub image',
                                          message:
                                              'saved banner image successfully',
                                          context: context,
                                        );
                                      }
                                    });
                                  },
                                  child: Text(
                                    'Enregistrer l\'image',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: _visible ? false : true,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              _visible = true;
                            });
                          },
                          child: Text(
                            'Ajouter une nouvelle publication',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pickImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      setState(() {
        _fileNameTextController.text = result.files.first.name;
        _imageselected = false;
        _url = 'publicité/${DateTime.now()}'; // Adjust path as needed
      });

      // Use fb alias for FirebaseStorage.instance
      fb.FirebaseStorage.instance
          .ref('Banners')
          .child(_url)
          .putFile(File(result.files.single.path!))
          .then((_) {
        print('File uploaded successfully');
      }).catchError((error) {
        print('Error uploading file: $error');
        // Handle upload error
      });
    }
  }
}

class ProgressDialog {
  final BuildContext context;
  bool _isShowing = false;

  ProgressDialog(this.context);

  void show() {
    if (!_isShowing) {
      _isShowing = true;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 16),
                  Text("Loading..."),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  void dismiss() {
    if (_isShowing) {
      _isShowing = false;
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}
