import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final IconData _iconData;

  ActionButton(this._iconData);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.5),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.1,
        height: MediaQuery.of(context).size.width * 0.1,
        child: IconButton(
          icon: Icon(_iconData),
          onPressed: () {},
          splashRadius: MediaQuery.of(context).size.width * 0.070,
          iconSize: MediaQuery.of(context).size.width * .085,
          color: Colors.grey,
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.5),
        ),
      ),
    );
  }
}
