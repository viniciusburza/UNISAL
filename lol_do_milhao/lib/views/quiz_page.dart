import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:lol_do_milhao/models/questions.dart';
import 'package:lol_do_milhao/utils/service.dart';
import 'package:lol_do_milhao/views/home_page.dart';
import 'package:lol_do_milhao/widgets/custom_drawer.dart';

class QuizPage extends StatefulWidget {
  static const String routeName = '/quiz';
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int background = Random().nextInt(32);
  int correctAnswers;
  List<Question> questions = [];
  int currentQuestion = 0;
  bool loading;
  bool endQuiz = false;

  @override
  void initState() {
    super.initState();
    loading = true;
    correctAnswers = 0;
    getAllQuestions();
  }

  void getAllQuestions() async {
    questions = await Service.getAllQuestions();
    questions.shuffle();
    currentQuestion = 0;
    print(questions.length);
    setState(() {
      loading = false;
    });
  }

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
      title: endQuiz
          ? Text("Fim do Quiz!",
              style: TextStyle(color: Colors.white, fontSize: 20))
          : Text(
              'Pergunta: ${currentQuestion + 1} / ${questions?.length ?? 0}'),
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
            loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : _buildQuestionContainer(),
          ],
        ),
      ],
    );
  }

  Container _buildQuestionContainer() {
    return Container(
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: _currentScreen(),
        ),
      ),
    );
  }

  Widget _currentScreen() {
    return endQuiz
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[_buildInformation(), _buildFinal()],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildQuestion(),
              _buildAnswer(answer: questions[currentQuestion].answer1),
              _buildAnswer(answer: questions[currentQuestion].answer2),
              _buildAnswer(answer: questions[currentQuestion].answer3),
              _buildAnswer(answer: questions[currentQuestion].answer4),
            ],
          );
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
              child: Text("${questions[currentQuestion].question}",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnswer({String answer}) {
    return Padding(
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
                    color: Color.fromRGBO(170, 128, 52, 1.0), width: 3.5)),
            child: Text("$answer",
                style: TextStyle(color: Colors.white, fontSize: 20)),
            onPressed: () {
              if (currentQuestion == questions.length - 1) {
                if (answer == questions[currentQuestion].correct) {
                  setState(() {
                    correctAnswers++;
                  });
                }
                setState(() {
                  endQuiz = true;
                });
              } else {
                setState(() {
                  if (answer == questions[currentQuestion].correct) {
                    correctAnswers++;
                  }
                  currentQuestion++;
                });
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFinal() {
    return Padding(
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
                    color: Color.fromRGBO(170, 128, 52, 1.0), width: 3.5)),
            child: Text("Finalizar!",
                style: TextStyle(color: Colors.white, fontSize: 20)),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(HomePage.routeName);
            },
          ),
        ),
      ),
    );
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
                  child: Text(
                      "Você acertou $correctAnswers de ${questions.length} perguntas!",
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
}
