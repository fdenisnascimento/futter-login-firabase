import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class _SignatureComponentPainter extends CustomPainter {
  final double strokeWidth;
  final List<Offset> points;
  final Color strokeColor;
  Paint _linePaint;
  _SignatureComponentPainter({
    @required this.points,
    @required this.strokeColor,
    @required this.strokeWidth,
  }) {
    _linePaint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null)
        canvas.drawLine(points[i], points[i + 1], _linePaint);
    }
  }

  @override
  bool shouldRepaint(_SignatureComponentPainter other) =>
      other.points != points;
}

class SignatureComponent extends StatefulWidget {
  final Color lineColor;
  final Color backgroundColor;
  final double strokeWidth;
  final CustomPainter backgroundPainter;
  final Function(Uint8List) onSave;
  final Widget buttonClear;
  final Widget buttonSave;
  final Widget textLine;

  SignatureComponent({
    @required this.buttonClear,
    @required this.buttonSave,
    @required this.textLine,
    @required this.onSave,
    this.backgroundColor = Colors.white,
    this.lineColor = Colors.black,
    this.strokeWidth = 2.0,
    this.backgroundPainter,
    Key key,
  }) : super(key: key);

  SignatureComponentState createState() => SignatureComponentState();

  static SignatureComponentState of(BuildContext context) {
    return context.findAncestorStateOfType<SignatureComponentState>();
  }
}

class SignatureComponentState extends State<SignatureComponent> {
  final globalKey = GlobalKey();
  List<Offset> _points = <Offset>[];
  _SignatureComponentPainter _painter;
  Widget _buttonClear;
  Widget _buttonSave;

  SignatureComponentState();

  Future<Uint8List> getImage() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData.buffer.asUint8List();
      return pngBytes;
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _setButtonsVisible(true);
  }

  @override
  Widget build(BuildContext context) {
    _painter = _SignatureComponentPainter(
        points: _points,
        strokeColor: widget.lineColor,
        strokeWidth: widget.strokeWidth);

    return RepaintBoundary(
      key: globalKey,
      child: Container(
        color: widget.backgroundColor,
        child: Stack(
          fit: StackFit.loose,
          overflow: Overflow.clip,
          alignment: AlignmentDirectional.bottomEnd,
          children: <Widget>[
            _buildCnvas(),
            _buildLine(),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildLine() {
    Size size = MediaQuery.of(context).size;
    return Positioned(
      width: size.width - 300,
      height: 40,
      top: (size.height - 60) / 2,
      left: 150,
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.black,
            height: 1,
          ),
          SizedBox(
            height: 10,
          ),
          widget.textLine
        ],
      ),
    );
  }

  Widget _buildCnvas() {
    return ClipRect(
      child: CustomPaint(
        painter: widget.backgroundPainter,
        foregroundPainter: _painter,
        child: GestureDetector(
            onVerticalDragStart: _onDragStart,
            onVerticalDragUpdate: _onDragUpdate,
            onVerticalDragEnd: _onDragEnd,
            onPanStart: _onDragStart,
            onPanUpdate: _onDragUpdate,
            onPanEnd: _onDragEnd),
      ),
    );
  }

  void _setButtonsVisible(bool visible) {
    setState(() {
      _buttonSave = visible ? this.widget.buttonSave : null;
      _buttonClear = visible ? this.widget.buttonClear : null;
    });
  }

  // make de footer buttons to clear and return data
  Widget _buildFooter() {
    return Container(
      height: 50,
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: <Widget>[
          FlatButton(
            child: _buttonClear,
            onPressed: () {
              _setButtonsVisible(true);
              clear();
            },
          ),
          Expanded(child: Container()),
          FlatButton(
            child: _buttonSave,
            onPressed: () async {
              _setButtonsVisible(false);
              Future.delayed(Duration(milliseconds:500)).then((_) async{
                var image = await getImage();
                widget.onSave(image);
                _setButtonsVisible(true);
              });
            },
          ),
        ],
      ),
    );
  }

  void _onDragStart(DragStartDetails details) {
    RenderBox referenceBox = context.findRenderObject();
    Offset localPostion = referenceBox.globalToLocal(details.globalPosition);
    setState(() {
      _points = List.from(_points)..add(localPostion)..add(localPostion);
    });
  }

  void _onDragUpdate(DragUpdateDetails details) {
    RenderBox referenceBox = context.findRenderObject();
    Offset localPosition = referenceBox.globalToLocal(details.globalPosition);

    setState(() {
      _points = List.from(_points)..add(localPosition);
    });
  }

  void _onDragEnd(DragEndDetails details) => _points.add(null);

  void clear() {
    setState(() {
      _points = [];
    });
  }

  bool get hasPoints => _points.length > 0;

  List<Offset> get points => _points;
}
