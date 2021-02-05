import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mEvx/models/evxData.dart';
import '../screens/EventDetailsScreen.dart';
import 'package:provider/provider.dart';
import '../models/auth.dart';
import '../Provider/EvxEventsProvider.dart';
class EventItem extends StatefulWidget {
  final String college;
  final String id;
  final String imageURL;
  final String category;
  final String club;
  //final Function removeItem;

  EventItem({
    @required this.college,
    @required this.id,
    @required this.imageURL,
    @required this.category,
    @required this.club,
    /*@required this.removeItem*/
  });

  @override
  _EventItemState createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {
  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<Auth>(context, listen: false);
    final eventsdata=Provider.of<EvxEventsProviders>(context, listen: false);
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(EventDetailScreen.routeName, arguments: widget.id);
      }, //()=>selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      "evX",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  new Spacer(),
                  Row(
                    children: <Widget>[
                      Icon(Icons.calendar_today),
                      SizedBox(width: 6),
                      Text(DateFormat.yMMMd().format(DateTime.now())),
                    ],
                  ),
                 
                ],
              ),
            ),
            Stack(
              children: <Widget>[
                ClipRRect(
                  //used to adjust image in the card
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(15),
                  //   topRight: Radius.circular(15),
                  // ),
                  child: Image.network(
                    widget.imageURL,
                    height: 500,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20, //distance from bottom
                  right: 10, //distance from right
                  child: Container(
                    //so that the text doesn't overflow
                    width: 250,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Text(
                      widget.college,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      softWrap: true, //text is wrapped
                      overflow: TextOverflow
                          .fade, //so that the text dpesn,y overflows the card
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.category),
                      SizedBox(width: 6),
                      Text(widget.category,style:TextStyle(fontSize: 25),),
                    ],
                  ),
                  // Row(
                  //   children: <Widget>[
                  //     Icon(Icons.group),
                  //     SizedBox(width: 6),
                  //     Text(club),
                  //   ],
                  // ),
                   Consumer<EvxEventsProviders>(
                    builder: (ctx, event, _) => IconButton(
                      icon: Icon(
                        event.findById(widget.id).isFavourite
                          ? Icons.favorite
                          : Icons.favorite_border),
                      color: event.findById(widget.id).isFavourite?Colors.red:Theme.of(context).accentColor,
                      iconSize: 40,
                      onPressed: () {
                        event.toggleFavourite(authData.token,authData.userId,widget.id);  
                                           
                      },
                    ),
                  ),
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
