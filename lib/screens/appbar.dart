import 'package:foodshop/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';


SearchBar searchBar;

AppBar appbar(BuildContext context) 
{
  return new AppBar
  (
    //Style
    backgroundColor: kMainColor,
    elevation: 0,
    
    //tittle
    centerTitle: true,
    title: new Text('Food Shop tutorial'),
    //Action
    actions: 
    [
      searchBar.getSearchAction(context),
    ]
  );
} 