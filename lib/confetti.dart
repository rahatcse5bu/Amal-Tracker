import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_confetti/flutter_confetti.dart';

class ConfettiPoints extends StatefulWidget {
  @override
  _ConfettiPointsState createState() => _ConfettiPointsState();
}

class _ConfettiPointsState extends State<ConfettiPoints> {
  ConfettiController? _confettiController;

  @override
  void initState() {
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 1));
    super.initState();
    _confettiController?.play();
  }

  @override
  void dispose() {
    _confettiController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(() {
      //       _confettiController?.play();
      //     });
      //   },
      //   child: Icon(Icons.add),
      // ),
      body: Center(
        child:
            // Confetti widget
            ConfettiWidget(
          confettiController: _confettiController!,
          blastDirectionality: BlastDirectionality.explosive,
          shouldLoop: false,
          maxBlastForce: 28,
          minBlastForce: 10,
          emissionFrequency: 0.32,
          numberOfParticles: 25,
          gravity: .8,
          // canvas: Size(400, 400),
          // displayTarget: bool.fromEnvironment('true'),
          colors: [
            Colors.green,
            Colors.blue,
            Colors.orange,
            Colors.purple,
            Colors.red,
            Colors.yellow,
            Colors.pink,
            Colors.cyan,
            Colors.teal,
            Colors.lime,
            Colors.amber,
            Colors.indigo,
            Colors.brown,
            Colors.grey,
            Colors.black,
          ],
        ),
      ),
    );
  }
}
