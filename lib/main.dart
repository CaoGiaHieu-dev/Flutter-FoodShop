import 'package:flutter/material.dart';
import 'package:foodshop/components/constants.dart';
import 'package:foodshop/screens/history/history_screens.dart';
import 'package:foodshop/user/user_screen.dart';
import 'screens/home/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget 
{
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp
    (
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData
      (
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainScreens(),
    );
  }
}

class MainScreens extends StatefulWidget
{

  @override
  _MainScreens createState() => _MainScreens();
}

class _MainScreens extends State<MainScreens>
{
  List<Widget> originalList;
  Map<int, bool> originalDic;
  List<Widget> listScreens = [];
  List<int> listScreensIndex;
  int tabIndex = 0;
  @override
  void initState() 
  {
    super.initState();
    listScreens = 
    [
      HomeScreen(),
      HistoryScreen(),
      UserScreen(),
    ];
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      body: listScreens[tabIndex],
      bottomNavigationBar: BottomNavigationBar
      (
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[400],
        backgroundColor: kMainColor,
        currentIndex: tabIndex,
        onTap: (int index) 
        {
          setState(() 
          {
            tabIndex = index;
          });
        },
        items: 
        [
          BottomNavigationBarItem
          (
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem
          (
            icon: Icon(Icons.history),
            label: "History",
          ),
          BottomNavigationBarItem
          (
            icon: Icon(Icons.people),
            label: "User",
          ),
          // BottomNavigationBarItem
          // (
          //   icon: Icon(Icons.people),
          //   label: "User",
          // ),
        ]),
      
    );
  }
}