import 'package:administrateur/pages/HomePage.dart';
import 'package:administrateur/pages/tableau_de_bord/AcceuilPage.dart';
import 'package:administrateur/pages/tableau_de_bord/Administrateurs.dart';
import 'package:administrateur/pages/tableau_de_bord/Ordres.dart';
import 'package:administrateur/pages/tableau_de_bord/Parametres.dart';
import 'package:administrateur/pages/tableau_de_bord/categories.dart';
import 'package:administrateur/pages/tableau_de_bord/pub/gererBannierePub.dart';
import 'package:administrateur/pages/tableau_de_bord/notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class SideBarwidget {
  SideBarMenu(context,selectedRoute) {
    return SideBar(
      activeBackgroundColor: const Color.fromARGB(221, 46, 45, 45),
      activeIconColor:Colors.white ,
      
      activeTextStyle: TextStyle(color: Colors.white),
      items: [
        AdminMenuItem(
          title: 'Tableau de bord',
          route: AcceuilPage.id,
          icon: Icons.dashboard,
        ),
        AdminMenuItem(
          title: 'Bannière Publicitaire',
          route: Pub.id,
          icon: CupertinoIcons.photo,
        ),
        AdminMenuItem(
          title: 'Catégories',
          route: categories.id,
          icon: Icons.category,
        ),
        AdminMenuItem(
          title: 'Ordres',
          route: Ordres.id,
          icon: CupertinoIcons.cart_fill,
        ),
        AdminMenuItem(
          title: 'Envoyer des notifications',
          route: notifications.id,
          icon: Icons.notifications,
        ),
        AdminMenuItem(
          title: 'Administrateurs',
          route: Administrateurs.id,
          icon: Icons.person_rounded,
        ),
        AdminMenuItem(
          title: 'Paramètres',
          route: Parametres.id,
          icon: Icons.settings,
        ),
        AdminMenuItem(
          title: 'Se déconnecter',
          route: MyHomePage.id,
          icon: Icons.exit_to_app,
        ),
      ],
      selectedRoute: selectedRoute,
      onSelected: (item) {
        if (item.route != null) {
          Navigator.of(context).pushNamed(item.route!);
        }
      },
      header: Container(
        height: 50,
        width: double.infinity,
        color: Color(0xff444444),
        child: Center(
          child: Text(
            'Menu',
            style: TextStyle(
              letterSpacing: 2,
              color: Colors.white,
              fontWeight:FontWeight.bold,
            ),
          ),
        ),
      ),
      footer: Container(
        height: 50,
        width: double.infinity,
        color: Color(0xff444444),
        child: Center(
          child: Image.asset('assets/images/logo.png', height: 40),
        ),
      ),
    );
  }
}
