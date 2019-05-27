import 'package:metafora/models/style_figure.dart';
import 'package:flutter/material.dart';

/*
*
* Abstract class to handle an activity
*
* */
abstract class Activity {

  int difficulty;
  String openingSentence;
  StyleFigure activityStyleFigure;

  bool isSucceeded;


  Activity({
      this.difficulty,
      this.openingSentence,
      this.activityStyleFigure,
      this.isSucceeded = false
  });

  /*
  *
  * In this method we will check if goodAnswers == selectedChoices
  *
  * */
  //void checkActivitySuccess();
}


/*
*
* First activity class model
*
* */
class ImagePickActivity extends Activity {

  List activityChoices;
  List selectedChoices;
  List goodAnswers;

  ImagePickActivity({
    int difficulty,
    String openingSentence,
    StyleFigure activityStyleFigure,
    this.activityChoices,
    this.selectedChoices,
    this.goodAnswers,
  }) :super(
    difficulty: difficulty,
    openingSentence: openingSentence,
    activityStyleFigure: activityStyleFigure,
  );

  factory ImagePickActivity.fromJson(Map<String, dynamic> json) {
    final List<AssetImage> activityChoicesFromJson = json['activityChoices']
        .cast<AssetImage>();
    final List<AssetImage> selectedChoicesFromJson = json['selectedChoices']
        .cast<AssetImage>();
    final List<AssetImage> goodAnswersFromJson = json['goodAnswers'].cast<
        AssetImage>();
    return new ImagePickActivity(
        difficulty: json['difficulty'],
        openingSentence: json['openingSentence'],
        activityStyleFigure: StyleFigure.fromJson(json['activityStyleFigure']),
        activityChoices: activityChoicesFromJson,
        selectedChoices: selectedChoicesFromJson,
        goodAnswers: goodAnswersFromJson
    );
  }

}

/*
*
* Second activity class model
*
* */
class DefinitionPickActivity extends Activity {

  List activityChoices;
  List selectedChoices;
  List goodAnswers;

  DefinitionPickActivity({
    int difficulty,
    String openingSentence,
    StyleFigure activityStyleFigure,
    this.activityChoices,
    this.selectedChoices,
    this.goodAnswers,
  }) :super(
    difficulty: difficulty,
    openingSentence: openingSentence,
    activityStyleFigure: activityStyleFigure,
  );

  factory DefinitionPickActivity.fromJson(Map<String, dynamic> json) {
    final List<String> activityChoicesFromJson = json['activityChoices']
        .cast<String>();
    final List<String> selectedChoicesFromJson = json['selectedChoices']
        .cast<String>();
    final List<String> goodAnswersFromJson = json['goodAnswers'].cast<
        String>();
    return new DefinitionPickActivity(
        difficulty: json['difficulty'],
        openingSentence: json['openingSentence'],
        activityStyleFigure: StyleFigure.fromJson(json['activityStyleFigure']),
        activityChoices: activityChoicesFromJson,
        selectedChoices: selectedChoicesFromJson,
        goodAnswers: goodAnswersFromJson
    );
  }

}