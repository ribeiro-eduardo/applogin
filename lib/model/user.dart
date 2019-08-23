class User {
  String _name;
  String _username;
  String _password;
  String _flaglogado;
  User(this._name, this._username, this._password, this._flaglogado);
  User.map(dynamic obj) {
    this._name = obj['name'];
    this._username = obj['username'];
    this._password = obj['password'];
    this._flaglogado = obj['password'];
  }
  String get name => _name;
  String get username => _username;
  String get password => _password;
  String get flaglogado => _flaglogado;
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = _name;
    map["username"] = _username;
    map["password"] = _password;
    map["flaglogado"] = _flaglogado;
    return map;
  }
  Map<String, dynamic> toMapLogin() {
    var map = new Map<String, dynamic>();
    map["username"] = _username;
    map["password"] = _password;
    return map;
  }
}
