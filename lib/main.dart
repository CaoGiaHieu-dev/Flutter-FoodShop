import 'package:flutter/material.dart';
import 'package:foodshop/components/checkLogin.dart';
import 'package:foodshop/components/constants.dart';
import 'package:foodshop/models/user.dart';
import 'package:foodshop/screens/history/history_screens.dart';
import 'package:foodshop/user/components/userpreferences.dart';
import 'package:foodshop/user/user_screen.dart';
import 'components/user.dart';
import 'screens/home/home_screen.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await UserPrefrences().init();
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
  // #region Property
  List<Widget> listScreens = [];
  int tabIndex = 0;

  //login values
  List<User> listUser;
  String _username;
  String _password;
  bool isLogin;
  bool _isLoading;
  // #endregion 

  // #region get Storage Data
  _getStorage()
  {
    _username = UserPrefrences().getUserName; //get storage username
    _password = UserPrefrences().getPassword; //get storage password
  }
  // #endregion
 
  // #region checkLogin
  _checkLogin() async
  {
    _getStorage();
    await getUser().then
    (
      (value) => listUser =
        value.where
        (
          (element) => element.username == _username && element.password == _password //get all list and then check account to login
        ).toList()
    ).whenComplete(()  
    {
      if( listUser != null && listUser.length !=0)
      {
        setState(() 
        {
          isLogin = true;
        });
      }
      else
      {
        setState(() 
        {
          isLogin = false;  
        });
      }
      _isLoading = false;

      listScreens = 
      [
        HomeScreen(),
        HistoryScreen
        (
          isLogin: isLogin,
          listUser : listUser,
        ),
        UserScreen
        (
          listUser : listUser,
          isLogin: isLogin,
          checkLogin : () => 
          {
            _checkLogin()
          },
          isLoading : _isLoading
        ),
      ];
    });
    
  }
  // #endregion

  @override
  void initState() 
  {
    super.initState();
    _isLoading = true;
    _getStorage();
    _checkLogin();
    listScreens = 
    [
      HomeScreen(),
      HistoryScreen
      (
        isLogin: isLogin,
        listUser : listUser,
      ),
      UserScreen
      (
        listUser : listUser,
        isLogin: isLogin,
        checkLogin : () =>
        {
          _checkLogin(),
        } ,
        isLoading : _isLoading
      ),
    ];
    
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      body: _isLoading == false  
      ? CheckLogin
        (
          isLogin: isLogin, 
          child: listScreens[tabIndex]
        )
      : Center(child: CircularProgressIndicator(),),
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