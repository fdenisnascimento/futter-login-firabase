import 'package:flutter/material.dart';

import './login_view_model.dart';

class LoginView extends LoginViewModel {
  @override
  Widget build(BuildContext context) {
    // Replace this with your build function
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[_buildHeader(), _buildForm()],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(            
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Container(child: Image.asset('images/image_header.png')),
          Container(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Center(
                  child: Container(
                    width: 120,
                    height: 120,
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.3),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.3),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: 80,
                    height: 80,
                    child: ClipOval(
                      child: Image.asset(
                        "images/avatar.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Container(
      padding: EdgeInsets.only(top: 30, left: 40, right: 40, bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
              child: Text(
            "Bem vindo",
            style: TextStyle(color: Colors.grey, fontSize: 24),
          )),
          SizedBox(
            height: 10,
          ),
          Container(
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(80)),
                  contentPadding: EdgeInsets.all(0),
                  hintText: "Email",
                  prefixIcon: Icon(
                    Icons.mail,
                    color: Colors.green,
                    size: 25,
                  )),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: TextFormField(
              style: TextStyle(fontSize: 20.0),
              obscureText: true,
              decoration: InputDecoration(
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(80)),
                  contentPadding: EdgeInsets.all(0),
                  hintText: "Email",
                  prefixIcon: Icon(
                    Icons.vpn_key,
                    color: Colors.green,
                    size: 25,
                  )),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          RaisedButton(
            elevation: 0,
            onPressed: processLogin,
            textColor: Colors.white,
            padding: EdgeInsets.all(0.0),
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(80.0)),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF50C9C3),
                    Color(0xFF50C9C3),
                  ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(80.0)),
              ),
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child:
                  Center(child: Text("Entar", style: TextStyle(fontSize: 20))),
            ),
          )
        ],
      ),
    );
  }
}
