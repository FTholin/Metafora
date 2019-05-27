
import 'package:metafora/blocs/bloc_provider.dart';
import 'package:metafora/models/item.dart';
import 'package:metafora/models/item_collection.dart';
import 'package:metafora/models/level_collection.dart';
import 'package:metafora/models/personal_level.dart';
import 'package:metafora/models/stats.dart';


class LevelBloc implements BlocBase {
  PersonalLevel personalLevel;
  List<Item> _data;
  List<Item> _responses;
  Item _response;
  int _indexCorrectResponse;

  ///
  /// Constructor
  ///
  LevelBloc() {
    print("Construction de levelBloc");
    LevelCollection collection = LevelCollection();
    personalLevel = PersonalLevel(collection.levels[0]);
    return;
  }

  void initDatas() {
    ItemCollection itemsCollection = ItemCollection();

    _response = personalLevel.getQuestion();

    List<Item> tempData;
    List<Item> tempRespons;

    if (_response.isPicture()) {
      tempData = itemsCollection.getItemsByCategorieAndStyle(
          _response.categorie, _response.style);

      tempData.shuffle();
      tempData.remove(_response);
      _data = tempData.sublist(0, 1);

      tempRespons = itemsCollection.getItemsByCategorie(_response.categorie);

      tempRespons.remove(_data[0]);
      tempRespons.remove(_response);
      tempRespons.shuffle();
      _responses = tempRespons.sublist(0, 1);
      _responses.add(_response);
      _responses.shuffle();

    } else {
      tempData = itemsCollection.getItemsByCategorieAndStyle("image", _response.style);
      tempData.shuffle();
      _data = tempData.sublist(0, 1);

      if (_response.categorie == "definition") {
        tempRespons = itemsCollection.getItemsByCategorie(_response.categorie);
      } else {
        List<String> categories =
        personalLevel.getLevel().getAllCategories(_response.style);

        tempRespons = List();

        for (String categorie in categories) {
          if (categorie != 'image' && categorie != 'definition') {
            tempRespons.addAll(itemsCollection.getItemsByCategorie(categorie));
          }
        }
      }

      tempRespons.remove(_response);
      tempRespons.shuffle();
      _responses = tempRespons.sublist(0, 2);
      _responses.add(_response);
      _responses.shuffle();
    }


    _indexCorrectResponse = _responses.indexOf(_response);
  }

  void dispose() {
    print("Destruction de levelBloc");
  }

  int getDatas() {
    if (personalLevel.getNbRemainingQuestions() == 0) {
      return 0;
    } else {
      initDatas();
      return _response.isPicture() ? 1 : 2;
    }
  }

  bool isIndexCorrect(int index) {
    Stats().response(_response, _responses[index]); // for statistics
    if (index == _indexCorrectResponse) {
      personalLevel.markQuestionAsCompleted(_response);
      return true;
    } else {
      return false;
    }
  }

  String getCategorieResponse() {
    return _response.categorie;
  }

  String getStyleResponse() {
    return _response.style;
  }

  List<Item> getData() {
    return _data;
  }

  List<Item> getResponses() {
    return _responses;
  }
}