import 'package:flutter/material.dart';
import 'package:my_practice/widgets/NewDigitButton.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SudokuPlayArea(title: 'PuzBox - Sudoku'),
    );
  }
}

class SudokuPlayArea extends StatefulWidget {
  SudokuPlayArea({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SudokuPlayAreaState createState() => _SudokuPlayAreaState();
}

class _SudokuPlayAreaState extends State<SudokuPlayArea> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            Flexible(
              child: SudokuBoard(),
              flex: 7,
            ),
            Flexible(
              child: SudokuControl(),
              flex: 3,
            ),
          ],
        ));
  }
}

class SudokuBoard extends StatefulWidget {
  @override
  _SudokuBoardState createState() => _SudokuBoardState();
}

class _SudokuBoardState extends State<SudokuBoard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Placeholder(
        color: Colors.blueAccent,
      ),
    );
  }
}

class SudokuControl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 3,
            child: MovementControl(),
          ),
          Flexible(
            flex: 3,
            child: HelperTool(),
          ),
          Flexible(
            flex: 4,
            child: NumberPad(),
          )
        ],
      ),
    );
  }
}

class MovementControl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Placeholder(),
    );
  }
}

class HelperTool extends StatefulWidget {
  @override
  _HelperToolState createState() => _HelperToolState();
}

class _HelperToolState extends State<HelperTool> {
  bool isEditEnabled;

  @override
  void initState() {
    isEditEnabled = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: Icon(
                Icons.delete_outline_rounded,
                size: 30.0,
                color: Colors.grey,
              ),
              onPressed: () {},
              splashRadius: MediaQuery.of(context).size.width * 0.070,
            ),
            IconButton(
              icon: AnimatedEditIcon(isEditEnabled: isEditEnabled),
              onPressed: () {
                setState(() => isEditEnabled = !isEditEnabled);
              },
              splashRadius: MediaQuery.of(context).size.width * 0.070,
            ),
            /*IconButton(
              icon: Icon(
                Icons.edit,
                size: 30.0,
                color: isEditEnabled ? Colors.blueAccent : Colors.grey,
              ),
              onPressed: () {
                setState(() => isEditEnabled = !isEditEnabled);
              },
              splashRadius: MediaQuery.of(context).size.width * 0.070,
            )*/
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: Icon(
                Icons.undo_rounded,
                size: 30.0,
                color: Colors.grey,
              ),
              onPressed: () {},
              splashRadius: MediaQuery.of(context).size.width * 0.070,
            ),
            IconButton(
              icon: Icon(
                Icons.redo_rounded,
                size: 30.0,
                color: Colors.grey,
              ),
              onPressed: () {},
              splashRadius: MediaQuery.of(context).size.width * 0.070,
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: Icon(
                Icons.search_rounded,
                size: 30.0,
                color: Colors.grey,
              ),
              onPressed: () {},
              splashRadius: MediaQuery.of(context).size.width * 0.070,
            ),
            IconButton(
              icon: Icon(
                Icons.lightbulb_outline_rounded,
                size: 30.0,
                color: Colors.grey,
              ),
              onPressed: () {},
              splashRadius: MediaQuery.of(context).size.width * 0.070,
            )
          ],
        ),
      ],
    );
  }
}

class NumberPad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NewDigitButton("1"),
            NewDigitButton("2"),
            NewDigitButton("3"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NewDigitButton("4"),
            NewDigitButton("5"),
            NewDigitButton("6"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NewDigitButton("7"),
            NewDigitButton("8"),
            NewDigitButton("9"),
          ],
        ),
      ],
    );
  }
}

class AnimatedEditIcon extends ImplicitlyAnimatedWidget {
  final bool isEditEnabled;

  Color get targetEditColor => isEditEnabled ? Colors.indigo : Colors.grey;

  AnimatedEditIcon({@required this.isEditEnabled, Key key})
      : super(key: key, duration: Duration(milliseconds: 300));

  @override
  _AnimatedEditIconState createState() => _AnimatedEditIconState();
}

class _AnimatedEditIconState extends AnimatedWidgetBaseState<AnimatedEditIcon> {
  ColorTween _colorTween;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.edit,
      size: 30.0,
      color: _colorTween.evaluate(animation),
      // color: widget.isEditEnabled ? Colors.blueAccent : Colors.grey,
    );
  }

  @override
  void forEachTween(visitor) {
    _colorTween = visitor(_colorTween, widget.targetEditColor,
        (color) => ColorTween(begin: color));
  }
}
