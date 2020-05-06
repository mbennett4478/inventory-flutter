import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:inventory/screens/inventory_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
      uri: 'http://bsmple.ngrok.io',
    );

    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        link: httpLink,
        cache: InMemoryCache(),
      ),
    );

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromRGBO(38, 70, 83, 1.0),
        appBarTheme: AppBarTheme(
          color: Color.fromRGBO(58, 87, 98, 1.0),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        primaryTextTheme: TextTheme(
          title: TextStyle(color: Colors.white),
        ),
        dialogBackgroundColor: Color.fromRGBO(38, 70, 83, 1.0),
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
//        textTheme: TextTheme(
//          te
//        ),
        popupMenuTheme: PopupMenuThemeData(
            color: Color.fromRGBO(38, 70, 83, 1.0),
        ),
        colorScheme: ColorScheme.dark(
          primary: Color.fromRGBO(42, 157, 143, 1.0),
          secondary: Color.fromRGBO(244, 162, 97, 1.0),
          background: Color.fromRGBO(38, 70, 83, 1.0),
          surface: Color.fromRGBO(38, 70, 83, 1.0), 
          onError: Colors.white,
          primaryVariant: Color.fromRGBO(0, 48, 73, 1.0),
          secondaryVariant: Color.fromRGBO(247, 127, 0, 1.0),
          onPrimary: Colors.white,
          onBackground: Colors.white,
          onSurface: Colors.white,
          error: Color.fromRGBO(231, 111, 81, 1.0),
          onSecondary: Colors.white,
        ),
        primaryIconTheme: IconThemeData(color: Colors.white),
//        primaryColor: Color.fromRGBO(38, 70, 83, 1.0),
//          Color.fromRGBO(42, 157, 143, 1.0),
//        accentColor: Color.fromRGBO(244, 162, 97, 1.0),
//        backgroundColor: Color.fromRGBO(38, 70, 83, 1.0),
//        brightness: ,
      ),
      home: GraphQLProvider(
        child: InventoryListView(),
        client: client,
      ),
    );
  }
}
