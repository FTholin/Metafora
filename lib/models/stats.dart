import 'dart:math';

import 'package:metafora/models/item.dart';
import 'package:metafora/models/item_collection.dart';

class Stats {
  static final Stats _singleton = new Stats._internal();

  factory Stats() {
    return _singleton;
  }

  Stats._internal() {
    errorsByStyle = Map();
    seeingByStyle = Map();
  }

  Map<String, int> errorsByStyle;
  Map<String, Set<String>> seeingByStyle;

  Item getResponse() {
    String bestStyle = "";
    int bestScore = -1;
    for (String style in errorsByStyle.keys) {
      if (errorsByStyle[style] > bestScore &&
          (seeingByStyle[style].length >= 1)) {
        bestScore = errorsByStyle[style];
        bestStyle = style;
      }
    }

    List<Item> items = List();
    ItemCollection collection = ItemCollection();

    for (String categorie in seeingByStyle[bestStyle]) {
      if (categorie != "definition") {
        items.addAll(
            collection.getItemsByCategorieAndStyle(categorie, bestStyle));
      }
    }

    items.shuffle();
    return items.first;
  }

  List<Item> getResponses(Item response) {
    List<Item> items = List();
    ItemCollection collection = ItemCollection();

    for (String style in errorsByStyle.keys) {
      if (style != response.style) {
        if (!response.isPicture()) {
          items.addAll(collection.getItemsByStyle(style));
          items.removeWhere((item) => item.categorie == "image" || item.categorie == 'definition');
        } else {
          items.addAll(collection.getItemsByCategorieAndStyle("image", style));
        }

        /* TODO choisir uniquement des categorie et style vu ?
        Set<String> categories = seeingByStyle[style];
        if (categories.isNotEmpty) {
          Iterator<String> ite = categories.iterator;
          while(ite.moveNext()) {
            if (ite.current != 'image') {
              items.addAll(collection.getItemsByCategorie(ite.current));
            }
          }
        }
        */
      }
    }

    items.shuffle();

    if (response.isPicture()) {
      items = items.sublist(0, 1);
    } else {
      while (items.length < 2) {
        List<Item> copy = List();
        copy.addAll(items);
        items.addAll(copy);
      }

      items = items.sublist(0, 2);
    }
    items.add(response);
    items.shuffle();
    return items;
  }

  void response(Item response, Item userResponse) {
    seeingByStyle.putIfAbsent(response.style, () => Set<String>());
    seeingByStyle.putIfAbsent(userResponse.style, () => Set<String>());
    seeingByStyle[response.style].add(response.categorie);
    seeingByStyle[userResponse.style].add(userResponse.categorie);

    errorsByStyle.putIfAbsent(response.style, () => 0);
    errorsByStyle.putIfAbsent(userResponse.style, () => 0);

    if (response != userResponse) {
      errorsByStyle[response.style] += 2;
      errorsByStyle[userResponse.style] += 1;
    } else if (errorsByStyle[response.style] > 0) {
      errorsByStyle[response.style] = max(0, errorsByStyle[response.style] - 1);
    }
  }

  bool isTrainingNeeded() {
    if (errorsByStyle.length == 0) {
      return false;
    }

    for (String style in errorsByStyle.keys) {
      if (errorsByStyle[style] > 0) {
        return true;
      }
    }
    return false;
  }
}
