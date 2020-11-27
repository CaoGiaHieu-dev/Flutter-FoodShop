

import 'package:foodshop/components/cart.dart';
import 'package:foodshop/models/cart.dart';
import 'package:flutter/material.dart';

class ListFavorite extends StatefulWidget
{
  final Size size;
  final String userId;
  ListFavorite
  (
    {
      Key key,
      this.size,
      this.userId
    }
  ) : super (key : key );
  @override
  _ListFavorite createState() => _ListFavorite();
}

class _ListFavorite extends State<ListFavorite>
{
  Future<List<Cart>> _listCart ;
  List<String> _favoriteList;
  
  // #region getStoreFavoriteList



  // #endregion

  // #region State
  @override
  void initState()
  {
    super.initState();
    _listCart = getCart();
  }
  // #endregion
  
  // #region get data
  _getTotalnumber(List<dynamic> _list)
  {
    int _totalnumber = 0;
    for ( int i =0 ; i < _list.length ; i++)
    {
      _totalnumber += _list[i].number ;
    }
    return _totalnumber;
  }
  _getTotalPrice(List<dynamic> _list)
  {
    double _totalprice = 0;
    for ( int i =0 ; i < _list.length ; i++)
    {
      _totalprice += _list[i].total ;
    }
    return _totalprice;
  }
  _getListIdProduct(List<dynamic> _list)
  {
    List<Cart> _idList=[];
    for ( int i =0 ; i < _list.length ; i++)
    {
      _idList.add(_list[i]);
    }
    return _idList;
  }

  // #endregion 
  @override
  Widget build(BuildContext context)
  {
    return Container
    (
      height: this.widget.size.height *0.6 ,
      
      child : _favoriteList == null || _favoriteList.length ==0
      ? Text("it's empty")
      : ListView.builder
      (
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _favoriteList.length,
        itemBuilder: (context, index) 
        {
          return Text("aaa");
        },
      )
    );
  }
}