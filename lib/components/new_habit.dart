import 'package:flutter/material.dart';

class EnterNewHabitBox extends StatelessWidget {
  final controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const EnterNewHabitBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[800],
      content: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          hintText: "Enter a new habit...",
          hintStyle: TextStyle(color: Colors.white54),
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        MaterialButton(
          onPressed: onSave,
          color: Colors.black,
          child: Text("Save", style: TextStyle(color: Colors.white)),
        ),
        MaterialButton(
          onPressed: onCancel,
          color: Colors.black,
          child: Text("Cancel", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
