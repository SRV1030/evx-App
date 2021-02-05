import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/evxData.dart';
import '../Constants/Strings.dart';


class EvxEventsProviders with ChangeNotifier {  
 bool isLoading= true;
  List<Welcome> _events;
  String userId;
  String authToken;
  EvxEventsProviders(this.userId,this.authToken,this._events);



  void setEvents(List<Welcome> events){
    _events=events;
    isLoading =false;
    notifyListeners();
  }
  List<Welcome> get events {
    return [..._events];
  }

  List<Welcome>  getEvents(){
    return _events;
  }  
  Welcome findById(String id) {
    return _events.firstWhere((prod) => prod.id == id);
  }
  Future<List<Welcome>> getSourse()async{
    var client= http.Client();  
    List<Welcome>  layoutEvent=[];
  try{
    var response = await client.get(Strings.evx_url);
    final urlfavs="https://evxuser-d835c-default-rtdb.firebaseio.com/userFavourites/$userId.json?auth=$authToken";
    final favoriteResponse= await http.get(urlfavs);
    final favoriteData=json.decode(favoriteResponse.body);
    print(favoriteData);
    
    if(response.statusCode==200){
    //   var jsonString = response.body;
    //  // print(jsonString);
    //   var jsonMap = json.decode(jsonString);

    //   s =Welcome.fromJson(jsonMap);
    List jsonList = json.decode(response.body);
    if (jsonList==null) return layoutEvent;
    layoutEvent  = jsonList.map((model)=> Welcome.fromJson(model)).toList();
    layoutEvent.forEach((event) { 
      event.isFavourite=favoriteData==null? false:favoriteData[event.id]??false;
    });
    notifyListeners();
    }
  }
  catch(Exception){
    return layoutEvent;
  }
  return layoutEvent;
  }
   void _setFavourite(isFavourite,bool oldStatus) {
   isFavourite = oldStatus;
    notifyListeners();
  // }

  }

  Future<void> toggleFavourite(String authToken, String userId,String eventID) async {    
    Welcome oldEvent = findById(eventID);
    final oldStatus=oldEvent.isFavourite;
    oldEvent.isFavourite = !oldEvent.isFavourite;
    notifyListeners();
    final url =
        'https://evxuser-d835c-default-rtdb.firebaseio.com/userFavourites/$userId/$eventID.json?auth=$authToken';
    try {
      final response= await http.put(
        url,
        body: json.encode(
          oldEvent.isFavourite,
        ),
      );
    if(response.statusCode>=400){
        _setFavourite( oldEvent.isFavourite,oldStatus);
      }
      notifyListeners();
    } catch (error) {
       _setFavourite(oldEvent.isFavourite,oldStatus);
    }
  }
}

/*

*/