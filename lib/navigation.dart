import 'package:flutter/material.dart';
import 'home.dart';
import 'camera.dart';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {

  int _selectedPage = 0;
  final _pageOptions = [
    HomePage(),
    Camera(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOptions[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        type:BottomNavigationBarType.fixed,
        currentIndex: _selectedPage ,
        onTap: (int index){
          setState(() {
            _selectedPage = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            title: Text('Camera')
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.dashboard),
          //   title: Text('Dashboard')
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.battery_std),
          //   title: Text('View')
          // ),

        ],
      ),
    );
  }
}