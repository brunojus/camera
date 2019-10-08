// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'dart:async';
import 'login_page.dart';
import 'package:flutter/services.dart';



void main() {
  
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light
  ));

  runApp(
    MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ),
  );
}


class MyApp extends StatefulWidget{
  _MyAppState createState()=> _MyAppState();
}

class _MyAppState extends State <MyApp>{

  @override
  void initState(){
    super.initState();
    Future.delayed(Duration(seconds: 1),
    (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      },
    );
  }




  //SplashScreen 
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,     

      body: Center(
          child: Image.asset(
            'assets/images/efs.png',
            height: 500,
            width: 300,
          ),
      ),
    );
  }
}




