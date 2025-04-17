import 'package:flutter/material.dart';

class MyFloatActionButton extends StatelessWidget {
  final Function()? onPressed;
  const MyFloatActionButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(onPressed: onPressed, child: Icon(Icons.add));
  }
}
