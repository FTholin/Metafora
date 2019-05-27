import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'item.dart';
import 'dart:convert';

class ItemCollection {
  static final ItemCollection _singleton = new ItemCollection._internal();

  factory ItemCollection() {
    return _singleton;
  }

  ItemCollection._internal() {
    _idToItem = Map();
    _styleToId = Map();
    _categorieToId = Map();
    loadAllFiles();
  }

  Map<String, Item> _idToItem;                // item.id => item
  Map<String, List<String>> _styleToId;       // style (metaphore, ...) => list(item.id)
  Map<String, List<String>> _categorieToId;   // categorie (image, rap, ..) => list(item.id)

  Map<String, Item> get idToItem => _idToItem;

  List<Item> getItemsByCategorie(String categorie) {
    // check if categorie exists
    assert(_categorieToId.containsKey(categorie));

    List<Item> res = List();

    for(String id in _categorieToId[categorie]) {
      res.add(_idToItem[id]);
    }

    return res;
  }

  List<Item> getItemsByStyle(String style) {
    // check if style exists
    assert(_styleToId.containsKey(style));

    List<Item> res = List();

    for(String id in _styleToId[style]) {
      res.add(_idToItem[id]);
    }

    return res;
  }

  List<Item> getItemsByCategorieAndStyle(String categorie, String style) {
    // check if style and categorie exist
    assert(_categorieToId.containsKey(categorie) && _styleToId.containsKey(style));

    // get lists of id from parameters
    List<String> categorieItems = _categorieToId[categorie];
    List<String> styleItems = _styleToId[style];

    List<Item> res = List();

    // only kept id that are present in both list
    for (String item in categorieItems) {
      if (styleItems.contains(item)) {
        res.add(_idToItem[item]);
      }
    }

    return res;
  }

  Future loadAllFiles() async {
    Map<String, dynamic> tree;
    Future<String> treeString = getFileData("assets/tree.json");
    treeString.then((value) {
      tree = json.decode(value);
      print(tree);
      for (String itemPath in tree["items"]) {
        Future<Item> futureItem = loadAndBuildItem(itemPath);
        futureItem.then((item) {
          item.pathToPicture = "assets/styles/" + item.pathToPicture;
          _idToItem.putIfAbsent(item.id, () => item);
          
          _styleToId.putIfAbsent(item.style, () => List());
          _styleToId[item.style].add(item.id);

          _categorieToId.putIfAbsent(item.categorie, () => List());
          _categorieToId[item.categorie].add(item.id);
        });
      }

      print("Load ended");
    });
  }

  /// Assumes the given path is a text-file-asset.
  Future<String> getFileData(String path) async {
    return await rootBundle.loadString(path);
  }

  Future<Item> loadAndBuildItem(String path) async {
    String jsonString = await getFileData(path);
    return Item.fromJson(json.decode(jsonString));
  }
}