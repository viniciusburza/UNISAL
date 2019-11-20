import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lost_and_found/models/user.dart';
import 'package:lost_and_found/services/auth.dart';
import 'package:lost_and_found/views/home_page.dart';
import 'package:lost_and_found/views/sign_up_page.dart';
import 'dart:ui' as ui;

import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  static const String routeName = '/signin';

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordVisible = false;

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
                          image: AssetImage("images/background.jpg"),
                          fit: BoxFit.cover))),
              BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 3.5, sigmaY: 3.5),
                child: Container(
                  color: Colors.black.withOpacity(0.4),
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
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            prefixIcon: Icon(Icons.email, color: Colors.purple),
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
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            hintText: 'Senha',
            hintStyle: TextStyle(color: Colors.white),
            prefixIcon: Icon(Icons.lock, color: Colors.purple),
            suffixIcon: IconButton(
                icon: _passwordVisible
                    ? Icon(Icons.visibility, color: Colors.purple)
                    : Icon(Icons.visibility_off, color: Colors.purple),
                onPressed: _toggleVisibility)),
      ),
    );
  }

  Widget _showSignInButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        elevation: 5.0,
        color: Colors.purple,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        child: Text("Login", style: TextStyle(color: Colors.white)),
        onPressed: () async {
          final email = _emailController.text;
          final password = _passwordController.text;
          try {
            _signIn();
          } on PlatformException catch (error) {
            final message = Auth.getExceptionText(error);
            print(message);
          }
        },
      ),
    );
  }

  Future _signIn() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    await Auth.signIn(email, password).then(_onResultSignInSuccess);
  }

  Future _onResultSignInSuccess(String userId) async {
    print('SignIn: $userId');
    await Auth.getUser(userId).first.then(_onResultGetUser);
  }

  Future _onResultGetUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("userId", user.userId);
    await prefs.setString("userName", user.name);
    await prefs.setString("userEmail", user.email);
    Navigator.of(context).pushReplacementNamed(HomePage.routeName);
    
  }

  void _signUp() {
    Navigator.of(context).pushReplacementNamed(SignUpPage.routeName);
  }

  Widget _showSignUpButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: FlatButton(
          child: Text('Não possui uma conta ? Cadastre-se!',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          onPressed: _signUp),
    );
  }
}
