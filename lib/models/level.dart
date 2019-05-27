
import 'dart:convert';
import 'dart:core';
import 'package:flutter/services.dart';
import 'rate_tuple.dart';

class Level {
  int _number;
  int _nbQuestions;
  Map<String, int> _styleRate;                      // style (metaphore, ..) => rate
  Map<String, List<RateTuple>> _styleCategorieRate; // style => list((image, 25), ...)

  Level(String pathToLevel) {
    _styleRate = Map();
    _styleCategorieRate = Map();
    loadAndBuildLevel(pathToLevel);
  }

  int getRate(String style) {
    assert(_styleRate.containsKey(style));

    return _styleRate[style];
  }

  List<String> getAllStyles() {
    List<String> res = List();
    res.addAll(_styleRate.keys);
    return res;
  }

  List<String> getAllCategories(String style) {
    List<String> res = List();
    List<RateTuple> temp = _styleCategorieRate[style];
    for (RateTuple rateTuple in temp) {
      res.add(rateTuple.categorie);
    }
    return res;
  }

  List<RateTuple> getCategorieRate(String style) {
    assert(_styleCategorieRate.containsKey(style));

    return _styleCategorieRate[style];
  }

  /// Assumes the given path is a text-file-asset.
  Future<String> getFileData(String path) async {
    return await rootBundle.loadString(path);
  }

  int getLevelNumber() { return _number; }

  int getNbQuestions() { return _nbQuestions; }

  void loadAndBuildLevel(String path) async {
    String jsonString = await getFileData(path);
    dynamic jsonData = json.decode(jsonString);

    _number = jsonData['level'];
    _nbQuestions = jsonData['numberQuestion'];

    for(dynamic type in jsonData['types']) {
      String style = type['type'];
      _styleRate.putIfAbsent(style, () => type['rate']);
      _styleCategorieRate.putIfAbsent(style, () => List<RateTuple>());

      for(dynamic diff in type['difficulties']) {
        _styleCategorieRate[style].add(RateTuple(diff['categorie'], diff['rate']));
      }
    }
  }

}