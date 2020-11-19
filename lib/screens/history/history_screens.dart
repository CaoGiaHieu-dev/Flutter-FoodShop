
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:foodshop/models/user.dart';
import 'package:foodshop/screens/history/listhistory.dart';
import '../appbar.dart';
import '../header.dart';


class HistoryScreen extends StatefulWidget
{
  final bool isLogin;
  final List<User> listUser;
  HistoryScreen
  (
    {
      Key key,
      @required this.isLogin,
      @required this.listUser,
    }
  ) : super (key: key) ;
  @override
  _HistoryScreen createState() => _HistoryScreen(isLogin,listUser);
}

class _HistoryScreen extends State<HistoryScreen>
{
  
  // #region property
  GlobalKey<ScaffoldState> _scaffold = GlobalKey();
  bool isLogin ;
  List<User> listUser;
  // #endregion
  // #region Appbar custom
  _HistoryScreen(this.isLogin,this.listUser) 
  {
    searchBar = new SearchBar
    (
      inBar: false,
      setState: setState,
      onSubmitted: print,
      buildDefaultAppBar: appbar
    );
  }
  // #endregion

  // #region State
  @override
  void initState()
  {
    super.initState();
  }
  // #endregion
  
  @override
  Widget build (BuildContext context) 
  {
    Size size = MediaQuery.of(context).size;
    //Start coding ...
    return new Scaffold
    (
      appBar:searchBar.build(context),

      key: _scaffold,

      body: SingleChildScrollView
      (
        child : Column
        (
          children : <Widget>
          [
            Header(size: size),
            Container
            (
              child: Column
              (
                children: <Widget>
                [
                  Align
                  (
                    alignment: Alignment.center,
                    child: Text
                    (
                      "Your History",
                      style: TextStyle
                      (
                        fontSize: 36
                      ),
                    ),
                  ),
                  isLogin == true
                  ? ListHistory
                  (
                    size: size,
                    userId : listUser.first.id,
                  )
                  : Center
                  (
                    child: Text
                    (
                      "you wasn't login"
                    ),
                  )
                ],
              ),
            )
          ]
        ),
      )
    );
  }
}