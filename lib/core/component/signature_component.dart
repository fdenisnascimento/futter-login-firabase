import 'package:flutter/material.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';

class SignatureComponet extends StatelessWidget {
  final _sign = GlobalKey<SignatureState>();
  final Function(dynamic) onSave;
  final color;
  final strokeWidth;

  SignatureComponet(
      {Key key,
      @required this.onSave,
      this.color = Colors.black,
      this.strokeWidth = 2})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[Expanded(child: _buildCnvas()), _buildFooter()],
      ),
    );
  }

// make canvas to draw
  Widget _buildCnvas() {
    return Container(
      child: Signature(
        color: Colors.black,
        key: _sign,
        strokeWidth: 2.0,
      ),
    );
  }

  // make de footer buttons to clear and return data
  Widget _buildFooter() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
            top: BorderSide(color: Colors.grey),
          )),
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: <Widget>[
          FlatButton(
            child: Text("Refazer"),
            onPressed: () {
              _sign.currentState.clear();
            },
          ),
          Expanded(child: Container()),
          FlatButton(
            child: Text("Concluir"),
            onPressed: () async {
              final image = await _sign.currentState.getData();
              onSave(image);
            },
          ),
        ],
      ),
    );
  }
}
