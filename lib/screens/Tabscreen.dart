import 'package:flutter/material.dart';


import './FavouriteScreen.dart';
import './CreateEventScreen.dart';
import './settings.dart';
import './RegisteredEventsScreen.dart';
import './HomeScreen.dart';
import '../widgets/drawers.dart';

class TabsScreen extends StatefulWidget {
  TabsScreen();

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    //automatically receives index
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _pages = [ 
      {'page': HomeScreen(), 'title': 'eVX'},
      {'page':CreateEventScreen(), 'title': 'Amin'},
      {'page': RegisteredEventsScreen(), 'title': 'Registered Events'},   
      {'page': FavouriteScreen(), 'title': 'Favourites'},
      {'page': SettingScreen(), 'title': 'Settings'},
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
        backgroundColor: Colors.cyan,
        // actions: [
        // //   FlatButton(
        // //     onPressed: () {
        // //       Navigator.of(context).pushNamed(CreateEventScreen.routeName);
        // //     },
        // //     child:Text("Create Event");
        // //   ),
        // // ],
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.grey,
        currentIndex:
            _selectedPageIndex, //tells the navigationbar whicjh index is chosen
        // type: BottomNavigationBarType.shifting, //for shifting animation
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.admin_panel_settings),
            title: Text("Admin"),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.event),
            title: Text("Events"),
          ),
          
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.star),
            title: Text("Favourites"),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.settings),
            title: Text("Settings"),
          ),
        ],
      ),
    );
  }
}
