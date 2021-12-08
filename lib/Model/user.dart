import 'package:flutter_email_sender/flutter_email_sender.dart';

class User {
  String?  _name, _nickname, _email, _telefone, _senha, _username,_avatar;

  User({ String? name, String? nickname,String? email, String? telefone, String? senha, String? username, String? avatar}) {
    _name = name;
    _nickname = nickname;
    _email = email;
    _telefone= telefone;
    _senha= senha;
    _username= username;
    _avatar= avatar;
  }
  String? get name => _name;
  String? get nickname => _nickname;
  String? get email => _email;
  String? get telefone => _telefone;
  String? get senha => _senha;
  String? get username => _username;
  String? get avatar => _avatar;
  set Name(String val) => _name = val;
  set Nickname(String val) => _nickname = val;
  set Email(String val) => _email = val;
  set Telefone(String val) => _telefone = val;
  set Senha(String val) => _senha= val;
  set Username(String val) => _username = val;
  set Avatar(String val) => _avatar = val;





}
