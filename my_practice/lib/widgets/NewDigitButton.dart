import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

class NewDigitButton extends StatelessWidget {
  final String number;

  NewDigitButton(this.number);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 0.0, top: 1.0, right: 8.0, bottom: 0.0),
      child: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          child: SizedBox(
              child: FloatingActionButton(
            backgroundColor: Colors.white,
            child: RichText(
              text: TextSpan(
                text: number,
                style: TextStyle(color: Colors.blueAccent, fontSize: 28.0),
              ),
            ),
            onPressed: () {},
          ))),
    );
  }
}
