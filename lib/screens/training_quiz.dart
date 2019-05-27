import 'package:flutter/material.dart';
import 'package:metafora/blocs/bloc_provider.dart';
import 'package:metafora/blocs/level_bloc.dart';
import 'package:metafora/blocs/training_bloc.dart';
import 'package:metafora/widgets/image_pick_quiz.dart';
import 'package:metafora/widgets/rosetta_page.dart';
import 'package:metafora/widgets/text_pick.dart';
import 'package:metafora/widgets/training_page.dart';

class TrainingQuiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TrainingBloc bloc = BlocProvider.of<TrainingBloc>(context);

    int res = bloc.getDatas();

    if (res == 0) {
      return Scaffold(
          appBar: AppBar(title: Text("Terminé !")),
          body: Center(
              child: Text(
            "Nous n'avons plus de questions à vous posez !",
            textAlign: TextAlign.center,
            overflow: TextOverflow.clip,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
          )));
    } else if (res == 1) {
      return Scaffold(body: Center(child: TrainingPage()));
    } else {
      return  Scaffold(body: Center(child: RosettaActivityPage()));
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
      });
}
