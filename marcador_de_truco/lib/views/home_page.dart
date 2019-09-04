//! home_page.dart

import 'package:flutter/material.dart';
import 'package:marcador_de_truco/models/player.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _playerOne = Player(name: "Nós", score: 0, victories: 0, id: 0);
  var _playerTwo = Player(name: "Eles", score: 0, victories: 0, id: 1);

  void maoFerro(Player player, Player player2) {
    if (player.score == player2.score) {
      if (player.score == 11) {
        _showDialog(
            title: 'Mão de Ferro',
            message:
                'Todos os jogadores devem receber as cartas “cobertas”, isto é, viradas para baixo, e deverão jogar assim. Quem vencer a mão, vence a partida',
            m1: '',
            m2: '',
            m3: 'Ok');
      }
    }
  }

  void _resetScore(Player player, bool resetVictories) {
    setState(() {
      player.score = 0;
      player.victories = resetVictories ? 0 : player.victories;
      _textFieldController.clear();
    });
  }

  void _resetPlayers(bool resetVictories) {
    _resetScore(_playerOne, resetVictories);
    _resetScore(_playerTwo, resetVictories);
    setState(() {
      if (resetVictories == true) {
        _playerOne.name = "NÓS";
        _playerTwo.name = "ELES";
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _resetPlayers(true);
  }

  TextEditingController _textFieldController = TextEditingController();
  _displayDialog(Player player) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Trocar nome:'),
            content: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Digite novo nome!"),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancelar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Trocar'),
                onPressed: () {
                  setState(() {
                    if (player.id == 0 &&
                        _textFieldController.text.isNotEmpty &&
                        _textFieldController.text.length <= 12) {
                      _playerOne.name = _textFieldController.text;
                      _textFieldController.clear();
                    } else if (player.id == 1 &&
                        _textFieldController.text.isNotEmpty &&
                        _textFieldController.text.length <= 12) {
                      _playerTwo.name = _textFieldController.text;
                      _textFieldController.clear();
                    } else {
                      _textFieldController.clear();
                    }
                  });
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

//* #########################
//* Mostra o nome do Jogador
//* #########################

  Widget _showPlayerName(Player player) {
    return GestureDetector(
      onTap: () {
        _displayDialog(player);
      },
      child: Text(
        player.name.toUpperCase(),
        style: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }

//* #########################
//*    Mostra as vitórias
//* #########################

  Widget _showPlayerVictories(int victories) {
    return Text(
      "Vitórias ( $victories )",
      style: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.w300,
      ),
    );
  }

//* #########################
//*      Mostra o placar
//* #########################

  Widget _showPlayerScore(int score) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 52.0),
      child: Text(
        "$score",
        style: TextStyle(fontSize: 120.0),
      ),
    );
  }

//* #########################
//*       Botão Redondo
//* #########################

  Widget _buildRoundedButton(
      {String label, Color color, Function onTap, double size = 52.0}) {
    return GestureDetector(
      onTap: onTap,
      child: ClipOval(
        child: Container(
          height: size,
          width: size,
          color: color,
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

//* #########################
//*  Linha que mostra Botão
//* #########################

  Widget _showScoreButtons(Player player) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _buildRoundedButton(
            label: "-1",
            color: Colors.white.withOpacity(0.2),
            onTap: () {
              if (player.score != 0) {
                setState(() {
                  player.score--;
                });
              }
            }),
        _buildRoundedButton(
            label: "+1",
            color: Colors.redAccent,
            onTap: () {
              if (player.score < 12) {
                setState(() {
                  player.score++;
                });
              }

              if (player.score == 12) {
                _showDialog(
                  title: 'Fim de Jogo',
                  message: '${player.name} ganhou!',
                  m1: 'Voltar Mão',
                  m2: '',
                  m3: 'Nova Partida',
                  f1: () {
                    setState(() {
                      player.score--;
                    });
                    maoFerro(_playerOne, _playerTwo);
                  },
                  f3: () {
                    setState(() {
                      player.victories++;
                    });
                    _resetPlayers(false);
                  },
                );
              }
              maoFerro(_playerOne, _playerTwo);
            }),
      ],
    );
  }

//* #########################
//*          AppBar
//* #########################

  Widget _buildAppBar() {
    return AppBar(
      title: Text('Marcador de Truco'),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            _showDialog(
                title: 'Menu',
                message: 'Escolha uma opção',
                m1: 'Cancelar',
                m2: 'Reiniciar Jogo',
                m3: 'Nova Partida',
                f3: () {
                  _resetPlayers(false);
                },
                f2: () {
                  _resetPlayers(true);
                });
          },
          icon: Icon(Icons.refresh),
        )
      ],
    );
  }

//? #########################
//?      Chama o App
//? #########################

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBoardPlayers(),
    );
  }

//* #########################
//* Desenha os dois lados player
//* #########################

  Widget _buildBoardPlayers() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _buildBoardPlayer(_playerOne),
        _buildBoardPlayer(_playerTwo),
      ],
    );
  }

//* #########################
//*    Desenha um player
//* #########################

  Widget _buildBoardPlayer(Player player) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _showPlayerName(player),
          _showPlayerScore(player.score),
          _showPlayerVictories(player.victories),
          _showScoreButtons(player),
        ],
      ),
    );
  }

//* #########################
//*    PopUp Dialogo
//* #########################

  void _showDialog({
    String title,
    String message,
    m1,
    m2,
    m3,
    Function f1,
    Function f2,
    Function f3,
  }) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title ?? ""),
            content: Text(message ?? ""),
            actions: <Widget>[
              m1 != ''
                  ? FlatButton(
                      child: Text(m1),
                      onPressed: () {
                        Navigator.of(context).pop();
                        if (f1 != null) f1();
                      },
                    )
                  : Container(),
              m2 != ''
                  ? FlatButton(
                      child: Text(m2),
                      onPressed: () {
                        Navigator.of(context).pop();
                        if (f2 != null) f2();
                      },
                    )
                  : Container(),
              m3 != ''
                  ? FlatButton(
                      child: Text(m3),
                      onPressed: () {
                        Navigator.of(context).pop();
                        if (f3 != null) f3();
                      },
                    )
                  : Container(),
            ],
          );
        });
  }
}
