

import 'package:flutter/material.dart';
import 'package:foodshop/components/constants.dart';
import 'package:foodshop/components/products.dart';
import 'package:foodshop/models/category.dart';
import 'package:foodshop/models/products.dart';
import 'package:hexcolor/hexcolor.dart';

class PopUpHistory extends StatefulWidget
{
  final String address ;
  final List<String> listProductId;
  final Size size;
  final Future<List<Category>> listcategories ;  
  PopUpHistory
  (
    {
      Key key,
      this.size,
      this.listcategories,
      this.listProductId,
      this.address
    }
  ) : super ( key: key);

  @override 
  _PopUpHistory createState() => _PopUpHistory(size,listcategories,listProductId,address);
}

class _PopUpHistory extends State<PopUpHistory>
{
  // #region property
  Size size ;
  String address ;
  List<String> listProductId;
  Future<List<Category>> listcategories ;  
  _PopUpHistory(this.size,this.listcategories,this.listProductId,this.address);

  // #endregion
  // #region State
  @override
  void initState()
  {
    super.initState();
    _getProducts();
  }

  // #endregion
  // #region GetProductDetail
  List<Products> _tempProduct =[];
  List<Category> _tempCategory;
  List<Products> _getData()
  {
    try 
    {
      return _tempProduct.where
      (
        (element) => listProductId.contains(element.id)
        
      ).toList();
    }
     catch (e) 
    {
      return [];
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
          _tempProduct.add(element);
        }
      );
    }
  }
  // #endregion
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

            //Address
            Container
            (
              margin: EdgeInsets.only
              (
                top: 10,
                bottom: 10
              ),
              decoration: BoxDecoration
              (
                color: kMainColor,
                borderRadius: BorderRadius.circular(15),

              ),
              child: Align
              (
                alignment: Alignment.center, 
                child: Text
                (
                  "$address",
                  textAlign: TextAlign.center,
                  style: TextStyle
                  (
                    color: HexColor("##F9DC5C"), 
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            //List history
            
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