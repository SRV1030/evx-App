import 'package:flutter/material.dart';


import './FavouriteScreen.dart';
import './CreateEventScreen.dart';
import './chat_screen.dart';
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
      {'page': ChatScreen(), 'title': 'Chat'},
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
        backgroundColor: Color(0xff05133c),
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
        selectedItemColor:Colors.blue,
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
            icon: Icon(Icons.chat_bubble),
            title: Text("Chat"),
          ),
        ],
      ),
    );
  }
}
