import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lol_do_milhao/services/auth.dart';
import 'package:lol_do_milhao/views/home_page.dart';
import 'package:lol_do_milhao/views/root_page.dart';
import 'package:lol_do_milhao/views/sign_in_page.dart';

class Common {
  static Future setPortraitOrientation() async {
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  static Future<bool> showQuitDialog(context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Sair"),
          content: Text("Você realmente deseja sair do aplicativo?"),
          actions: <Widget>[
            FlatButton(
              child: Text("SIM"),
              onPressed: () {
                Auth.signOut();
                Navigator.pushReplacementNamed(context, SignInPage.routeName);
              },
            ),
            FlatButton(
              child: Text("NÃO"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    return Future.value(false);
  }

  static Widget progressContainer() {
    return Center(child: CircularProgressIndicator());
  }

  static Widget errorContainer({String error}) {
    return Center(child: Text(error));
  }

  static Widget emptyContainer({String message}) {
    return Center(child: Text(message));
  }
}