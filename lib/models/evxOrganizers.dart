import 'package:flutter/material.dart';

class EvxOrganizers with ChangeNotifier {
  String eventId;
  String eventName;
  String club;
  String eventPosterImgUrl;
  String registerationDeadline;
  String registerationLink;
  String catchupLink;
  String eventTime;
  String eventType;
  String eventCategory;
  String eventDescription;
  EvxOrganizers({
    @required this.eventId,
    @required this.eventName,
    @required this.club,
    @required this.eventPosterImgUrl,
    @required this.registerationDeadline,
    @required this.registerationLink,
    @required this.catchupLink,
    @required this.eventTime,
    @required this.eventType,
    @required this.eventCategory,
    @required this.eventDescription,
  });
}
