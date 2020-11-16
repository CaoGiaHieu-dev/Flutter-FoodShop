

import 'package:flutter/material.dart';
import 'package:foodshop/components/constants.dart';
import 'package:foodshop/components/products.dart';
import 'package:foodshop/models/cart.dart';
import 'package:foodshop/models/category.dart';
import 'package:foodshop/models/products.dart';
import 'package:foodshop/screens/history/components/getupdateHistory.dart';
import 'package:hexcolor/hexcolor.dart';

class PopUpHistory extends StatefulWidget
{
  final String address ;
  final List<Cart> listProduct;
  final Size size;
  final Future<List<Category>> listcategories ;  
  PopUpHistory
  (
    {
      Key key,
      this.size,
      this.listcategories,
      this.listProduct,
      this.address
    }
  ) : super ( key: key);

  @override 
  _PopUpHistory createState() => _PopUpHistory(size,listcategories,listProduct,address);
}

class _PopUpHistory extends State<PopUpHistory>
{
  // #region property
  Size size ;
  String address ;
  List<Cart> listProduct;
  Future<List<Category>> listcategories ;  
  _PopUpHistory(this.size,this.listcategories,this.listProduct,this.address);

  // #endregion
  // #region State
  @override
  void initState()
  {
    super.initState();
    _getProducts();
    //_getData();
  }

  // #endregion
  // #region GetProductDetail
  List<Products> _tempProduct =[];
  List<Category> _tempCategory;

  Future _getProducts() async
  {
     _tempProduct =[];
    _tempCategory = await listcategories;
    List<Products> _tempList;
    for(var items in _tempCategory)
    {
      _tempList = await getProducts(items.id, "");
      _tempList.forEach
      (
        (element) 
        { 
          setState(() =>
          {
            _tempProduct.add(element)
          });
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
            UpdateHistory
            (
              listProducts: _tempProduct, 
              child: _tempProduct.length == 0
              ? Center(child: CircularProgressIndicator(),)
              : SizedBox
              (
                height: size.height *0.6,
                width: size.width  - 20 ,
                child : ListView.builder
                (
                  scrollDirection: Axis.vertical,
                  itemCount: listProduct.length,
                  itemBuilder : (context, i) 
                  {
                    return Card
                    (
                      shape: BeveledRectangleBorder
                      (
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: kMainColor,
                      child: Row
                      (
                        children: <Widget>
                        [
                          //image
                          Image.network
                          (
                            _tempProduct[i].image,
                            height: 120 ,
                            width: 100,
                          ),
                          Spacer(),

                          //total price
                          Align
                          (
                            alignment: Alignment.center,
                            child: Text
                            (
                              listProduct[i].total.toString(),
                              style: TextStyle
                              (
                                color: Colors.white
                              ),
                            ),
                          ),
                          Spacer(),

                          //right conner
                          Align
                          (
                            alignment: Alignment.centerRight,
                            child: Container
                            (
                              padding: EdgeInsets.only
                              (
                                left: 10,
                                right: 10
                              ),
                              child: Row
                              (
                                children: <Widget>
                                [
                                  // count in cart
                                  Container
                                  (
                                    padding: EdgeInsets.only
                                    (
                                      left: 10,
                                      right: 10
                                    ),
                                    child: Text
                                    (
                                      listProduct[i].number.toString(),
                                      style: TextStyle
                                      (
                                        color: Colors.white,
                                        fontSize: 25
                                      ),
                                    ),
                                  ),
                                ]
                              ),
                            )
                          )
                        ],
                      ),
                    );
                  },
                )
              )
          
            )
            
          ]
        )
      ),
    ); 
  }
}