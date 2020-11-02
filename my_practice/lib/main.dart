import 'package:flutter/material.dart';
// import 'package:my_practice/widgets/DigitButton';

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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              NewDigitButton("10"),
              NewDigitButton("11"),
              NewDigitButton("12"),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              NewDigitButton("13"),
              NewDigitButton("14"),
              NewDigitButton("15"),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              NewDigitButton("16"),
              NewDigitButton("17"),
              NewDigitButton("18"),
            ],
          ),
        ),
      ],
    );
  }
}

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

/*
  Suitable one
 */
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
