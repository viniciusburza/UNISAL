import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:lol_do_milhao/views/quiz_finished_page.dart';
import 'package:lol_do_milhao/widgets/custom_drawer.dart';

class QuizPage extends StatefulWidget {
  static const String routeName = '/quiz';
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
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
      title: Text('Pergunta 1/15'),
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
                      _buildQuestion(),
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
                              child: Text("Resposta 1",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                              onPressed: () {
                                Navigator.of(context).pushReplacementNamed(
                                    QuizFinishedPage.routeName);
                              },
                            ),
                          ),
                        ),
                      ),
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
                              child: Text("Resposta 2",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                              onPressed: () {
                                Navigator.of(context).pushReplacementNamed(
                                    QuizFinishedPage.routeName);
                              },
                            ),
                          ),
                        ),
                      ),
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
                              child: Text("Resposta 3",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                              onPressed: () {
                                Navigator.of(context).pushReplacementNamed(
                                    QuizFinishedPage.routeName);
                              },
                            ),
                          ),
                        ),
                      ),
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
                              child: Text("Resposta 4",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                              onPressed: () {
                                Navigator.of(context).pushReplacementNamed(
                                    QuizFinishedPage.routeName);
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

Widget _buildQuestion() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: Container(
      height: 200,
      width: 300,
      child: Card(
        color: Color.fromRGBO(3, 69, 79, 1.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
            side: BorderSide(
                color: Color.fromRGBO(170, 128, 52, 1.0), width: 3.5)),
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(20.0),
            child: Text("Pergunta",
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
        ),
      ),
    ),
  );
}
