import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final IconData _iconData;

  ActionButton(this._iconData);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FlatButton(
        child: Icon(
          _iconData,
          // size: 28.0,
          color: Colors.grey,
        ),
        onPressed: () {},
        padding: const EdgeInsets.only(right: 2.0),
      ),
    );

    /*return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.12,
        height: MediaQuery.of(context).size.width * 0.12,
        child: FlatButton(
          child: Icon(
            _iconData,
            size: MediaQuery.of(context).size.width * 0.1,
            color: Colors.grey,
          ),
          onPressed: () {},
          padding: const EdgeInsets.symmetric(
              vertical: 2.0,
              horizontal: 2.0
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height * 0.015))
          ),
        ),
      ),
    );*/
  }
}
