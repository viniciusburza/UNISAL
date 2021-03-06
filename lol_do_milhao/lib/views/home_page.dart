import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:lol_do_milhao/views/quiz_page.dart';
import 'package:lol_do_milhao/widgets/custom_drawer.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int background = Random().nextInt(32);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: CustomDrawer(),
      body: _buildBody(),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text('Home'),
      backgroundColor: Color.fromRGBO(3, 69, 79, 1.0),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            "images/background_${background + 1}.jpg"),
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
                      Center(
                        child: Container(
                          height: 100,
                          width: 300,
                          child: RaisedButton(
                            color: Color.fromRGBO(3, 69, 79, 1.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                side: BorderSide(
                                    color: Color.fromRGBO(170, 128, 52, 1.0),
                                    width: 3.5)),
                            child: Text("Jogar",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25)),
                            onPressed: () {
                              Navigator.of(context).pushReplacementNamed(QuizPage.routeName);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
