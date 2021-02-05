import 'package:flutter/material.dart';

class EvxUsers with ChangeNotifier {
  String eventId;
  String userId;
  String userName;
  String userLastName;
  String userphone;
  String userEmail;
  String userImageUrl;
  EvxUsers({
    @required this.eventId,
    @required this.userId,
    @required this.userName,
    @required this.userLastName,
    @required this.userphone,
    @required this.userEmail,
    @required this.userImageUrl,
  }
  );
}
