import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:metafora/models/level.dart';

class LevelCollection {

  static final LevelCollection _singleton = new LevelCollection._internal();

  factory LevelCollection() {
    return _singleton;
  }

  LevelCollection._internal() {
    levels = List();
    loadAllLevels();
  }


  List<Level> levels;

  void loadAllLevels() async {
    Map<String, dynamic> tree;
    Future<String> treeString = getFileData("assets/tree.json");
    treeString.then((value) {
      tree = json.decode(value);
      print(tree);
      for (String levelPath in tree["levels"]) {
        Level level = Level(levelPath);
        levels.add(level);
      }

      levels.sort((a, b) => a.getLevelNumber().compareTo(b.getLevelNumber()));
    });
  }

  /// Assumes the given path is a text-file-asset.
  Future<String> getFileData(String path) async {
    return await rootBundle.loadString(path);
  }
}