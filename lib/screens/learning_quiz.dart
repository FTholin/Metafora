import 'package:flutter/material.dart';
import 'package:metafora/blocs/bloc_provider.dart';
import 'package:metafora/blocs/level_bloc.dart';
import 'package:metafora/widgets/image_pick_quiz.dart';
import 'package:metafora/widgets/text_pick.dart';

class LearningQuiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LevelBloc bloc = BlocProvider.of<LevelBloc>(context);

    int res = bloc.getDatas();

    if (res == 0) {
      return Scaffold(
        appBar: AppBar(title: Text("Vous avez terminé")),
        body: Center(
            child: Text(
              "Félicitations !\nVous avez terminé le niveau !",
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
            ))
      );
      Navigator.pop(context);
      //_ackAlert(context);
    } else if (res == 1) {
      print("ImagePickActivity");
      return Scaffold(
          body: Center(
              child: ImagePickPage()));
    } else {
      print("TextActivity");
      return Scaffold(body: Center(child: TextPickPage()));
    }
  }
}

Future<void> _ackAlert(BuildContext context) {
  return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.red[300],
          title: Text('Bravo'),
          content: const Text("Vous avez finis le niveau"),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
  );
}
