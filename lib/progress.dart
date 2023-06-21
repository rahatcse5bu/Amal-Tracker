import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'global.dart';

class Progress extends StatefulWidget {
  const Progress({super.key});

  @override
  State<Progress> createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Container(
          child: Column(children: [
            new CircularPercentIndicator(
              radius: 120.0,
              lineWidth: 16.0,
              animation: true,
              percent: 0.7,
              center: new Text(
                "70.0%",
                style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              footer: new Text(
                "Sales this week",
                style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: AppGlobal.PrimaryColor,
            ),
            SizedBox(
              height: 20,
            ),
            // SquarePercentIndicator(
            //   width: 170,
            //   height: 170,
            //   startAngle: StartAngle.bottomRight,
            //   reverse: true,
            //   borderRadius: 8,
            //   shadowWidth: 12,
            //   progressWidth: 12,
            //   shadowColor: AppGlobal.PrimaryColor.withOpacity(0.3),
            //   progressColor: AppGlobal.PrimaryColor,
            //   progress: 0.64,
            //   child: Center(
            //       child: Text(
            //     "64 %",
            //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            //   )),
            // )
          ]),
        ),
      ],
    ));
  }
}
