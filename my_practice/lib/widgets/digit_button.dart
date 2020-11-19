import 'package:flutter/material.dart';

/*
  Suitable one
 */
class NewDigitButton extends StatelessWidget {
  final String _number;

  NewDigitButton(this._number);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FlatButton(
        child: Text(
          _number,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 20.0,
          ),
          textAlign: TextAlign.center,
        ),
        onPressed: () {},
      ),
    );

    /*return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.11,
        height: MediaQuery.of(context).size.width * 0.12,
        child: FlatButton(
          child: Text(
            _number,
            style: TextStyle(
              color: Colors.grey,
              fontSize: MediaQuery.of(context).size.width * 0.1,
            ),
            textAlign: TextAlign.center,
          ),
          onPressed: () {},
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(
                      MediaQuery.of(context).size.height * 0.015
                  )
              )
          ),
        ),
      ),
    );*/
  }
}
