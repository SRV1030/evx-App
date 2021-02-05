import 'package:flutter/material.dart';
import 'package:mEvx/screens/CreateEventScreen.dart';

import 'package:provider/provider.dart';
import '../widgets/EventItem.dart';
import '../models/evxData.dart';
import '../Provider/EvxEventsProvider.dart';
import 'package:mEvx/widgets/drawers.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isInit = true;
  hitApi() async {
    try {
      List<Welcome> events =
          await Provider.of<EvxEventsProviders>(context, listen: false)
              .getSourse();
      Provider.of<EvxEventsProviders>(context, listen: false).setEvents(events);
    } catch (error) {
      throw error;
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_isInit) {
      //As didChange dependencies runs more often we use a variable isInit so that weonly call our provider once at the begining

      hitApi();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    List<Welcome> events =
        Provider.of<EvxEventsProviders>(context, listen: false).getEvents();
    return Container(
      child: !Provider.of<EvxEventsProviders>(context).isLoading
          ? ListView.builder(
              itemBuilder: (ctx, i) {
                return EventItem(
                  college: events[i].college,
                  id: events[i].id,
                  imageURL: events[i].image,
                  category: events[i].category,
                  club: events[i].club,
                );
              },
              itemCount: events.length,
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}

/*FutureBuilder<List<Welcome>>(
          future: _layoutEvents,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (ctx, i) {
                  var events = snapshot.data;
                  return EventItem(
                    college: events[i].college,
                    id: events[i].id,
                    imageURL: events[i].image,
                    category: events[i].category,
                    club: events[i].club,
                  );
                },
                itemCount: snapshot.data.length,
              );
            } else
              return Center(child: CircularProgressIndicator());
          },
        ),
      ), */
