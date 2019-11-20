import 'package:flutter/material.dart';
import 'package:lost_and_found/models/user.dart';
import 'package:lost_and_found/services/auth.dart';
import 'package:lost_and_found/views/sign_in_page.dart';

class SignUpPage extends StatefulWidget {
  static const String routeName = '/signup';

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _showNameTextField(),
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
    );
  }

  Widget _showNameTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextField(
        controller: _nameController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.black),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1.25)),
          prefixIcon: Icon(Icons.person, color: Colors.purple),
          hintText: 'Nome',
        ),
      ),
    );
  }

  Widget _showEmailTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.black),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1.25)),
          prefixIcon: Icon(Icons.email, color: Colors.purple),
          hintText: 'Email',
        ),
      ),
    );
  }

  Widget _showPasswordTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextField(
        controller: _passwordController,
        obscureText: true,
        decoration: InputDecoration(
            hintStyle: TextStyle(color: Colors.black),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1.25)),
            hintText: 'Senha',
            prefixIcon: Icon(Icons.lock, color: Colors.purple)),
      ),
    );
  }

  Widget _showConfirmPasswordTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextField(
        controller: _confirmPasswordController,
        obscureText: true,
        decoration: InputDecoration(
            hintStyle: TextStyle(color: Colors.black),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1.25)),
            hintText: 'Confirmar Senha',
            prefixIcon: Icon(Icons.lock, color: Colors.purple)),
      ),
    );
  }

  void _signUp() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    await Auth.signUp(email, password).then(_onResultSignUpSuccess);
  }

  void _onResultSignUpSuccess(String userId) {
    final email = _emailController.text;
    final name = _nameController.text;
    final user = User(name: name, email: email, userId: userId);

    Auth.addUser(user);
  }

  Widget _showSignUpButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: RaisedButton(
        child: Text('Registrar', style: TextStyle(color: Colors.white)),
        onPressed: _signUp,
        color: Colors.purple,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
      ),
    );
  }

  void _signIn() {
    Navigator.of(context).pushReplacementNamed(SignInPage.routeName);
  }

  Widget _showSignInButton() {
    return FlatButton(
        child: Text('Já possui uma conta ? Acesse Aqui!',
            style: TextStyle(fontWeight: FontWeight.bold)),
        onPressed: _signIn);
  }
}
