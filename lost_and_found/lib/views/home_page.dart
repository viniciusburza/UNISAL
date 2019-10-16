import 'package:flutter/material.dart';
import 'package:lost_and_found/widgets/custom_drawer.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      title: Text("Home"),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Text("Bem Vindo!"),
    );
  }
}
