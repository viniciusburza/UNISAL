import 'package:flutter/material.dart';
import 'package:lol_do_milhao/views/home_page.dart';
import 'package:lol_do_milhao/views/root_page.dart';
import 'package:lol_do_milhao/views/sign_in_page.dart';
import 'package:lol_do_milhao/views/sign_up_page.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LOL do Milhão',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        RootPage.routeName: (context) => new RootPage(),
        HomePage.routeName: (BuildContext context) => HomePage(),
        SignInPage.routeName: (BuildContext context) => SignInPage(),
        SignUpPage.routeName: (BuildContext context) => SignUpPage(),
      },
      home: MyHomePage(),
      theme: ThemeData(primarySwatch: Colors.deepPurple),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SplashScreen(
          seconds: 5,
          navigateAfterSeconds: RootPage(),
          backgroundColor: Colors.white,
          loaderColor: Color.fromRGBO(170, 128, 52, 1.0),
          gradientBackground: LinearGradient(
            colors: [
              Color.fromRGBO(3, 69, 79, 1.0),
              Color.fromRGBO(37, 160, 168, 1.0)
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        Center(
          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/logo.jpg"),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
