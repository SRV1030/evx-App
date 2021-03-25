import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../models/auth.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _enteredMessage = '';
  final _controllerText = new TextEditingController();

  void _sendMessage(BuildContext ctx) async {
    FocusScope.of(context).unfocus();
    final userId = Provider.of<Auth>(ctx, listen: false).userId;
    print(Provider.of<Auth>(ctx, listen: false));
    print(userId);
    final userData =
        await Firestore.instance.collection('users').document(userId).get();
    Firestore.instance.collection('chat').add({
      'text': _enteredMessage,
      'timeStamp': Timestamp.now(), //gives the timestamp
      'user': userId,
      'userName': userData['userName'],
    });
    _controllerText.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controllerText,
              decoration: InputDecoration(
                  labelText: 'Send a message...',
                  filled: true,
                  fillColor: Colors.white),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
            color: Colors.pink,
            icon: Icon(Icons.send),
            onPressed: _enteredMessage.trim().isEmpty
                ? null
                : () => _sendMessage(context),
          ),
        ],
      ),
    );
  }
}
