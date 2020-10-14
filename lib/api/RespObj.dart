import 'package:shared_preferences/shared_preferences.dart';

class RespObj{
  bool _status,auth;
  String msg,token,id;
  int length;
  dynamic data;

  RespObj(this._status, {this.msg, this.data,this.token,this.auth,this.id,this.length}){
    if(token!=null){
      print("");
      _storeToken();
    }
  }
  _storeToken() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    prefs.setString('userId', id);
    print("Token Saved");
    prefs.commit();
  }

  factory RespObj.fromJSON(Map<dynamic, dynamic> json){
    try{
      return RespObj(json['status'], msg: json['msg'],data: json['data'],token: json['token'],id: json['id'],length: json['length']);
    }catch (e){
      print(e);
      return null;
    }
  }

  bool get status => _status;

}