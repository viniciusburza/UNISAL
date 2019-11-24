import 'package:flutter/material.dart';
import 'package:lol_do_milhao/models/user.dart';
import 'package:lol_do_milhao/services/auth.dart';
import 'package:lol_do_milhao/utils/common.dart';
import 'package:lol_do_milhao/views/home_page.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  User _user = new User();

  @override
  void initState() {
    Auth.getUserLocal().then(_onGetUserLocalSuccess);
    super.initState();
  }

  void _onGetUserLocalSuccess(User user) {
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          _showHeader(),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacementNamed(HomePage.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sair'),
            onTap: () async {
              await Common.showQuitDialog(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _showHeader() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(color: Color.fromRGBO(3, 69, 79, 1.0)),
      accountName: Text(_user?.name ?? ""),
      accountEmail: Text(_user?.email ?? ""),
      currentAccountPicture: CircleAvatar(
          child: Text(_user?.getInitials() ?? ''),
          backgroundColor: Color.fromRGBO(170, 128, 52, 1.0)),
    );
  }
}
