import 'package:flutter/material.dart';

/*
  Padding Issue
 */
class DigitButton extends StatelessWidget {
  final String number;

  DigitButton(this.number);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      shape: CircleBorder(),
      elevation: 5.0,
      fillColor: Colors.white,
      child: RichText(
        text: TextSpan(
          text: number,
          style: TextStyle(color: Colors.blueAccent, fontSize: 24.0),
        ),
      ),
      onPressed: () => {},
    );
  }
}
