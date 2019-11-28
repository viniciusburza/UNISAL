import 'dart:ui' as ui;
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:lost_and_found/services/auth.dart';
import 'package:lost_and_found/views/home_page.dart';
import 'package:lost_and_found/views/sign_up.page.dart';


class SignInPage extends StatefulWidget {
  static const String routeName = '/signin';

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = new TextEditingController();
  final _passwordController = new TextEditingController();
  bool _obscurePassword = true;

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
              Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20.0),
                  child: _buildForm(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _showEmailTextField(),
        _showPasswordTextField(),
        _showSignInButton(),
        _showSignUpButton(),
      ],
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

  void _toggleObscurePassword() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  Widget _showPasswordTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextField(
        controller: _passwordController,
        obscureText: _obscurePassword,
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
                icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility),
                onPressed: _toggleObscurePassword)),
      ),
    );
  }

  Future<void> _signIn() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    await Auth.signIn(email, password)
        .then(_onSignInSuccess)
        .catchError((error) {
      print('Caught error: $error');
      Flushbar(
        title: 'Erro',
        message: error.toString(),
        duration: Duration(seconds: 3),
      )..show(context);
    });
  }

  Future _onSignInSuccess(String userId) async {
    final user = await Auth.getUser(userId);
    await Auth.storeUserLocal(user);
    Navigator.pushNamed(context, HomePage.routeName);
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
          _signIn();
        },
      ),
    );
  }

  void _signUp() {
    Navigator.pushReplacementNamed(context, SignUpPage.routeName);
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
