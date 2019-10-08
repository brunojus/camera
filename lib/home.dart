import 'package:flutter/material.dart';
import 'utils/colors.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Home',
              textAlign: TextAlign.center,    
              style: TextStyle(color:Colors.white,
                            fontFamily: 'Poppins-Bold',
                            fontSize: 18,
                            letterSpacing: 1.0
              ),  
          ),
        ),
        backgroundColor:HexColor('#55113A'),
        automaticallyImplyLeading: false,
        ),
        backgroundColor: HexColor('#B8AFAF').withOpacity(0.2),
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