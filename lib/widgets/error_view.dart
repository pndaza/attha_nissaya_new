import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({Key? key, this.object, this.stackTrace}) : super(key: key);

  final Object? object;
  final StackTrace? stackTrace;

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("something's wrong."),
    );
  }
}
