import 'package:flutter/material.dart';
import '../screens/CreateEventScreen.dart';
import '../screens/EventDetailsScreen.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            //Heading
            height: 100,
            width: double.infinity,
            padding: EdgeInsets.all(25),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              'Evx',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 25,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile(
            'Home',
            Icons.home,
            () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          buildListTile(
            'CreateEvent',
            Icons.event,
            () {
               Navigator.of(context).pushNamed(CreateEventScreen.routeName);
            },
          ),
           buildListTile(
            'Settings',
            Icons.settings,
            () {
               
            },
          ),
        ],
      ),
    );
  }
}
