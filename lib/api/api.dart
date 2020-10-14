import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' ;
import  '../model/RespObj.dart';

class ApiUtils {
  static ApiUtils _instance  = new ApiUtils.internal();
  ApiUtils.internal();

  factory ApiUtils() => _instance;
  static final baseUrl = "http://3.7.215.107:4000/";

  Future<RespObj> getData(String route,{String header}) async{
    Map<String, String> mHeaders = {"Content-type": "application/json","token":header};
    try{
      Response response = await get(baseUrl+route,headers: mHeaders);
      print(json.decode(response.body));
      if(response.statusCode==200){
        print(json.decode(response.body));
        return RespObj.fromJSON(json.decode(response.body));
      }else{
        return RespObj(false,msg: response.body);
      }
    }catch(ex){
      print("Exception e :"+ex.toString());
      return RespObj(false,msg: 'Server Unavailable');
    }

  }

  Future<RespObj> deleteData(String route,{String header}) async{
    Map<String, String> mHeaders = {"Content-type": "application/json","token":header};
    try{
      Response response = await delete(baseUrl+route,headers: mHeaders);
      print(json.decode(response.body));
      if(response.statusCode==200){
        print(json.decode(response.body));
        return RespObj.fromJSON(json.decode(response.body));
      }else{
        return RespObj(false,msg: response.body);
      }
    }catch(ex){
      print("Exception e :"+ex.toString());
      return RespObj(false,msg: 'Server Unavailable');
    }

  }

  Future<RespObj> patchData(String route,{String header,String mBody}) async{
    Map<String, String> mHeaders = {"Content-type": "application/json","token":header};
    try{
      Response response = await patch(baseUrl+route,headers: mHeaders,body: mBody);
      print(json.decode(response.body));
      if(response.statusCode==200){
        print(json.decode(response.body));
        return RespObj.fromJSON(json.decode(response.body));
      }else{
        return RespObj(false,msg: response.body);
      }
    }catch(ex){
      print("Exception e :"+ex.toString());
      return RespObj(false,msg: 'Server Unavailable');
    }

  }

  Future<RespObj> postData(String route,{String mBody,String header}) async{
    Map<String, String> mHeaders = {"Content-Type": "application/json","token":header};
    try{
    Response response = await post(baseUrl+route,headers: mHeaders,body: mBody);
    print(response.body);
    if(response.statusCode==200){
      return RespObj.fromJSON(json.decode(response.body));
    }else{
      return RespObj(false,msg: response.body);
    }
    }catch(e){
      print(e.toString());
      return RespObj(false,msg: 'Server Unavailable');
    }
  }

  Future<RespObj> putData(String route,{String mBody,String header}) async{
    Map<String, String> mHeaders = {"Content-Type": "application/json","token":header};
    try{
      Response response = await put(baseUrl+route,headers: mHeaders,body: mBody);
      print(response.body);
      if(response.statusCode==200){
        return RespObj.fromJSON(json.decode(response.body));
      }else{
        return RespObj(false,msg: response.body);
      }
    }catch(e){
      print(e.toString());
      return RespObj(false,msg: 'Server Unavailable');
    }
  }


  Future<RespObj> uploadFiles(String route,Map files,{String header,String id}) async{

    var request = MultipartRequest("POST", Uri.parse(baseUrl+route));
    request.fields["name"] = 'test';
    await files.forEach((k,v) {
       MultipartFile.fromPath(k, v.path).then((image){
         request.files.add(image);
       });
    });

    var resp = await request.send();
    print("Raw resp"+resp.toString());
    var responseData = await resp.stream.toBytes();
    print("Resp Data"+responseData.toString());
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
    return RespObj.fromJSON(json.decode(responseString));

  }

}

final api = ApiUtils();