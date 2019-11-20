import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lost_and_found/models/lost_object.dart';
import 'package:lost_and_found/models/lost_object.dart' as prefix0;
import 'package:lost_and_found/widgets/custom_drawer.dart';
import 'package:lost_and_found/models/lost_object.dart';

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
    return StreamBuilder(
      stream: Firestore.instance.collection("lost_objects").snapshots(),
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
              return Center(child: Text("Nenhum objeto perdido!"));
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
