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
    return Placeholder(
      color: Colors.blueAccent,
    );
  }
}

class SudokuControl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            NewDigitButton("1"),
            NewDigitButton("2"),
            NewDigitButton("3"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            NewDigitButton("4"),
            NewDigitButton("5"),
            NewDigitButton("6"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
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
