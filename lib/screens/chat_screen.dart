import '../widgets/messages.dart';
import '../widgets/new_message.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/auth.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            // StreamBuilder(
            //     stream: Firestore.instance
            //         .collection('chats/30n357IS8UyCivDE8weM/messages')
            //         .snapshots(),
            //     builder: (ctx, streamSnapshot) {
            //       if (streamSnapshot.connectionState == ConnectionState.waiting) {
            //         return Center(
            //           child: CircularProgressIndicator(),
            //         );
            //       }
            //       final documents = streamSnapshot.data.documents;
            //       return ListView.builder(
            //         itemCount: documents.length,
            //         itemBuilder: (ctx, index) => Container(
            //           padding: EdgeInsets.all(8),
            //           child: Text(documents[index]['text']),
            //         ),
            //       );
            //     }),
            Container(
          child: Column(
            children: <Widget>[
              Expanded(child: Messages()),
              NewMessage(),
            ],
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.add),
        //   onPressed: () {
        //     // Firestore.instance
        //     //     .collection('chats/30n357IS8UyCivDE8weM/messages')
        //     //     .snapshots()
        //     //     .listen(
        //     //   (data) {
        //     //     data.documents.forEach((e) {
        //     //       print(e['text']);
        //     //     });
        //     //   },
        //     // );

        //     // Adding new messages//
        //     Firestore.instance
        //         .collection('chats/30n357IS8UyCivDE8weM/messages')
        //         .add({'text': 'New text added'});
        //   },
        // ),
        
     
    );
  }
}
