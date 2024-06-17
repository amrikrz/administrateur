import 'package:administrateur/pages/HomePage.dart';
import 'package:administrateur/pages/tableau_de_bord/Administrateurs.dart';
import 'package:administrateur/pages/tableau_de_bord/Ordres.dart';
import 'package:administrateur/pages/tableau_de_bord/Parametres.dart';
import 'package:administrateur/pages/tableau_de_bord/categories.dart';
import 'package:administrateur/pages/tableau_de_bord/pub/gererBannierePub.dart';
import 'package:administrateur/pages/tableau_de_bord/notifications.dart';
import 'package:administrateur/pages/tableau_de_bord/sidebar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class AcceuilPage extends StatelessWidget {
  static const String id = 'acceuil-home';

  SideBarwidget _slideBarwidget=SideBarwidget();

  @override
  Widget build(BuildContext context) {
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
      sideBar:_slideBarwidget.SideBarMenu(context, AcceuilPage.id) ,
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.all(10),
          child: Text(
            'Dashboard',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 36,
            ),
          ),
        ),
      ),
    );
  }
}
