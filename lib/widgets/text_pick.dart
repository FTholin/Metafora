import 'package:flutter/material.dart';
import 'package:metafora/blocs/bloc_provider.dart';
import 'package:metafora/blocs/level_bloc.dart';
import 'package:metafora/models/item.dart';
import 'package:metafora/screens/learning_quiz.dart';
import 'package:metafora/widgets/hero_photo_viewer.dart';

class TextPickPage extends StatelessWidget {
  LevelBloc bloc;

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<LevelBloc>(context);
    List<Item> data = bloc.getData();
    List<Item> responses = bloc.getResponses();
    int nbQuestionsRestantes = bloc.personalLevel.getNbQuestions() -
        bloc.personalLevel.getNbRemainingQuestions() +
        1;
    int nbQuestions = bloc.personalLevel.getNbQuestions();

    return Scaffold(
      appBar: AppBar(
        title: Text("Question " +
            nbQuestionsRestantes.toString() +
            "/" +
            nbQuestions.toString()),
        leading: new IconButton(
          icon: new Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Column(
              children: <Widget>[
                new Text(
                  "Choisis la figure de style correspondante:",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                new Text(
                  bloc.getStyleResponse(),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 30.0,
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: null,
                  child: new Theme(
                    data: new ThemeData(hintColor: Colors.blue),
                    child: new InputDecorator(
                      decoration: new InputDecoration(
                          labelText: 'Exemple', border: OutlineInputBorder()),
                      child: new Column(
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HeroPhotoViewWrapper(
                                          imageProvider:
                                              AssetImage(data[0].pathToPicture),
                                        ),
                                  ));
                            },
                            child: Container(
                              child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 4,
                                  padding: EdgeInsets.all(2.0),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    child: Image.asset(data[0].pathToPicture,
                                        fit: BoxFit.cover),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: null,
                  child: new Theme(
                    data: new ThemeData(hintColor: Colors.blue),
                    child: new InputDecorator(
                      decoration: new InputDecoration(
                          labelText: 'Choix', border: OutlineInputBorder()),
                      child: new Column(
//                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10.0),
                            child: ButtonTheme(
                                minWidth:
                                    MediaQuery.of(context).size.width / 1.2,
                                child: RaisedButton(
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(10.0)),
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    responses[0].text,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  onPressed: () {
                                    _ackAlert(context, bloc.isIndexCorrect(0));
                                  },
                                )),
//                              width: MediaQuery.of(context).size.width / 1.2
                          ),
                          Container(
                            padding: EdgeInsets.all(10.0),
                            child: ButtonTheme(
                                minWidth:
                                    MediaQuery.of(context).size.width / 1.2,
                                child: RaisedButton(
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(10.0)),
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    responses[1].text,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  onPressed: () {
                                    _ackAlert(context, bloc.isIndexCorrect(1));
                                  },
                                )),
//                            width:  MediaQuery.of(context).size.width / 1.2,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: ButtonTheme(
                                padding: EdgeInsets.all(10.0),
                                minWidth:
                                    MediaQuery.of(context).size.width / 1.2,
                                child: RaisedButton(
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(10.0)),
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    responses[2].text,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  onPressed: () {
                                    _ackAlert(context, bloc.isIndexCorrect(2));
                                  },
                                )),
                          )
                        ],
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void _nextActivity(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
      return BlocProvider<LevelBloc>(
        bloc: bloc,
        child: LearningQuiz(),
      );
    }));
  }

  Future<void> _ackAlert(BuildContext context, bool succeeded) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        if (succeeded) {

          return AlertDialog(
            backgroundColor: Colors.green[200],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            title: Text(
              'Félicitation !',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.green[800]),
            ),
            content: Text(
                "Nous sommes d'accord sur cette figure de style",
                style: TextStyle(color: Colors.green[800])),
            actions: <Widget>[
              RaisedButton(
                textColor: Colors.white,
                color: Colors.green[600],
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0)),
                child: Text('Continuer'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _nextActivity(context);
                },
              )
            ],
          );

        } else {
          return AlertDialog(
            backgroundColor: Colors.red[200],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            title: Text(
              'Dommage ',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.red[800]),
            ),
            content: Text(
                "Nous ne sommes pas d'accord sur cette figure de style.",
                style: TextStyle(color: Colors.red[800])),
            actions: <Widget>[
              RaisedButton(
                textColor: Colors.white,
                color: Colors.red[600],
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0)),
                child: Text('Continuer'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
      },
    );
  }
}
