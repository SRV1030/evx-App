import '../widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../models/auth.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userId=Provider.of<Auth>(context,listen:false).userId;
    return StreamBuilder(
            stream: Firestore.instance
                .collection('chat')
                .orderBy(
                  'timeStamp',
                  descending: true,
                )
                .snapshots(),
            builder: (ctx, chatSnapshot) {
              if (chatSnapshot.connectionState == ConnectionState.waiting)
                return Center(
                  child: CircularProgressIndicator(),
                );
              final chatDocs = chatSnapshot.data.documents;
              return ListView.builder(
                reverse: true,
                itemBuilder: (ctx, index) => MessageBubble(
                  chatDocs[index]['text'],
                  chatDocs[index]['user'] == userId,
                  // chatDocs[index]['user'],
                  chatDocs[index]['userName'],
                  key: ValueKey(chatDocs[index].documentID),
                ),
                itemCount: chatDocs.length,
              );
            }
            );
  }
}
   
