import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:inventory/screens/inventory_list.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (_) => GraphQLClient(
            link: HttpLink(
              uri: 'http://bsmple.ngrok.io',
            ),
            cache: OptimisticCache(
              dataIdFromObject: typenameDataIdFromObject,
            ),
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}

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
        cache: OptimisticCache(
          dataIdFromObject: typenameDataIdFromObject,
        ),
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
          headline6: TextStyle(color: Colors.white),
        ),
        dialogBackgroundColor: Color.fromRGBO(38, 70, 83, 1.0),
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
          error: Color.fromRGBO(214, 40, 40, 1.0),
          onSecondary: Colors.white,

        ),
        primaryIconTheme: IconThemeData(color: Colors.white),
      ),
      home: GraphQLProvider(
        child: InventoryView(),
        client: client,
      ),
    );
  }
}
