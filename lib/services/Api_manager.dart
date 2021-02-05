import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/evxData.dart';
import '../Constants/Strings.dart';

class ApiManager {


  Future<List<Welcome>> getSourse() async{
    var client= http.Client();
    List<Welcome>  layoutEvent;
   
  try{
    var response = await client.get(Strings.evx_url);
    
    if(response.statusCode==200){
    //   var jsonString = response.body;
    //  // print(jsonString);
    //   var jsonMap = json.decode(jsonString);

    //   s =Welcome.fromJson(jsonMap);
    List jsonList = json.decode(response.body);
     layoutEvent  = jsonList.map((model)=> Welcome.fromJson(model)).toList();
    }
  }
  catch(Exception){
    return layoutEvent;
  }
  return layoutEvent;
  }
}