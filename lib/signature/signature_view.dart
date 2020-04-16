import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_firebase/core/component/signature_component.dart';

import './signature_view_model.dart';

class SignatureView extends SignatureViewModel {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
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
      body: SignatureComponet(
        onSave: (image) {},
      ),
    ));
  }
}
