import 'package:flutter/material.dart';
import 'package:metafora/blocs/training_bloc.dart';
import 'package:metafora/screens/learning_menu.dart';
import 'package:metafora/blocs/bloc_provider.dart';
import 'package:metafora/screens/training_quiz.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Image.asset('assets/logo-metafora.png',
                width: 150.0, height: 150.0),
            Column(
              children: <Widget>[
                Container(
                  padding: new EdgeInsets.all(30.0),
                  child: Text(
                      "Bienvenue sur l'application qui va te faire aimer la langue Francaise. \n\n"
                      "Tu verras qu'elle n'est pas si complexe que ca avec de l'entrainement ! \n\n"
                      "Tu peux choisir le type d'exercice que tu souhaites ! "),
                ),
              ],
            ),
            ButtonTheme(
                minWidth: MediaQuery.of(context).size.width / 2,
                child: RaisedButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0)),
                  textColor: Colors.white,
                  color: Colors.blue,
                  child: Text('Apprentissage'),
                  onPressed: () {
                    _learningPage(context);
                  },
                )),
            ButtonTheme(
                minWidth: MediaQuery.of(context).size.width / 2,
                child: RaisedButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0)),
                  textColor: Colors.white,
                  color: Colors.blue,
                  child: Text('Révision'),
                  onPressed: () {
                    _trainingPage(context);
                  },
                )),
            ButtonTheme(
                minWidth: MediaQuery.of(context).size.width / 2,
                child: RaisedButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0)),
                  textColor: Colors.white,
                  color: Colors.blue,
                  child: Text('Jeux'),
                  onPressed: () {
                    /*
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return MaterialApp(
                        title: 'Image/Detail Demo',
                        home: HeroExample(),
                      );
                    }));
                    */
                  },
                )),
          ],
        ),
      ),
    );
  }
}

void _learningPage(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
    return Scaffold(body: LearningMenu());
  }));
}

void _trainingPage(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
    return BlocProvider<TrainingBloc>(
      bloc: TrainingBloc(),
      child: TrainingQuiz(),
    );
  }));
}
