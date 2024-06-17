import 'package:administrateur/pages/tableau_de_bord/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class Administrateurs extends StatelessWidget {
  static const String id = 'Administrateurs-page';

  @override
  Widget build(BuildContext context) {
    SideBarwidget _sideBar=SideBarwidget();
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
      sideBar:_sideBar.SideBarMenu(context, Administrateurs.id) ,
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.all(10),
          child: Text(
            'Administrateur page',
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
