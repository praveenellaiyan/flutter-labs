import 'package:flutter/material.dart';
/*
  Suitable one
 */
class NewDigitButton extends StatelessWidget {
  final String number;

  NewDigitButton(this.number);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 2.5),
      child: Container(
          width: MediaQuery.of(context).size.width * 0.1,
          height: MediaQuery.of(context).size.width * 0.1,
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
