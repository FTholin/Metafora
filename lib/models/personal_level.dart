import 'package:metafora/models/item.dart';
import 'package:metafora/models/item_collection.dart';
import 'package:metafora/models/level.dart';
import 'package:metafora/models/rate_tuple.dart';

class PersonalLevel {
  Level _level;
  bool _complete;
  List<Item> _questions;
  List<Item> _questionsCompleted;

  PersonalLevel(Level level) {
    _level = level;
    _complete = false;
    _questions = List();
    _questionsCompleted = List();
    generateQuestions();
  }

  int getNbQuestions() {
    return _questions.length + _questionsCompleted.length;
  }

  int getNbRemainingQuestions() {
    return _questions.length;
  }

  Item getQuestion() {
    return _questions.first;
  }

  void markQuestionAsCompleted(Item question) {
    _questions.remove(question);
    _questionsCompleted.add(question);

  }

  void generateQuestions() {
    ItemCollection itemCollection = ItemCollection();

    for (String style in _level.getAllStyles()) {
      int nbStyle = (_level.getNbQuestions() * (_level.getRate(style) / 100)).round();

      for (RateTuple rateTuple in _level.getCategorieRate(style)) {
        int nbCategorie = (nbStyle * (rateTuple.rate / 100)).round();

        List<Item> items = itemCollection.getItemsByCategorieAndStyle(rateTuple.categorie, style);

        items.shuffle();

        if (items.length < nbCategorie) {
          print("!!! Level " + _level.getLevelNumber().toString() + " required " + nbCategorie.toString() + " items but got only " + items.length.toString() + " items.");
          nbCategorie = items.length;
        } else {
          items.removeRange(nbCategorie, items.length);
        }

        _questions.addAll(items);
      }
    }

    _questions.shuffle();
  }

  Level getLevel() { return _level; }

  bool isComplete() { return _complete; }

  List<Item> getQuestions() { return _questions; }

  List<Item> getCompletedQuestions() { return _questionsCompleted; }
}