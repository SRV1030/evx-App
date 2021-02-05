import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/evxOrganizers.dart';

class EvxOrganizersEventsProvider extends ChangeNotifier {
  List<EvxOrganizers> organizers;
  List<EvxOrganizers> get _organizers {
    return [...organizers];
  }

  EvxOrganizers findByid(String id) {
    return _organizers.firstWhere((org) => id == org.eventId);
  }

  Future<void> addOrganizers(EvxOrganizers newOrganizer) async {
    const dbUrl =
        "https://evxuser-d835c-default-rtdb.firebaseio.com/organizers.json";
    try {
      final response = await http.post(
        dbUrl,
        body: json.encode({
          'eventName': newOrganizer.eventName,
          'club': newOrganizer.club,
          'eventPosterImgUrl': newOrganizer.eventPosterImgUrl,
          'registerationDeadline': newOrganizer.registerationDeadline,
          'registerationLink': newOrganizer.registerationLink,
          'catchupLink': newOrganizer.catchupLink,
          'eventTime': newOrganizer.eventTime,
          'eventType': newOrganizer.eventType,
          'eventCategory': newOrganizer.eventCategory,
          'eventDescription': newOrganizer.eventDescription,
        }),
      );
      EvxOrganizers addedOrganizer = EvxOrganizers(
        eventId: json.decode(response.body)['name'],
        eventName: newOrganizer.eventName,
        club: newOrganizer.club,
        eventPosterImgUrl: newOrganizer.eventPosterImgUrl,
        registerationDeadline: newOrganizer.registerationDeadline,
        registerationLink: newOrganizer.registerationLink,
        catchupLink: newOrganizer.catchupLink,
        eventTime: newOrganizer.eventTime,
        eventType: newOrganizer.eventType,
        eventCategory: newOrganizer.eventCategory,
        eventDescription: newOrganizer.eventDescription,
      );
      organizers.add(addedOrganizer);
    } catch (error) {
      print(error);
      throw (error);
    }

    notifyListeners();
  }
}
