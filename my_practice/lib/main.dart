import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_practice/widgets/action_button.dart';
import 'package:my_practice/widgets/digit_button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.indigo,
        canvasColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SudokuPlayArea(title: 'Sudoku'),
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
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: IconButton(
              icon: Icon(Icons.favorite_border_rounded),
              onPressed: () {},
              splashRadius: 20.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: IconButton(
              icon: Icon(Icons.color_lens_outlined),
              onPressed: () {},
              splashRadius: 20.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {},
              splashRadius: 20.0,
            ),
          ),
        ],
        leading: Icon(Icons.apps_rounded),
        titleSpacing: 2.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlineButton(
                child: Text(
                  "Medium",
                  style: TextStyle(color: Colors.indigo),
                ),
              ),
              Icon(
                Icons.supervisor_account_rounded,
                color: Colors.indigo,
              ),
              FlatButton.icon(
                icon: Icon(
                  Icons.access_time,
                  color: Colors.indigo,
                ),
                label: Text(
                  "09:54",
                  style: TextStyle(
                    decorationColor: Colors.indigo,
                  ),
                ),
                onPressed: () {},
                color: Colors.white70,
                padding: const EdgeInsets.only(),
              ),
            ],
          ),
          Expanded(child: SudokuBoard()),
          Expanded(
            child: PageView(
                controller: _pageController,
                scrollDirection: Axis.vertical,
                children: [
                  SudokuControl(),
                  SudokuControl(),
                ]),
            // flex: 3,
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
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
        color: Colors.indigo,
        fallbackHeight: MediaQuery
            .of(context)
            .size
            .height * 0.56,
      ),
    );
  }
}

class SudokuControl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: MovementControl(),
            ),
            Expanded(
              flex: 3,
              child: HelperTool(),
            ),
            Expanded(
              flex: 4,
              child: NumberPad(),
            )
          ],
        ),
        Flexible(
          child: Opacity(
            opacity: .3,
            child: Divider(
              height: 2.5,
              color: Colors.indigo,
              thickness: 3.5,
              endIndent: 100.0,
              indent: 100.0,
            ),
          ),
        ),
      ],
    );
  }
}

class MovementControl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ActionButton(Icons.label),
            /*Transform.rotate(
                angle: 90 * pi / 180, child: ActionButton(Icons.label)),*/
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            /*Transform.rotate(
                angle: 360 * pi / 180, child: ActionButton(Icons.label)),
            Transform.rotate(
                angle: 180 * pi / 180, child: ActionButton(Icons.label)),*/
            ActionButton(Icons.label),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ActionButton(Icons.label),
            /*Transform.rotate(
                angle: 270 * pi / 180, child: ActionButton(Icons.label)),*/
          ],
        ),
      ],
    );
  }
}

class HelperTool extends StatefulWidget {
  @override
  _HelperToolState createState() => _HelperToolState();
}

class _HelperToolState extends State<HelperTool> {
  bool isEditEnabled;
  int undoCount;

  @override
  void initState() {
    isEditEnabled = false;
    undoCount = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ActionButton(Icons.delete_outline_rounded),
            ActionButton(Icons.edit),
            /*
            IconButton(
              icon: AnimatedEditIcon(isEditEnabled: isEditEnabled),
              onPressed: () {
                setState(() => isEditEnabled = !isEditEnabled);
              },
              splashRadius: MediaQuery.of(context).size.width * 0.070,
            ),*/
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ActionButton(Icons.undo_rounded),
            ActionButton(Icons.redo_rounded),
            /*
            IconButton(
              icon: AnimatedUndoIcon(undoCount: undoCount),
              onPressed: () {
                setState(() => undoCount = undoCount + 1);
              },
              splashRadius: MediaQuery.of(context).size.width * 0.070,
            ),*/
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ActionButton(Icons.search_rounded),
            ActionButton(Icons.lightbulb_outline_rounded),
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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NewDigitButton("1"),
            NewDigitButton("2"),
            NewDigitButton("3"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NewDigitButton("4"),
            NewDigitButton("5"),
            NewDigitButton("6"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
    );
  }

  @override
  void forEachTween(visitor) {
    _colorTween = visitor(_colorTween, widget.targetEditColor,
            (color) => ColorTween(begin: color));
  }
}

/*
 If the begin and end color is same then lerp won't be visible
 */
class AnimatedUndoIcon extends ImplicitlyAnimatedWidget {
  final int undoCount;

  //TODO check using Animation controller rather with ColorTween
  Color get targetUndoColor => undoCount == 0 ? Colors.grey : Colors.grey;

  AnimatedUndoIcon({@required this.undoCount, Key key})
      : super(key: key, duration: Duration(milliseconds: 300));

  @override
  _AnimatedUndoIconState createState() => _AnimatedUndoIconState();
}

class _AnimatedUndoIconState extends AnimatedWidgetBaseState<AnimatedUndoIcon> {
  CustomUndoTween _colorTween;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.undo_rounded,
      size: 30.0,
      color: _colorTween.evaluate(animation),
    );
  }

  @override
  void forEachTween(visitor) {
    _colorTween = visitor(_colorTween, widget.targetUndoColor,
            (color) => CustomUndoTween(begin: color));
  }
}

class CustomUndoTween extends Tween<Color> {
  final Color middle = Colors.indigo;

  CustomUndoTween({Color begin, Color end}) : super(begin: begin, end: end);

  @override
  Color lerp(double t) {
    if (t < 0.5) {
      return Color.lerp(begin, middle, t * 2);
    } else {
      return Color.lerp(middle, end, (t - 0.5) * 2);
    }
  }
}
