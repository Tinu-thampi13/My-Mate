import 'package:flutter/material.dart';

import 'my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // get user input
            TextField(
                style: const TextStyle(color: Colors.black),
                controller: controller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Add a new task",
                    hintStyle: TextStyle(fontSize: 15.0, color: Colors.black)),
                autofocus: true),

            // buttons -> save + cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // save button
                MyButton(
                  text: "Save",
                  onPressed: onSave,
                  color: Colors.white,
                ),

                const SizedBox(width: 8),

                // cancel button
                MyButton(
                    text: "Cancel", onPressed: onCancel, color: Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
