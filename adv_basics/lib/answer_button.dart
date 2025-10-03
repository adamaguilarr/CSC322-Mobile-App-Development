import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton({
  super.key,
  required this.answerText, 
  required this.onTap,
  });

  final String answerText;
  final void Function() 
  onTap;

  @override
  Widget build(BuildContext contex) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        backgroundColor: const Color.fromARGB(255, 85, 35, 170),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
      ),
      child: Text(answerText,
      textAlign: TextAlign.center,
      ),
    );
  }
}