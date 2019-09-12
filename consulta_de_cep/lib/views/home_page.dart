import 'package:consulta_de_cep/services/via_cep.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:consulta_de_cep/models/result_cep.dart';
import 'package:share/share.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ResultCep result;
  bool _loading = false;
  var _keyForm = GlobalKey<FormState>();
  TextEditingController _cepController = TextEditingController();
  TextEditingController _logradouroController = TextEditingController();
  TextEditingController _complementoController = TextEditingController();
  TextEditingController _bairroController = TextEditingController();
  TextEditingController _localidadeController = TextEditingController();
  TextEditingController _ufController = TextEditingController();
  TextEditingController _unidadeController = TextEditingController();
  TextEditingController _ibgeController = TextEditingController();
  TextEditingController _giaController = TextEditingController();

  void _changeTheme() {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consulta de CEP"),
        backgroundColor: Colors.yellow,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                if (result.cep != null && _keyForm.currentState.validate()) {
                  Share.share(result.cep);
                }
              }),
          IconButton(
            icon: Icon(Icons.lightbulb_outline),
            onPressed: _changeTheme,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: _buildForm(),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _keyForm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildTextFormField(),
          _buildRaisedButton(),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              elevation: 5,
              child: Container(
                margin: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    _buildAnswerTextFormField(
                        "Logradouro", _logradouroController),
                    _buildAnswerTextFormField(
                        "Complemento", _complementoController),
                    _buildAnswerTextFormField("Bairro", _bairroController),
                    Row(
                      children: <Widget>[
                        Flexible(
                          flex: 4,
                          child: _buildAnswerTextFormField(
                              "Localidade", _localidadeController),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(),
                        ),
                        Flexible(
                          flex: 2,
                          child: _buildAnswerTextFormField("UF", _ufController),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Flexible(
                          flex: 4,
                          child: _buildAnswerTextFormField(
                              "Unidade", _unidadeController),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(),
                        ),
                        Flexible(
                          flex: 3,
                          child:
                              _buildAnswerTextFormField("GIA", _giaController),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(),
                        ),
                        Flexible(
                          flex: 3,
                          child: _buildAnswerTextFormField(
                              "IBGE", _ibgeController),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRaisedButton() {
    return RaisedButton(
      child: _loading
          ? _buildCircularProgressIndicatorInRaisedButton()
          : Text("Consultar"),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.yellow,
      onPressed: () async {
        if (_keyForm.currentState.validate()) {
          setState(() {
            _loading = true;
          });
          result = await ViaCep.fetchCep(cep: _cepController.text);
          setState(() {
            _logradouroController.text = result.logradouro.toString();
            _complementoController.text = result.complemento.toString();
            _bairroController.text = result.bairro.toString();
            _localidadeController.text = result.localidade.toString();
            _ufController.text = result.uf.toString();
            _unidadeController.text = result.unidade.toString();
            _ibgeController.text = result.ibge.toString();
            _giaController.text = result.gia.toString();
          });
        }
        setState(() {
          _loading = false;
        });
      },
    );
  }

  Container _buildCircularProgressIndicatorInRaisedButton() {
    return Container(
      height: 15.0,
      width: 15.0,
      child: CircularProgressIndicator(
        backgroundColor: Colors.black,
      ),
    );
  }

  Widget _buildTextFormField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        controller: _cepController,
        decoration: InputDecoration(
          labelText: "Digite um CEP",
          labelStyle: TextStyle(fontSize: 18, color: Colors.black),
        ),
        validator: (text) {
          return text.length != 8 ? "Digite um CEP válido" : null;
        },
      ),
    );
  }

  Widget _buildAnswerTextFormField(
      String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),
    );
  }
}
