import 'package:flutter/material.dart';
import 'package:metafora/blocs/bloc_provider.dart';
import 'package:metafora/blocs/training_bloc.dart';
import 'package:metafora/models/item.dart';
import 'package:metafora/screens/training_quiz.dart';

class TrainingPage extends StatelessWidget {
  TrainingBloc bloc;

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<TrainingBloc>(context);

    List<Item> responses = bloc.getResponses();

    return Scaffold(
      appBar: AppBar(
        title: Text("Révision"),
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
                    fontWeight: FontWeight.bold, color: Colors.blue,),
                ),
                new Text(
                  bloc.getDefinition().style,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.blue,
                    fontSize: 30.0,),
                ),
              ],
            ),
            new Container(
              padding: EdgeInsets.all(8.0),
              child: InkWell(
                  onTap : null,
                  child: new Theme(
                    data: new ThemeData(hintColor: Colors.blue),
                    child: new InputDecorator(
                      decoration: new InputDecoration(
                          labelText: 'Définition', border: OutlineInputBorder()),
                      child: Text(
                        bloc.getDefinition().text,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                    ),
                  )
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: InkWell(
                  onTap:null,
                  child: new Theme(
                    data: new ThemeData(hintColor: Colors.blue),
                    child: new InputDecorator(
                      decoration: new InputDecoration(
                          labelText: 'Choix', border: OutlineInputBorder()),
                      child: new Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10.0),
                            child: ButtonTheme(
                                minWidth: MediaQuery.of(context).size.width / 1.2,
                                child: RaisedButton(
                                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    responses[0].text,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                  onPressed: () {
                                    _ackAlert(context, bloc.isIndexCorrect(0));
                                  },
                                )
                            ),
//                              width: MediaQuery.of(context).size.width / 1.2
                          ),
                          Container(
                            padding: EdgeInsets.all(10.0),
                            child: ButtonTheme(
                                minWidth: MediaQuery.of(context).size.width / 1.2,
                                child: RaisedButton(
                                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    responses[1].text,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                  onPressed: () {
                                    _ackAlert(context, bloc.isIndexCorrect(1));
                                  },
                                )
                            ),
//                            width:  MediaQuery.of(context).size.width / 1.2,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: ButtonTheme(
                                padding: EdgeInsets.all(10.0),
                                minWidth: MediaQuery.of(context).size.width / 1.2,
                                child: RaisedButton(
                                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    responses[2].text,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, color: Colors.white),
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
      return BlocProvider<TrainingBloc>(
        bloc: bloc,
        child: TrainingQuiz(),
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
