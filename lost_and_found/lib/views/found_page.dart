import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lost_and_found/models/lost_object.dart';
import 'package:lost_and_found/views/found_object_detail_page.dart';
import 'package:lost_and_found/widgets/custom_drawer.dart';

class FoundPage extends StatefulWidget {
  static const String routeName = '/foundpage';
  @override
  _FoundPageState createState() => _FoundPageState();
}

class _FoundPageState extends State<FoundPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: CustomDrawer(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton.extended(
      label: Text("Achei Algo!"),
      icon: Icon(Icons.add),
      onPressed: _foundObject,
    );
  }

  void _foundObject() {
    Navigator.pushNamed(context, FoundObjectDetailPage.routeName);
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text("Achados"),
    );
  }

  Widget _buildBody() {
    return StreamBuilder(
      stream: Firestore.instance
          .collection("lost_objects")
          .where("finderUserId", isEqualTo: "p43ThoPyZ5dhxS75bkfhcH8u0lt2")
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasError)
              return Center(child: Text(snapshot.error.toString()));
            if (snapshot.data.documents.length == 0)
              return Center(child: Text("Nenhum objeto encontrado!"));
            return ListView(
              children: snapshot.data.documents.map(_buildCard).toList(),
            );
        }
        return null;
      },
    );
  }

  Widget _buildCard(DocumentSnapshot document) {
    final lostObject = LostObject.fromDocument(document);
    return ListTile(
      title: Text(lostObject.title),
      subtitle: Text(lostObject.description),
      leading: CircleAvatar(
        child: Text(lostObject.title.toUpperCase()[0]),
      ),
    );
  }
}
