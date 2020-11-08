import 'package:flutter/material.dart';

/*
  Suitable one
 */
class NewDigitButton extends StatelessWidget {
  final String _number;

  NewDigitButton(this._number);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 3),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.1,
        height: MediaQuery.of(context).size.width * 0.1,
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Text(
            _number,
            style: TextStyle(
              color: Colors.blueAccent,
              fontSize: MediaQuery.of(context).size.width * 0.085,
            ),
            textAlign: TextAlign.center,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
