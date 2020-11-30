

import 'package:collection/collection.dart';
import 'package:foodshop/components/cart.dart';
import 'package:foodshop/components/categories.dart';
import 'package:foodshop/components/constants.dart';
import 'package:foodshop/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:foodshop/screens/history/popuphistory.dart';
import 'package:intl/intl.dart';

class ListHistory extends StatefulWidget
{
  final Size size;
  final String userId;
  ListHistory
  (
    {
      Key key,
      this.size,
      this.userId
    }
  ) : super (key : key );
  @override
  _ListHistory createState() => _ListHistory(size,userId);
}

class _ListHistory extends State<ListHistory>
{
  Size size;
  String userId;
  _ListHistory(this.size,this.userId);

  
  Future<List<Cart>> _listCart ;    

  // #region Permisson
  String _address(String __address)
  {
    if(__address.length > 15)
    {
      return __address.substring(0,15) + "...";
    }
    else
    {
      return __address;
    }
    
  }
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
  int _getTotalnumber(List<dynamic> _list)
  {
    int _totalnumber = 0;
    for ( int i =0 ; i < _list.length ; i++)
    {
      _totalnumber += _list[i].number ;
    }
    return _totalnumber;
  }
  double _getTotalPrice(List<dynamic> _list)
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
      height: size.height *0.6 ,
      
      child : ListView
      (
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        //physics: const NeverScrollableScrollPhysics(),
        children: <Widget>
        [
          FutureBuilder
          (
            future: _listCart,
            builder: (context, snapshot) 
            {
              if(snapshot.hasData && snapshot.connectionState==ConnectionState.done)
              {
                snapshot.data.where( (element) => element.userId == userId).toList();
                snapshot.data.sort((a,b) => int.parse(b.createAt).compareTo(int.parse(a.createAt)));  //sort by create at time
                var _group = groupBy(snapshot.data, (obj) => (obj as Cart).createAt); // group history
                
                return GridView
                (
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount
                  (
                    crossAxisCount: 1,
                    childAspectRatio: 4
                  ) ,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: <Widget>
                  [
                    for( var items in _group.keys)
                      GestureDetector
                      (
                        onTap: () 
                        {
                          showDialog
                          (
                            context: context,
                            builder: (BuildContext context)
                            {
                              return PopUpHistory
                              (
                                size: size,
                                listcategories: getCategories(),
                                listProduct : _getListIdProduct(_group.values.where((element) => element.first.createAt == items).first),
                                address : _group.values.where((element) => element.first.createAt == items).first[0].address
                              );
                            }
                          );
                        },
                        child: Card
                        (
                          margin: EdgeInsets.only
                          (
                            left: 10,
                            right: 10,
                            top: 10,
                            bottom: 10
                          ),
                          shape: BeveledRectangleBorder
                          (
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: kMainColor,
                          child: Padding
                          (
                            padding: const EdgeInsets.all(8.0),
                            child: Column
                            (
                              children: <Widget>
                              [
                                Center
                                (
                                  child: Text
                                  (
                                    DateFormat.yMMMMEEEEd().add_jm().format(DateTime.fromMicrosecondsSinceEpoch(int.parse(items)*1000)).toString(), //convert from timesplap to datetime
                                    style: TextStyle
                                    (
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Row
                                (
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>
                                  [
                                    Align
                                    (
                                      alignment: Alignment.centerLeft,
                                      child: Text
                                      (
                                        "Address : ${_address(_group.values.where((element) => element.first.createAt == items).first[0].address)}", // get first address in list group with key
                                        style: TextStyle
                                        (
                                          color: Colors.white,
                                          fontSize: 15
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Align
                                    (
                                      alignment: Alignment.centerRight,
                                      
                                      child: Column
                                      (
                                        children : <Widget>
                                        [
                                          Text
                                          (
                                            "Total Product : ${_getTotalnumber(_group.values.where((element) => element.first.createAt == items).first)}", // get total number
                                            style: TextStyle
                                            (
                                              color: Colors.white
                                            ),
                                          ),
                                          Text
                                          (
                                            "Total Price : ${_getTotalPrice(_group.values.where((element) => element.first.createAt == items).first).toStringAsFixed(2)}", // get total price
                                            maxLines: 2,
                                            overflow: TextOverflow.visible,
                                            style: TextStyle
                                            (
                                              color: Colors.white
                                            ),
                                          )
                                        ]
                                      ),
                                    )
                                  ],
                                ),
                                Spacer()
                              ],
                            ),
                          )
                        ),
                      )
                  ],
                );
              }
              return CircularProgressIndicator(); 
            },
          )
        ],
      )
    );
  }
}