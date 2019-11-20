import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'package:lol_do_milhao/views/sign_in_page.dart';

class SignUpPage extends StatefulWidget {
  static const String routeName = '/signup';

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

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
                          image: AssetImage("images/background_sign_up.jpg"),
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
                        _showUsernameTextField(),
                        _showEmailTextField(),
                        _showPasswordTextField(),
                        _showConfirmPasswordTextField(),
                        _showSignUpButton(),
                        _showSignInButton(),
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

  Widget _showUsernameTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextField(
        controller: _usernameController,
        keyboardType: TextInputType.text,
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
                Icon(Icons.person, color: Color.fromRGBO(37, 160, 168, 1.0)),
            hintText: 'Usuário',
            hintStyle: TextStyle(color: Colors.white)),
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

  Widget _showPasswordTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextField(
        controller: _passwordController,
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
        ),
      ),
    );
  }

  Widget _showConfirmPasswordTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextField(
        controller: _confirmPasswordController,
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
          hintText: 'Confirmar Senha',
          hintStyle: TextStyle(color: Colors.white),
          prefixIcon: Icon(
            Icons.lock,
            color: Color.fromRGBO(37, 160, 168, 1.0),
          ),
        ),
      ),
    );
  }

  Widget _showSignUpButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: RaisedButton(
          elevation: 5.0,
          color: Color.fromRGBO(37, 160, 168, 1.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          child: Text("Cadastrar", style: TextStyle(color: Colors.white)),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(SignInPage.routeName);
          }),
    );
  }

  Widget _showSignInButton() {
    return FlatButton(
        child: Text('Já possui uma conta ? Acesse Aqui!',
            style: TextStyle(color: Colors.white)),
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(SignInPage.routeName);
        });
  }
}
