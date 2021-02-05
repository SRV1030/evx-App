import 'package:flutter/material.dart';
import 'package:mEvx/models/auth.dart';
import 'package:mEvx/screens/CreateEventScreen.dart';
import 'package:provider/provider.dart';

import './models/evxData.dart';

import './Provider/EvxEventsProvider.dart';
import './Provider/evxUsersProvider.dart';
import './Provider/EvxOrganizersEventsProvider.dart';

import './screens/EventDetailsScreen.dart';
import './screens/UserRegisterationScreen.dart';
import './screens/AuthScreen.dart';
import './screens/Tabscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, EvxUsersProvider>(
            //Proxy provider depeends on the mentioned provider too. We mention the class to follow auth and depeneding class Products
            update: (ctx, auth, previousUserProvider) => EvxUsersProvider(                
                auth.userId,
                auth.token,
                previousUserProvider == null
                    ? []
                    : previousUserProvider
                        .users) //update instead of create. and we only use the proxyProvider when we need to cahange one provider when otheris changed
            ),
            ChangeNotifierProxyProvider<Auth, EvxEventsProviders>(
            //Proxy provider depeends on the mentioned provider too. We mention the class to follow auth and depeneding class Products
            update: (ctx, auth, previousEvents) => EvxEventsProviders(                
                auth.userId,
                auth.token,
                 previousEvents == null
                    ? []
                    :  previousEvents
                        .events) //update instead of create. and we only use the proxyProvider when we need to cahange one provider when otheris changed
            ),
            ChangeNotifierProxyProvider<Auth, Welcome>(
            //Proxy provider depeends on the mentioned provider too. We mention the class to follow auth and depeneding class Products
            update: (ctx, auth, previousEvents) => Welcome() //update instead of create. and we only use the proxyProvider when we need to cahange one provider when otheris changed
            ),
            ChangeNotifierProvider(
          create: (ctx) => EvxOrganizersEventsProvider(),
        ),         
        ChangeNotifierProvider(
          create: (ctx) => Welcome(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.cyan,
              accentColor: Colors.grey,
              canvasColor: Color.fromRGBO(194,217,255,0.8),
              fontFamily: 'Raleway',
              textTheme: ThemeData.light().textTheme.copyWith(
                    body1: TextStyle(
                      color: Color.fromRGBO(20, 51, 51, 1),
                    ),
                    body2: TextStyle(
                      color: Color.fromRGBO(20, 51, 51, 1),
                    ),
                    title: TextStyle(
                      fontSize: 20,
                      fontFamily: "RobotoCondensed",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            ),
            home: auth.isAuth ? TabsScreen() : AuthScreen(),
            routes: {
              EventDetailScreen.routeName: (ctx) => EventDetailScreen(),
              UserRegistrationScreen.routeName: (ctx) =>
                  UserRegistrationScreen(),
              CreateEventScreen.routeName: (ctx) => CreateEventScreen(),
            }),
      ),
    );
  }
}
