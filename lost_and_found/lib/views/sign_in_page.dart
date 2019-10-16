import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lost_and_found/services/auth.dart';
import 'package:lost_and_found/views/sign_up_page.dart';

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
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/background.jpg"), fit: BoxFit.cover)),
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
    );
  }

  Widget _showEmailTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.email, color: Colors.deepPurple),
          hintText: 'Email',
        ),
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
        decoration: InputDecoration(
            hintText: 'Senha',
            prefixIcon: Icon(Icons.lock, color: Colors.deepPurple),
            suffixIcon: IconButton(
                icon: _passwordVisible
                    ? Icon(Icons.visibility, color: Colors.deepPurple)
                    : Icon(Icons.visibility_off, color: Colors.deepPurple),
                onPressed: _toggleVisibility)),
      ),
    );
  }

  Widget _showSignInButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        color: Colors.purple,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        child: Text("Login", style: TextStyle(color: Colors.white)),
        onPressed: () async {
          final email = _emailController.text;
          final password = _passwordController.text;
          try {
            await Auth.signIn(email, password).then((userId) {
              print('SignIn: $userId');
            });
          } on PlatformException catch (error) {
            final message = Auth.getExceptionText(error);
            print(message);
          }
        },
      ),
    );
  }

  void _signUp() {
    Navigator.of(context).pushReplacementNamed(SignUpPage.routeName);
  }

  Widget _showSignUpButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: FlatButton(child: Text('Não possui uma conta ? Cadastre-se!'), onPressed: _signUp),
    );
  }
}
