import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';

class HomePage extends StatelessWidget {

  BuildContext context;

  void _listAll() {
    Navigator.of(context).pushNamed("/list");
  }

  @override
  Widget build(BuildContext ctx) {
     context = ctx;
     var listAllBtn = new RaisedButton(
      padding: const EdgeInsets.all(10.0),
      onPressed: _listAll,
      child: new Text("Listar Todos os Usuários"),
      color: Colors.green,
    );
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home"),
      ),
      body: new Center(
        child: listAllBtn,
      ),
    );
  }
}