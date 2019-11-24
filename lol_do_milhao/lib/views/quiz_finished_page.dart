import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:lol_do_milhao/views/home_page.dart';
import 'package:lol_do_milhao/widgets/custom_drawer.dart';

class QuizFinishedPage extends StatefulWidget {
  static const String routeName = '/quizfinished';
  @override
  _QuizFinishedPageState createState() => _QuizFinishedPageState();
}

class _QuizFinishedPageState extends State<QuizFinishedPage> {
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
      title: Text('Fim do Quiz!'),
      centerTitle: true,
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
                      _buildInformation(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7.0),
                        child: Center(
                          child: Container(
                            height: 50,
                            width: 300,
                            child: RaisedButton(
                              color: Color.fromRGBO(3, 69, 79, 1.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  side: BorderSide(
                                      color: Color.fromRGBO(170, 128, 52, 1.0),
                                      width: 3.5)),
                              child: Text("Finalizar!",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacementNamed(HomePage.routeName);
                              },
                            ),
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

Widget _buildInformation() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: Container(
      height: 300,
      width: 300,
      child: Card(
        color: Color.fromRGBO(3, 69, 79, 1.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
            side: BorderSide(
                color: Color.fromRGBO(170, 128, 52, 1.0), width: 3.5)),
        child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Você acertou 5/15 perguntas",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    )),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
