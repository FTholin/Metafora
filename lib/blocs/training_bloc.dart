
import 'package:metafora/blocs/bloc_provider.dart';
import 'package:metafora/models/item.dart';
import 'package:metafora/models/item_collection.dart';
import 'package:metafora/models/stats.dart';


class TrainingBloc implements BlocBase {
  Stats _stats;
  List<Item> _responses;
  List<Item> _datas;
  Item _response;
  int _indexCorrectResponse;

  ///
  /// Constructor
  ///
  TrainingBloc() {
    print("Construction de trainingBloc");
    _stats = Stats();
    return;
  }

  void initDatas() {

   _response = _stats.getResponse();

   _responses = _stats.getResponses(_response);

   if (_response.isPicture()) {
     ItemCollection collection = ItemCollection();
     _datas = List();
     _datas.add(collection.getItemsByCategorieAndStyle("classique", _response.style).first);
     _datas.add(collection.getItemsByCategorieAndStyle("rap", _response.style).first);
   }

    _indexCorrectResponse = _responses.indexOf(_response);
  }

  void dispose() {
    print("Destruction de trainingBloc");
  }

  int getDatas() {
    if (!_stats.isTrainingNeeded()) {
      return 0;
    } else {
      initDatas();
      if (_response.isPicture()) {
        return 2;
      } else {
        return 1;
      }
    }
  }

  bool isIndexCorrect(int index) {
    _stats.response(_response, _responses[index]); // for statistics
    if (index == _indexCorrectResponse) {
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

  List<Item> getResponses() {
    return _responses;
  }

  List<Item> getData() {
    return _datas;
  }

  Item getDefinition() {
    ItemCollection collection = ItemCollection();
    return collection.getItemsByCategorieAndStyle("definition", _response.style).first;
  }
}