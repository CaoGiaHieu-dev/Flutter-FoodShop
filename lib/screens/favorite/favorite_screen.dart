import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:foodshop/components/cart.dart';
import 'package:foodshop/components/constants.dart';
import 'package:foodshop/models/user.dart';
import 'package:foodshop/screens/cart/cart_screen.dart';
import 'package:foodshop/screens/favorite/favoriteList.dart';

import '../appbar.dart';
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
  // #region StateFAB
  Widget fab = FloatingActionButton.extended
  (
    backgroundColor: kMainColor,
    onPressed: () => 
    {

    },
    label: Align
    (
      alignment: Alignment.centerLeft,
      child: Text
      (
        countlistCart().toString()
      ),
    ),
    icon : Icon
    (
      Icons.add_shopping_cart ,
      size: 30,
    ),
  ); 
  _fabChange() async
  {
    setState(() =>
    {
      fab = FloatingActionButton.extended
      (
        backgroundColor: kMainColor,
        //key: UniqueKey(),
        onPressed: () => 
        {
          Navigator.push
          ( 
            context, MaterialPageRoute
            ( 
              builder: (context) => CartScreen
              (
                isLogin: this.widget.isLogin,
                listUser: this.widget.listUser,
              )
            ), 
          ).then
          (
            (value) => setState
            ( () =>
              {
                _fabChange()
              }
            )
          )
        },
        label: Align
        (
          alignment: Alignment.centerLeft,
          child: Text
          (
            countlistCart().toString()
          ),
        ),
        icon : Icon
        (
          Icons.add_shopping_cart ,
          size: 30,
        ),
      )
    });
  }
  
  // #endregion
  // #region SeachBar
  String _searchText;
  _FavoriteScreen()
  {
    searchBar = new SearchBar
    (
      inBar: false,
      setState: setState,
      onSubmitted: _getSeachtext,
      buildDefaultAppBar: appbar
    );
  }

  _getSeachtext(String value)
  {
    _searchText = value ;
  }
  // #endregion
  // #region property

  GlobalKey<ScaffoldState> _scaffold = GlobalKey();
  
  // #endregion 
  
  @override
  Widget build(BuildContext context)
  {
    Size size = MediaQuery.of(context).size;
    return Scaffold
    (
      appBar:searchBar.build(context),

      floatingActionButton: fab,

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
                      "Your Favorite List",
                      style: TextStyle
                      (
                        fontSize: 36
                      ),
                    ),
                  ),
                  this.widget.isLogin == true
                  ? ListFavorite
                  (
                    presstoload: () =>_fabChange(),
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