

import 'package:foodshop/components/categories.dart';
import 'package:foodshop/components/Products.dart';
import 'package:foodshop/models/category.dart';
import 'package:foodshop/models/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:foodshop/screens/history/listhistory.dart';
import '../appbar.dart';
import '../header.dart';


class HistoryScreen extends StatefulWidget
{
  @override
  _HistoryScreen createState() => _HistoryScreen();
}

class _HistoryScreen extends State<HistoryScreen>
{
  
  // #region property
  String categoryId;
  Future<List<Category>> listcategories ;
  Future<List<Products>> listproducts ;
  int number ;
  String detailbaner="";
  GlobalKey<ScaffoldState> _scaffold = GlobalKey();
  
  // #endregion
  // #region Appbar custom
  _HistoryScreen() 
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
    listcategories = getCategories();

    if(categoryId == null || categoryId =="" )
    {
      listproducts =  getProducts("1","");
    }
    else
    {
      listproducts = getProducts(categoryId, "");
    }
    
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
                  ListHistory
                  (
                    size: size,
                  ),
                ],
              ),
            )
          ]
        ),
      )
    );
  }
}