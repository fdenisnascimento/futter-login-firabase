import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:login_firebase/core/component/signature_component.dart';
import 'package:photos_saver/photos_saver.dart';

import './signature_view_model.dart';

class SignatureView extends SignatureViewModel {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scaffold(
      appBar: AppBar(
        title: Container(
          child: Row(
            children: <Widget>[
              Text("Assinatira"),
              Expanded(child: Text("20 de janeiro de 2020")),
            ],
          ),
        ),
      ),
      body: SignatureComponent(
        onSave: (denis) async {
          await PhotosSaver.saveFile(fileData: denis);
        },
        buttonClear: Text("Claer"),
        buttonSave: Text("Done"),
        textLine: Text(
          "Denis",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
        ),
      ),
    ));
  }
}
