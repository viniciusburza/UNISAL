import 'package:flushbar/flushbar.dart';
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
  final _formKey = new GlobalKey<FormState>();

  final _nameController = new TextEditingController();
  final _emailController = new TextEditingController();
  final _passwordController = new TextEditingController();
  final _confirmPasswordController = new TextEditingController();

  final _nameFocusNode = new FocusNode();
  final _emailFocusNode = new FocusNode();
  final _passwordFocusNode = new FocusNode();
  final _confirmPasswordFocusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _showNameTextField(),
          _showEmailTextField(),
          _showPasswordTextField(),
          _showConfirmPasswordTextField(),
          _showSignUpButton(),
          _showSignInButton(),
        ],
      ),
    );
  }

  Widget _showNameTextField() {
    return TextFormField(
      controller: _nameController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: 'Nome',
        hintStyle: TextStyle(color: Colors.black),
        prefixIcon: Icon(Icons.person, color: Colors.purple),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.25)),
      ),
      textInputAction: TextInputAction.next,
      autofocus: true,
      focusNode: _nameFocusNode,
      onEditingComplete: () =>
          FocusScope.of(context).requestFocus(_emailFocusNode),
    );
  }

  Widget _showEmailTextField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Email',
        prefixIcon: Icon(Icons.email, color: Colors.purple),
        hintStyle: TextStyle(color: Colors.black),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.25)),
      ),
      textInputAction: TextInputAction.next,
      focusNode: _emailFocusNode,
      onEditingComplete: () =>
          FocusScope.of(context).requestFocus(_passwordFocusNode),
    );
  }

  Widget _showPasswordTextField() {
    return TextFormField(
      controller: _passwordController,
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Senha',
        prefixIcon: Icon(Icons.vpn_key, color: Colors.purple),
        hintStyle: TextStyle(color: Colors.black),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.25)),
      ),
      textInputAction: TextInputAction.next,
      focusNode: _passwordFocusNode,
      onEditingComplete: () =>
          FocusScope.of(context).requestFocus(_confirmPasswordFocusNode),
    );
  }

  Widget _showConfirmPasswordTextField() {
    return TextFormField(
      controller: _confirmPasswordController,
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Confirmar senha',
        prefixIcon: Icon(Icons.vpn_key, color: Colors.purple),
        hintStyle: TextStyle(color: Colors.black),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.25)),
      ),
      focusNode: _confirmPasswordFocusNode,
    );
  }

  Future _signUp() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    await Auth.signUp(email, password)
        .then(_onResultSignUpSuccess)
        .catchError((error) {
      Flushbar(
        title: 'Erro',
        message: error.toString(),
        duration: Duration(seconds: 3),
      )..show(context);
    });
  }

  void _onResultSignUpSuccess(String userId) {
    final email = _emailController.text;
    final name = _nameController.text;
    final user = User(userId: userId, name: name, email: email);
    Auth.addUser(user).then(_onResultAddUser);
  }

  void _onResultAddUser(result) {
    Flushbar(
      title: 'Novo usuário',
      message: 'Usuário registrado com sucesso!',
      duration: Duration(seconds: 2),
    )..show(context);
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
    Navigator.pushReplacementNamed(context, SignInPage.routeName);
  }

  Widget _showSignInButton() {
    return FlatButton(
        child: Text('Já possui uma conta ? Acesse Aqui!',
            style: TextStyle(fontWeight: FontWeight.bold)),
        onPressed: _signIn);
  }
}
