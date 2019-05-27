import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:metafora/blocs/bloc_provider.dart';
import 'package:metafora/blocs/application_bloc.dart';
import 'package:metafora/models/item_collection.dart';
import 'package:metafora/models/item.dart';
import 'package:metafora/models/level.dart';
import 'package:metafora/models/level_collection.dart';
import 'package:metafora/models/personal_level.dart';
import 'package:metafora/screens/home.dart';

Future<void> main() async {
//  debugPrintRebuildDirtyWidgets = true;

  ItemCollection collection = new ItemCollection();

  Future.delayed(Duration(seconds: 10), () {
    collection.idToItem.forEach(
        (String id, Item val) => {print("Val " + val.id + ' ' + val.style)});
  });

  //Level level1 = new Level("assets/levels/level1.json");

  LevelCollection levelCollection = LevelCollection();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    return runApp(
      BlocProvider<ApplicationBloc>(
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Metàfora',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}
