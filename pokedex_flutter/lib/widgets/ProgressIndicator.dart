import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/Consts.dart';

class MyProgressIndicator extends StatelessWidget {
  const MyProgressIndicator({Key? key, required this.end, required this.stat, required this.color}) : super(key: key);
  final double end;
  final String stat;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
            width: 60,
            child: Text(stat,style: const TextStyle(fontSize: 14),)
        ),
        Expanded(
          child: TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeInOut,
            tween: Tween<double>(
              begin: 0,
              end: end,
            ),
            builder: (context, value, _) =>
                LinearProgressIndicator(
                  value: value,semanticsValue: end.toString(),minHeight: 10,
                  color: color,
                  backgroundColor: Colors.white,
                ),
          ),
        ),
        const SizedBox(width: 10,),
        Text((end*statDev).toInt().toString(),style: const TextStyle(fontSize: 14),),
      ],
    );
  }
}
