import 'package:flutter/material.dart';
import 'package:mEvx/Provider/EvxEventsProvider.dart';
import 'package:provider/provider.dart';
import './UserRegisterationScreen.dart';

class EventDetailScreen extends StatelessWidget {
  static const routeName = '/Events-detail';
  // final Function toggleFavourite;
  // final Function isMealFavourite;


  Widget buildSectionTitle(String text, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(text, style: Theme.of(context).textTheme.title),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.teal[50],
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 200,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
      
    final String id =ModalRoute.of(context).settings.arguments as String;
    final selectedEvent = Provider.of<EvxEventsProviders>(context).findById(id);

    return Scaffold(
      appBar: AppBar(
        title: Text(" ${selectedEvent.name}"),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Container(
            height: 200,
            width: double.infinity,
            child: Image.network(
              selectedEvent.image,
              fit: BoxFit.cover,
            ),
          ),
          buildSectionTitle("Description", context),
          buildContainer(
            Card(
              color: Theme.of(context).accentColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                child: Text(
                  selectedEvent.description,
                  style: TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(UserRegistrationScreen.routeName,arguments: id);
        },
      ),
    );
  }
}
