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
          color: Color(0xff05133c),
          boxShadow: [
            BoxShadow(
              blurRadius: 38,
              color: Color(0xff020819),
              offset: Offset(19, 19),
            ),
            BoxShadow(
              blurRadius: 38,
              color: Color(0xff081e5f),
              offset: Offset(-19, -19),
            )
          ],
          gradient: LinearGradient(
            stops: [0, 1],
            begin:Alignment.topLeft,
            end:Alignment.bottomRight,
            colors:[
              Color(0xff051136),
              Color(0xff051440),
            ]            
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        margin: EdgeInsets.all(10),
      height: 500,
      width: 400,
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
              fit: BoxFit.fitWidth,
            ),
          ),
          buildSectionTitle("Description", context),
          buildContainer(
            Card(
              color: Color(0x00000000),
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
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add,color: Colors.white,),
        onPressed: () {
          Navigator.of(context).pushNamed(UserRegistrationScreen.routeName,arguments: id);
        },
      ),
    );
  }
}
