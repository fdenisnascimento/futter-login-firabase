import 'package:flutter/material.dart';
import 'package:login_firebase/core/component/navigator.dart';
import 'package:login_firebase/signature/signature.dart';
import './login_view_model.dart';

class LoginView extends LoginViewModel {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((_) {
      NavigatorManager.to(context, Signature());
    });
  }

  @override
  Widget build(BuildContext context) {
    // Replace this with your build function
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Text("Assinatira"),
              Expanded(child: Text("20 de janeiro de 2020")),
            ],
          ),
        ),
        body: Container(
          child: Center(
            child: Text("Login with Firebase"),
          ),
        ),
      ),
    );
  }
}
