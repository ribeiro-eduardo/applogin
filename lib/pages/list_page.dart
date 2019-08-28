import 'package:flutter/material.dart';
import '../data/database_helper.dart';
import '../model/user.dart';
import 'dart:async';
import 'dart:convert';


class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<User> usuariosList = new List();
  DatabaseHelper db = new DatabaseHelper();

  @override
  void initState() {
    super.initState();

    db.selectAll().then((usuarios) {
      setState((){
        usuarios.forEach((usuario) {
          usuariosList.add(User.fromMap(usuario));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Todos os Usuários'),
          centerTitle: true,
          backgroundColor: Colors.blueAccent[700],
        ),
        body: Center(
          child: ListView.builder(
              itemCount: usuariosList.length,
              padding: const EdgeInsets.all(5.0),
              itemBuilder: (context, position) {
                return Column(
                  children: <Widget>[
                    Divider(height: 5.0),
                    ListTile(
                      title: Text(
                          '${usuariosList[position].name}',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.deepOrangeAccent,
                          ),
                        ),
                      subtitle: Text(
                        '${usuariosList[position].username}',
                        style: new TextStyle(
                          fontSize: 18.0,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      
                      leading: Column(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.person),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  // return object of type Dialog
                                  return AlertDialog(
                                    title: new Text("Foto de ${usuariosList[position].name}"),
                                    content: new Text("Aqui apareceria a imagem do usuário"),
                                    actions: <Widget>[
                                      // usually buttons at the bottom of the dialog
                                      new FlatButton(
                                        child: new Text("Fechar"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete), 
                        onPressed: () => showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  // return object of type Dialog
                                  return AlertDialog(
                                    title: new Text("Deseja remover o usuário ${usuariosList[position].name}?"),
                                    content: new Text("Essa ação é irreversível!"),
                                    actions: <Widget>[
                                      // usually buttons at the bottom of the dialog
                                      new FlatButton(
                                        child: new Text("Sim, remover"),
                                        onPressed: () {
                                          _deleteUser(context, usuariosList[position], position);
                                          Navigator.of(context).pop();
                                        }
                                      ),
                                      new FlatButton(
                                        child: new Text("Cancelar"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              ),
                      ),
                      onTap: () => print("tapppp"),
                      
                    ),
                  ],
                  
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => Navigator.of(context).pushNamed("/register"),
        ),
      ),
    );
  }

void _deleteUser(BuildContext context, User usuario, int index) async {
    db.deleteUser(usuario.id).then((usuarios) {
      setState(() {
        usuariosList.removeAt(index);
      });
    });
    }
  
}

