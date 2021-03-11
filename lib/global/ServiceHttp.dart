import 'dart:convert';
import 'package:elite_guardians/global/Global.dart';
import 'package:http/http.dart' as http;

class ServiceHttp{

  String BASE_URL = "https://eliteguardian.co.uk/api/";
  String BASE_URL_LOCAL = "http://localhost:8000/api/";

  httpRequestPost(String url,{Map map,void onSuccess(value),void onError(value)}) async{
    var token = await Global.getToken();
    var response= await http.post(BASE_URL+url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json;',
        'Authorization': token.isNotEmpty?'Bearer $token':"",
      },
      body: map!=null?jsonEncode(map):null,
    );
    if (response.statusCode == 200 || response.statusCode == 201)
    {
        onSuccess(response.body);
    }
    else
     {
    onError(response.body);
    }
  }
  httpRequestGet(String url,{void onSuccess(value),void onError(value)}) async{
    var token = await Global.getToken();
    var response= await http.get(BASE_URL+url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token.isNotEmpty?'Bearer $token':"",
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201)
    {
      onSuccess(response.body);
    }
    else
    {
      onError(response.body);
    }
  }
}