import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lost_and_found/models/lost_object.dart';
import 'package:lost_and_found/widgets/custom_drawer.dart';

class FoundObjectDetailPage extends StatefulWidget {
  static const String routeName = '/foundobjectdetailpage';
  @override
  _FoundObjectDetailPageState createState() => _FoundObjectDetailPageState();
}

class _FoundObjectDetailPageState extends State<FoundObjectDetailPage> {
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
      title: Text("Novo objeto encontrado"),
    );
  }

  Widget _buildBody() {
    return WillPopScope(
      onWillPop: _requestPop,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildTitleText(),
            _buildDescriptionText(),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  bool _editing = false;

  Future<bool> _requestPop() {
    if (_editing) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Descartar alterações ?"),
              content: Text("Se sair as alterações seráo perdidas!"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Cancelar"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text("Sair"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  var _titleController = TextEditingController();
  var _descriptionController = TextEditingController();

  Widget _buildTitleText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextFormField(
        controller: _titleController,
        decoration: InputDecoration(labelText: "Titulo"),
      ),
    );
  }

  Widget _buildDescriptionText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextFormField(
        controller: _descriptionController,
        decoration: InputDecoration(labelText: "Descroção"),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        elevation: 5.0,
        color: Colors.purple,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: Text("Salvar", style: TextStyle(color: Colors.white)),
        onPressed: _onSave,
      ),
    );
  }

  Future _onSave() async {
    final lostObject = LostObject(
        title: _titleController.text, description: _descriptionController.text);
    final result = await Firestore.instance
        .collection("lost_objects")
        .add(lostObject.toMap());

    print("Add ${result.documentID}");
    Navigator.of(context).pop();
  }
}
