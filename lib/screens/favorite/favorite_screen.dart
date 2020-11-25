import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodshop/components/constants.dart';
import 'package:foodshop/models/user.dart';
import 'package:foodshop/screens/history/listhistory.dart';

import '../header.dart';

class FavoriteScreen extends StatefulWidget
{
  final bool isLogin;
  final List<User> listUser; 

  FavoriteScreen
  (
    {
      Key key ,
      @required this.isLogin,
      @required this.listUser
    }
  ) : super (key: key);


  @override
  _FavoriteScreen createState() => _FavoriteScreen();
}

class _FavoriteScreen extends State<FavoriteScreen>
{

  @override
  Widget build(BuildContext context)
  {
    Size size = MediaQuery.of(context).size;
    return Scaffold
    (
      appBar: AppBar
      (
        backgroundColor: kMainColor,
        elevation: 0,
        
        //tittle
        centerTitle: true,
        title: new Text('Food Shop tutorial'),
      ),
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
                      "Your Favorite List",
                      style: TextStyle
                      (
                        fontSize: 36
                      ),
                    ),
                  ),
                  this.widget.isLogin == true
                  ? ListHistory
                  (
                    size: size,
                    userId : this.widget.listUser.first.id,
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