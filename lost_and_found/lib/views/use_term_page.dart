import 'package:flutter/material.dart';
import 'package:lost_and_found/widgets/custom_drawer.dart';

class UseTermPage extends StatefulWidget {
  static const String routeName = '/userterm';
  @override
  _UseTermPageState createState() => _UseTermPageState();
}

class _UseTermPageState extends State<UseTermPage> {
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
      title: Text("Termos de Uso"),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Text("Termos de Uso!"),
    );
  }
}
