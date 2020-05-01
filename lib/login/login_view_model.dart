import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './login.dart';

abstract class LoginViewModel extends State<Login> {
  // Add your state and logic here  
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  }

  void processLogin(){

  }
}
