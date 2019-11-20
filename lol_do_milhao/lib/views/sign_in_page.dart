import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lol_do_milhao/views/home_page.dart';
import 'dart:ui' as ui;
import 'package:lol_do_milhao/views/sign_up_page.dart';

class SignInPage extends StatefulWidget {
  static const String routeName = '/signin';

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordVisible = false;
  int background = Random(1).nextInt(33-1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/background_$background"),
                          fit: BoxFit.cover))),
              BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                child: Container(
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
              Container(
                child: Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _showEmailTextField(),
                        _showPasswordTextField(),
                        _showSignInButton(),
                        _showSignUpButton(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _showEmailTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
          color: Colors.white,
          decorationColor: Colors.white,
        ),
        decoration: InputDecoration(
            errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1.25)),
            focusedErrorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1.25)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromRGBO(170, 128, 52, 1.0), width: 1.25)),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1.25)),
            prefixIcon:
                Icon(Icons.email, color: Color.fromRGBO(37, 160, 168, 1.0)),
            hintText: 'Email',
            hintStyle: TextStyle(color: Colors.white)),
      ),
    );
  }

  void _toggleVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  Widget _showPasswordTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextField(
        controller: _passwordController,
        obscureText: _passwordVisible,
        style: TextStyle(
          color: Colors.white,
          decorationColor: Colors.white,
        ),
        decoration: InputDecoration(
            errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1.25)),
            focusedErrorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1.25)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromRGBO(170, 128, 52, 1.0), width: 1.25)),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1.25)),
            hintText: 'Senha',
            hintStyle: TextStyle(color: Colors.white),
            prefixIcon: Icon(
              Icons.lock,
              color: Color.fromRGBO(37, 160, 168, 1.0),
            ),
            suffixIcon: IconButton(
                icon: _passwordVisible
                    ? Icon(Icons.visibility,
                        color: Color.fromRGBO(37, 160, 168, 1.0))
                    : Icon(Icons.visibility_off,
                        color: Color.fromRGBO(37, 160, 168, 1.0)),
                onPressed: _toggleVisibility)),
      ),
    );
  }

  Widget _showSignInButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: RaisedButton(
          elevation: 5.0,
          color: Color.fromRGBO(37, 160, 168, 1.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          child: Text("Login", style: TextStyle(color: Colors.white)),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(HomePage.routeName);
          }),
    );
  }

  Widget _showSignUpButton() {
    return FlatButton(
        child: Text('Não possui uma conta ? Cadastre-se!',
            style: TextStyle(color: Colors.white)),
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(SignUpPage.routeName);
        });
  }
}
