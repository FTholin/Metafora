import 'package:flutter/material.dart';
import 'package:metafora/blocs/bloc_provider.dart';
import 'package:metafora/blocs/level_bloc.dart';
import 'package:metafora/screens/learning_quiz.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LearningMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Apprentissage')),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 25),
                Expanded(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          textColor: Colors.black,
                          color: Colors.blue,
                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                          child: Row(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  new Image.asset('assets/nicubunu_Comic_characters_Fake_Ninja.png', width: 100.0, height: 100.0),
                                  Text("Eleve"),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  _buildImageWithLive(0),
                                ],
                              ),
                            ],
                          ),
                          onPressed: () {
                             _eleveLevel(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Expanded(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          textColor: Colors.black,
                          color: Colors.blue,
                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                          child: Row(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  new Image.asset('assets/nicubunu_Comic_characters_Profile.png', width: 100.0, height: 100.0),
                                  Text("Etudiant"),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  _buildImageWithLive(1),
                                ],
                              ),
                            ],
                          ),
                          onPressed: () {
                            // _eleveLevel(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Expanded(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          textColor: Colors.black,
                          color: Colors.blue,
                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                          child: Row(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  new Image.asset('assets/nicubunu_Comic_characters_Trekker.png', width: 100.0, height: 100.0),
                                  Text("Prof"),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  _buildImageWithLive(2),
                                ],
                              ),
                            ],
                          ),
                          onPressed: () {
                        // _eleveLevel(context);
                            },
                        ),
                    ],
                  ),
                ),
              ),
                SizedBox(height: 25),
              Expanded(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        textColor: Colors.black,
                        color: Colors.blue,
                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                        child: Row(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                new Image.asset('assets/nicubunu_Comic_characters_Gentelman.png', width: 100.0, height: 100.0),
                                Text("Maitre"),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                _buildImageWithLive(3),
                              ],
                            ),
                          ],
                        ),
                        onPressed: () {
                          // _eleveLevel(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
                SizedBox(height: 25),
            ],
          ),
         ],
        ),
      ),
    );
  }
}


void _eleveLevel(BuildContext context) {
  Navigator
      .of(context)
      .push(MaterialPageRoute(builder: (BuildContext context) {
    return BlocProvider<LevelBloc>(
      bloc: LevelBloc(),
      child: LearningQuiz(),
    );
  }));
}

Widget _buildImageWithLive(int live) {
  if (live == 3) {
    return Row (
      children: [
        Icon(FontAwesomeIcons.solidHeart),
        Icon(FontAwesomeIcons.solidHeart),
        Icon(FontAwesomeIcons.solidHeart),
      ],
    );
  }
  if (live == 2) {
    return Row(
      children: [
        Icon(FontAwesomeIcons.solidHeart),
        Icon(FontAwesomeIcons.solidHeart),
        Icon(FontAwesomeIcons.heart),
      ],
    );
  }
  if (live == 1) {
    return Row(
      children: [
        Icon(FontAwesomeIcons.solidHeart),
        Icon(FontAwesomeIcons.heart),
        Icon(FontAwesomeIcons.heart),
      ],
    );
  }
  if (live == 0) {
    return Row(
      children: [
        Icon(FontAwesomeIcons.heart),
        Icon(FontAwesomeIcons.heart),
        Icon(FontAwesomeIcons.heart),
      ],
    );
  }

}


/*


  void _openOnePage(BuildContext context) {
    Navigator
        .of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return BlocProvider<MovieCatalogBloc>(
        bloc: MovieCatalogBloc(),
        child: ListOnePage(),
      );
    }));
  }
}*/