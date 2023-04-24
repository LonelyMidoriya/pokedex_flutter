import 'package:flutter/material.dart';

class CircularIndicatorWidget extends StatefulWidget {
  final Future<void>? loadData;
  final Widget content;
  final EdgeInsets padding;
  final bool hasInternet;

  CircularIndicatorWidget({
    required this.loadData,
    required this.content,
    this.padding = EdgeInsets.zero,
    this.hasInternet = true,
  });

  @override
  State<StatefulWidget> createState() => _CircularIndicatorWidgetState();
}

class _CircularIndicatorWidgetState extends State<CircularIndicatorWidget> {
  @override
  Widget build(BuildContext context) => FutureBuilder(
    future: widget.loadData,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done &&
          widget.hasInternet) {
        return widget.content;
      } else {
        return Padding(
          padding: widget.padding,
          child: const Center(child: CircularProgressIndicator.adaptive()),
        );
      }
    },
  );
}