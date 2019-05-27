import 'package:flutter/material.dart';


/*
*
* Class to handle a style figure
*
* */
class StyleFigure {
  final int id;
  final String styleFigureName;
  final String definition;
  final int difficulty;
  List<AssetImage> images;
  List<String> simpleExamples;
  List<String> rapLyrics;
  List<String> literatureQuotes;

  // Simple Constructor
  StyleFigure({
    this.id,
    this.styleFigureName,
    this.definition,
    this.difficulty,
    this.simpleExamples,
    this.rapLyrics,
    this.literatureQuotes,
    this.images
  });

  /*
  *
  *
  * */
  factory StyleFigure.fromJson(Map<String, dynamic> json) {

    final List<String> examples = json['simpleExamples'].cast<String>();
    final List<String> raps = json['rapLyrics'].cast<String>();
    final List<String> quotes = json['literatureQuotes'].cast<String>();
    final List<AssetImage> imagesList = json['images'].cast<AssetImage>();

    return new StyleFigure(
      id: json['id'],
      styleFigureName: json['styleFigureName'],
      definition: json['definition'],
      difficulty: json['difficulty'],
      simpleExamples: examples,
      rapLyrics: raps,
      literatureQuotes: quotes,
      images: imagesList
    );
  }
}