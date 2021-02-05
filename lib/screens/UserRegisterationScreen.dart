import 'package:flutter/material.dart';
import 'package:mEvx/Provider/evxUsersProvider.dart';
import 'package:provider/provider.dart';
import '../Provider/EvxEventsProvider.dart';
import '../models/evxUsers.dart';

class UserRegistrationScreen extends StatefulWidget {
  static const routeName = '/user-registeration-screen';
  @override
  _UserRegistrationScreenState createState() => _UserRegistrationScreenState();
}

class _UserRegistrationScreenState extends State<UserRegistrationScreen> {
  final _form = GlobalKey<FormState>();
  final _lastNameFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _lastNameFocusNode.dispose();
    _phoneFocusNode.dispose();
    _emailFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  var _addedUser = EvxUsers(
    eventId: '',
    userId: null,
    userName: '',
    userLastName: '',
    userphone: '',
    userEmail: '',
    userImageUrl: '',
  );
  bool isLoading = true;
  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<EvxUsersProvider>(context, listen: false)
          .addUsers(_addedUser);
    } catch (error) {
      print(error);
    } finally {
      //only works with try and catch and executes its code no matter what
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    String eventId = ModalRoute.of(context).settings.arguments as String;
    _addedUser.eventId = eventId;
    final selectedevent =
        Provider.of<EvxEventsProviders>(context).findById(eventId);

    return Scaffold(
      appBar: AppBar(
        title: Text("Registeration"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveForm();
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              Container(
                width: 250,
                color: Colors.black54,
                padding: EdgeInsets.all(10),
                child: Text(
                  "Registeration for ${selectedevent.name}",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  softWrap: true, //text is wrapped
                  overflow: TextOverflow
                      .fade, //so that the text dpesn,y overflows the card
                ),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'FirstName *'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_lastNameFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a value.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _addedUser = EvxUsers(
                    eventId: _addedUser.eventId,
                    userId: _addedUser.userId,
                    userName: value,
                    userLastName: _addedUser.userLastName,
                    userphone: _addedUser.userphone,
                    userEmail: _addedUser.userEmail,
                    userImageUrl: _addedUser.userImageUrl,
                  );
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'LastName *'),
                textInputAction: TextInputAction.next,
                focusNode: _lastNameFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_phoneFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a value.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _addedUser = EvxUsers(
                    eventId: _addedUser.eventId,
                    userId: _addedUser.userId,
                    userName: _addedUser.userName,
                    userLastName: value,
                    userphone: _addedUser.userphone,
                    userEmail: _addedUser.userEmail,
                    userImageUrl: _addedUser.userImageUrl,
                  );
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone *'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _phoneFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_emailFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your number';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number.';
                  }
                  if (value.length < 10) {
                    return 'Please enter a valid number.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _addedUser = EvxUsers(
                    eventId: _addedUser.eventId,
                    userId: _addedUser.userId,
                    userName: _addedUser.userName,
                    userLastName: _addedUser.userLastName,
                    userphone: value,
                    userEmail: _addedUser.userEmail,
                    userImageUrl: _addedUser.userImageUrl,
                  );
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email *'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                focusNode: _emailFocusNode,
                onFieldSubmitted: (_) {
                  _saveForm();
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.endsWith('.com')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onSaved: (value) {
                  _addedUser = EvxUsers(
                    eventId: _addedUser.eventId,
                    userId: _addedUser.userId,
                    userName: _addedUser.userName,
                    userLastName: _addedUser.userLastName,
                    userphone: _addedUser.userphone,
                    userEmail: value,
                    userImageUrl: _addedUser.userImageUrl,
                  );
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                      top: 8,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Text('Enter a URL')
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image URL'),
                      //initialValue: _initvalues['imageUrl'] since image Url is being ctrolled by controller i.e _imageController it can't have initial value.. instead initialize the controller text           keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_imageUrlFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter an image URL.';
                        }
                        if (!value.startsWith('http') &&
                            !value.startsWith('https')) {
                          return 'Please enter a valid URL.';
                        }
                        if (!value.endsWith('.png') &&
                            !value.endsWith('.jpg') &&
                            !value.endsWith('.jpeg')) {
                          return 'Please enter a valid image URL.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _addedUser = EvxUsers(
                          eventId: _addedUser.eventId,
                          userId: _addedUser.userId,
                          userName: _addedUser.userName,
                          userLastName: _addedUser.userLastName,
                          userphone: _addedUser.userphone,
                          userEmail: _addedUser.userEmail,
                          userImageUrl: value,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
