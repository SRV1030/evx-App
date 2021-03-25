import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/evxOrganizers.dart';
import '../Provider/EvxOrganizersEventsProvider.dart';

class CreateEventScreen extends StatefulWidget {

  static const routeName = "/createEventScreen";
  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {

  final _form = GlobalKey<FormState>();
  final _clubFocusNode = FocusNode();
  final _eventDeadlineFocusNode = FocusNode();
  final _eventRegisterationlinkFocusNode = FocusNode();
  final _catchUplinkFocusNode = FocusNode();
  final _eventtimeFocusNode = FocusNode();
  final _eventTypeFocusNode = FocusNode();
  final _eventCategoryFocusNode = FocusNode();
  final _eventDescriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();

   @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
         _clubFocusNode.dispose();
  _eventDeadlineFocusNode.dispose();
  _eventRegisterationlinkFocusNode.dispose() ;
  _catchUplinkFocusNode.dispose();
  _eventtimeFocusNode.dispose();
  _eventTypeFocusNode.dispose();
  _eventCategoryFocusNode.dispose();
  _eventDescriptionFocusNode.dispose();
   _imageUrlController.dispose();
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


  EvxOrganizers _addedOrganizer = EvxOrganizers(
    eventId: null,
    eventName: '',
    club: '',
    eventPosterImgUrl: '',
    registerationDeadline: '',
    registerationLink: '',
    catchupLink: '',
    eventTime: '',
    eventType: '',
    eventCategory: '',
    eventDescription: '',
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
      await Provider.of<EvxOrganizersEventsProvider>(context, listen: false)
          .addOrganizers(_addedOrganizer);
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
    return  Scaffold(
        appBar: AppBar(title: Text('Create youe Event'),),
          body: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _form,
            child: ListView(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Event Name *'),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_clubFocusNode);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please provide a value.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _addedOrganizer = EvxOrganizers(
                      eventId: _addedOrganizer.eventId,
                      eventName: value,
                      club: _addedOrganizer.club,
                      eventPosterImgUrl: _addedOrganizer.eventPosterImgUrl,
                      registerationDeadline:
                          _addedOrganizer.registerationDeadline,
                      registerationLink: _addedOrganizer.registerationLink,
                      catchupLink: _addedOrganizer.catchupLink,
                      eventTime: _addedOrganizer.eventTime,
                      eventType: _addedOrganizer.eventType,
                      eventCategory: _addedOrganizer.eventCategory,
                      eventDescription: _addedOrganizer.eventDescription,
                    );
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Club Name *'),
                  focusNode: _clubFocusNode,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context)
                        .requestFocus(_eventRegisterationlinkFocusNode);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please provide a value.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _addedOrganizer = EvxOrganizers(
                      eventId: _addedOrganizer.eventId,
                      eventName: _addedOrganizer.eventName,
                      club: value,
                      eventPosterImgUrl: _addedOrganizer.eventPosterImgUrl,
                      registerationDeadline:
                          _addedOrganizer.registerationDeadline,
                      registerationLink: _addedOrganizer.registerationLink,
                      catchupLink: _addedOrganizer.catchupLink,
                      eventTime: _addedOrganizer.eventTime,
                      eventType: _addedOrganizer.eventType,
                      eventCategory: _addedOrganizer.eventCategory,
                      eventDescription: _addedOrganizer.eventDescription,
                    );
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Registratuion Link *'),
                  textInputAction: TextInputAction.next,
                  focusNode: _eventRegisterationlinkFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_eventDeadlineFocusNode);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please provide a value.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _addedOrganizer = EvxOrganizers(
                      eventId: _addedOrganizer.eventId,
                      eventName: _addedOrganizer.eventName,
                      club: _addedOrganizer.club,
                      eventPosterImgUrl: _addedOrganizer.eventPosterImgUrl,
                      registerationDeadline:
                          _addedOrganizer.registerationDeadline,
                      registerationLink: value,
                      catchupLink: _addedOrganizer.catchupLink,
                      eventTime: _addedOrganizer.eventTime,
                      eventType: _addedOrganizer.eventType,
                      eventCategory: _addedOrganizer.eventCategory,
                      eventDescription: _addedOrganizer.eventDescription,
                    );
                  },
                ),
                TextFormField(
                  decoration:
                      InputDecoration(labelText: 'Registratuion DeadLine *'),
                  textInputAction: TextInputAction.next,
                  focusNode: _eventDeadlineFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_catchUplinkFocusNode);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please provide a value.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _addedOrganizer = EvxOrganizers(
                      eventId: _addedOrganizer.eventId,
                      eventName: _addedOrganizer.eventName,
                      club: _addedOrganizer.club,
                      eventPosterImgUrl: _addedOrganizer.eventPosterImgUrl,
                      registerationDeadline: value,
                      registerationLink: _addedOrganizer.registerationLink,
                      catchupLink: _addedOrganizer.catchupLink,
                      eventTime: _addedOrganizer.eventTime,
                      eventType: _addedOrganizer.eventType,
                      eventCategory: _addedOrganizer.eventCategory,
                      eventDescription: _addedOrganizer.eventDescription,
                    );
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'CatchUp Link *'),
                  textInputAction: TextInputAction.next,
                  focusNode: _catchUplinkFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_eventtimeFocusNode);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please provide a value.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _addedOrganizer = EvxOrganizers(
                      eventId: _addedOrganizer.eventId,
                      eventName: _addedOrganizer.eventName,
                      club: _addedOrganizer.club,
                      eventPosterImgUrl: _addedOrganizer.eventPosterImgUrl,
                      registerationDeadline:
                          _addedOrganizer.registerationDeadline,
                      registerationLink: _addedOrganizer.registerationLink,
                      catchupLink: value,
                      eventTime: _addedOrganizer.eventTime,
                      eventType: _addedOrganizer.eventType,
                      eventCategory: _addedOrganizer.eventCategory,
                      eventDescription: _addedOrganizer.eventDescription,
                    );
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Event Time *'),
                  textInputAction: TextInputAction.next,
                  focusNode: _eventtimeFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_eventTypeFocusNode);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please provide a value.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _addedOrganizer = EvxOrganizers(
                      eventId: _addedOrganizer.eventId,
                      eventName: _addedOrganizer.eventName,
                      club: _addedOrganizer.club,
                      eventPosterImgUrl: _addedOrganizer.eventPosterImgUrl,
                      registerationDeadline:
                          _addedOrganizer.registerationDeadline,
                      registerationLink: _addedOrganizer.registerationLink,
                      catchupLink: _addedOrganizer.catchupLink,
                      eventTime: value,
                      eventType: _addedOrganizer.eventType,
                      eventCategory: _addedOrganizer.eventCategory,
                      eventDescription: _addedOrganizer.eventDescription,
                    );
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Event Type *'),
                  textInputAction: TextInputAction.next,
                  focusNode: _eventTypeFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_eventCategoryFocusNode);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please provide a value.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _addedOrganizer = EvxOrganizers(
                      eventId: _addedOrganizer.eventId,
                      eventName: _addedOrganizer.eventName,
                      club: _addedOrganizer.club,
                      eventPosterImgUrl: _addedOrganizer.eventPosterImgUrl,
                      registerationDeadline:
                          _addedOrganizer.registerationDeadline,
                      registerationLink: _addedOrganizer.registerationLink,
                      catchupLink: _addedOrganizer.catchupLink,
                      eventTime: _addedOrganizer.eventTime,
                      eventType: value,
                      eventCategory: _addedOrganizer.eventCategory,
                      eventDescription: _addedOrganizer.eventDescription,
                    );
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Event Category *'),
                  textInputAction: TextInputAction.next,
                  focusNode: _eventCategoryFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context)
                        .requestFocus(_eventDescriptionFocusNode);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please provide a value.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _addedOrganizer = EvxOrganizers(
                      eventId: _addedOrganizer.eventId,
                      eventName: _addedOrganizer.eventName,
                      club: _addedOrganizer.club,
                      eventPosterImgUrl: _addedOrganizer.eventPosterImgUrl,
                      registerationDeadline:
                          _addedOrganizer.registerationDeadline,
                      registerationLink: _addedOrganizer.registerationLink,
                      catchupLink: _addedOrganizer.catchupLink,
                      eventTime: _addedOrganizer.eventTime,
                      eventType: _addedOrganizer.eventType,
                      eventCategory: value,
                      eventDescription: _addedOrganizer.eventDescription,
                    );
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Event Description *'),
                  textInputAction: TextInputAction.next,
                  focusNode: _eventDescriptionFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_imageUrlFocusNode);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please provide a value.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _addedOrganizer = EvxOrganizers(
                      eventId: _addedOrganizer.eventId,
                      eventName: _addedOrganizer.eventName,
                      club: _addedOrganizer.club,
                      eventPosterImgUrl: _addedOrganizer.eventPosterImgUrl,
                      registerationDeadline:
                          _addedOrganizer.registerationDeadline,
                      registerationLink: _addedOrganizer.registerationLink,
                      catchupLink: _addedOrganizer.catchupLink,
                      eventTime: _addedOrganizer.eventTime,
                      eventType: _addedOrganizer.eventType,
                      eventCategory: _addedOrganizer.eventCategory,
                      eventDescription: value,
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
                          _addedOrganizer = EvxOrganizers(
                      eventId: _addedOrganizer.eventId,
                      eventName: _addedOrganizer.eventName,
                      club: _addedOrganizer.club,
                      eventPosterImgUrl: value,
                      registerationDeadline:
                          _addedOrganizer.registerationDeadline,
                      registerationLink: _addedOrganizer.registerationLink,
                      catchupLink: _addedOrganizer.catchupLink,
                      eventTime: _addedOrganizer.eventTime,
                      eventType: _addedOrganizer.eventType,
                      eventCategory: _addedOrganizer.eventCategory,
                      eventDescription: _addedOrganizer.eventDescription,
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
