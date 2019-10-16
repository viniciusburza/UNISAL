import 'package:flutter/material.dart';
import 'package:lost_and_found/views/about_page.dart';
import 'package:lost_and_found/views/found_page.dart';
import 'package:lost_and_found/views/home_page.dart';
import 'package:lost_and_found/views/profile_page.dart';
import 'package:lost_and_found/views/sign_in_page.dart';
import 'package:lost_and_found/views/use_term_page.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          _showHeader(),
          ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushReplacementNamed(HomePage.routeName);
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.dashboard),
              title: Text("Perfil"),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context)
                    .pushReplacementNamed(ProfilePage.routeName);
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.cloud_upload),
              title: Text("Achados"),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushReplacementNamed(FoundPage.routeName);
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.info_outline),
              title: Text("Sobre o projeto"),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushReplacementNamed(AboutPage.routeName);
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.description),
              title: Text("Termos de Uso"),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context)
                    .pushReplacementNamed(UseTermPage.routeName);
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Sair"),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context)
                    .pushReplacementNamed(SignInPage.routeName);
              }),
        ],
      ),
    );
  }

  Widget _showHeader() {
    return UserAccountsDrawerHeader(
      accountName: Text("Vinicius Burza"),
      accountEmail: Text("vi-burza@hotmail.com"),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.red,
        child: Text("V"),
      ),
    );
  }
}
