import 'dart:async';
import 'database_helper.dart';
import '../model/user.dart';
import '../util/network_util.dart';

class RestData {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "";
  static final LOGIN_URL = BASE_URL + "/";

  Future<User> login(String username, String password) async {
    String flaglogado = "logado";
    // aqui vamos simular a conexão com internet fazendo um select no bd local p verificar se user ja foi cadastrado

    var user = new User(null, username, password, null);
    var db = new DatabaseHelper();
    var userRetorno = new User(null, null, null, null);
    userRetorno = await db.selectUser(user);
    
    if (userRetorno != null) {
      flaglogado = "logado";
      return new Future.value(new User(null, username, password, flaglogado));
    }
    else {
      flaglogado = "nao";
      return new Future.value(new User(null, username, password, flaglogado));
    }
  }
}