import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/evxUsers.dart';

class EvxUsersProvider extends ChangeNotifier {
  List<EvxUsers> _users;
  String userid;
  String authToken;
  EvxUsersProvider(this.userid,this.authToken,this._users);

  List<EvxUsers> get users {
    return [..._users];
  }

  EvxUsers findById(String id) {
    return _users.firstWhere((user) => user.userId == id);
  }

  Future<void> addUsers(EvxUsers newUser) async {
    final dburl =
        'https://evxuser-d835c-default-rtdb.firebaseio.com/user.json?auth=$authToken';
    try {
      final response=await http.post(
        dburl,
        body: json.encode(
          {
            'eventId': newUser.eventId,
            'userName': newUser.userName,
            'userId': userid,
            'userLastName': newUser.userLastName,
            'userphone': newUser.userphone,
            'userEmail': newUser.userEmail,
            'userImageUrl': newUser.userImageUrl,
          },
        ),       
      );
      print(response.statusCode);
      final addedUser = EvxUsers(
        eventId: newUser.eventId,
        userId: userid,
        userName: newUser.userName,
        userLastName: newUser.userLastName,
        userphone: newUser.userphone,
        userEmail: newUser.userEmail,
        userImageUrl: newUser.userImageUrl,
      );
      users.add(addedUser);
      print(addedUser);
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
    notifyListeners();
  }
}
