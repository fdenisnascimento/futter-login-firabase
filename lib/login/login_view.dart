import 'package:flutter/material.dart';
import './login_view_model.dart';

class LoginView extends LoginViewModel {
  @override
  Widget build(BuildContext context) {
    // Replace this with your build function
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("Login with Firebase"),
        ),
      ),
    );
  }
}
