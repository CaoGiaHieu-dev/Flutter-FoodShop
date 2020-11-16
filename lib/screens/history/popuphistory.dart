

import 'package:flutter/material.dart';
import 'package:foodshop/components/constants.dart';
import 'package:foodshop/components/products.dart';
import 'package:foodshop/models/category.dart';
import 'package:foodshop/models/products.dart';
import 'package:hexcolor/hexcolor.dart';

class PopUpHistory extends StatefulWidget
{
  final String productId;
  final Size size;
  final Future<List<Category>> listcategories ;  
  PopUpHistory
  (
    {
      Key key,
      this.size,
      this.listcategories,
      this.productId
    }
  ) : super ( key: key);

  @override 
  _PopUpHistory createState() => _PopUpHistory(size,listcategories,productId);
}

class _PopUpHistory extends State<PopUpHistory>
{
  Size size ;
  String productId;
  Future<List<Category>> listcategories ;  
  List<Products> _tempProduct =[];
  List<Category> _tempCategory;
  _PopUpHistory(this.size,this.listcategories,this.productId);
  // #region State
  @override
  void initState()
  {
    super.initState();
    _getProducts();
  }

  // #endregion

  String _getData()
  {
    try 
    {
      return _tempProduct.where((element) => element.id == productId).first.name;
      
    }
     catch (e) 
    {
      return "";
    }
  }

  _getProducts() async
  {
    _tempCategory = await listcategories;
    List<Products> _tempList;
    for(var items in _tempCategory)
    {
      _tempList = await getProducts(items.id, "");
      _tempList.forEach
      (
        (element) 
        { 
          setState(() 
          {
            _tempProduct.add(element);
          });
        }
      );
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return AlertDialog
    (
      actions: <Widget>
      [
        RaisedButton
        (
          color: kButtonColor,
          onPressed: () 
          {
            Navigator.pop(context);
          },
          child: Icon(Icons.close),
        ),
      ],
      content: SingleChildScrollView
      (
        scrollDirection: Axis.vertical,
        child: Column
        (
          children: <Widget>
          [
            //Title 
            Container
            (
              decoration: BoxDecoration
              (
                color: kMainColor,
                borderRadius: BorderRadius.circular(36)
              ),
              child: Align
              (
                alignment: Alignment.center,  
                child: Text
                (
                  "History",
                  style: TextStyle
                  (
                    color: HexColor("##F9DC5C"), 
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            Text
            (
              _getData()
            )
            //List histor
            
            // FutureBuilder
            // (
            //   future: _getProducts(),
            //   builder: (context, snapshot) 
            //   {
            //     if(snapshot.hasData && snapshot.connectionState == ConnectionState.done)
            //     {
            //       return Text
            //       (
            //         snapshot.data.id
            //       );
            //     }
            //     return CircularProgressIndicator();
            //   },
            // )
          ]
        )
      ),
    ); 
  }
}