import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lost_and_found/views/home_page.dart';
import 'package:lost_and_found/views/sign_in_page.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _showWaitingContainer();
          } else {
            if (snapshot.hasData) {
              return HomePage();
            } else {
              return SignInPage();
            }
          }
        });
  }

  Widget _showWaitingContainer() {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.red,
        ),
      ),
    );
  }
}
