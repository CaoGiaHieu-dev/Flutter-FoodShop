

import 'package:cached_network_image/cached_network_image.dart';
import 'package:foodshop/components/cart.dart';
import 'package:foodshop/components/categories.dart';
import 'package:foodshop/components/constants.dart';
import 'package:foodshop/components/products.dart';
import 'package:flutter/material.dart';
import 'package:foodshop/models/category.dart';
import 'package:foodshop/models/products.dart';
import 'package:foodshop/user/components/userpreferences.dart';

class ListFavorite extends StatefulWidget
{
  final Size size;
  final String userId;
  final Function presstoload;
  ListFavorite
  (
    {
      Key key,
      this.size,
      this.userId,
      @required this.presstoload
    }
  ) : super (key : key );
  @override
  _ListFavorite createState() => _ListFavorite();
}

class _ListFavorite extends State<ListFavorite>
{
  List<String> _favoriteList;
  bool isLoading;

  // #region State
  @override
  void initState()
  {
    isLoading=true;
    super.initState();
    _favoriteList = UserPrefrences().getListFavorite(this.widget.userId);
    _getProducts().whenComplete(() 
    {
      if(mounted)
      {
        setState(() 
        {
          isLoading = false;
        });
      }
    });
  }

  @override
  void dispose()
  {
    super.dispose();
  }
  // #endregion
  // #region GetProductDetail
  List<Products> _tempProduct =[];
  List<Category> _tempCategory;

  Future _getProducts() async
  {
    _tempProduct =[];
    _tempCategory = await getCategories();
    for(var items in _tempCategory)
    {
      await getProducts(items.id, "").then((value) => 
      {
        value.forEach
        (
          (element) 
          { 
            _favoriteList.forEach
            (
              (fe) 
              { 
                if( element.id == fe)
                {
                  _tempProduct.add(element);
                }
              }
            );
          }
        )
      });
    }
  }
  // #endregion
  
  @override
  Widget build(BuildContext context)
  {
    return Container
    (
      height: this.widget.size.height *0.6 ,
      
      child : _favoriteList == null || _favoriteList.length == 0
      ? Text("it's empty")
      : isLoading
      ? Center(child: CircularProgressIndicator())
      : ListView.builder
      (
        itemCount: _tempProduct.length,
        itemBuilder: (context, i) 
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
                // Image.network
                // (
                //   snapshot.data[i].image,
                //   height: 120 ,
                //   width: 100,
                // ),
                CachedNetworkImage
                (
                  imageUrl: _tempProduct[i].image,
                  height: 120,
                  width: 100,
                ),
                Spacer(),

                // middle conner
                Container
                (
                  width: this.widget.size.width *0.375,

                  // name product 
                  child : Column
                  (
                    mainAxisAlignment: MainAxisAlignment. center,
                    children: <Widget>
                    [
                      Align
                      (
                        alignment: Alignment.center,
                        child: Text
                        (
                          _tempProduct[i].name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          textAlign: TextAlign.center,
                          style: TextStyle
                          (
                            color: Colors.white,
                            
                          ),
                        ),
                      ),
                      SizedBox
                      (
                        height: 10,
                      ),
                      Align
                      (
                        alignment: Alignment.center,
                        child: (!_tempProduct[i].discount)
                        ? Text
                        (
                          _tempProduct[i].price,
                          style: TextStyle
                          (
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        )
                        : Row
                        (
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>
                          [
                            Text
                            (
                              _tempProduct[i].price,
                              style: TextStyle
                              (
                                color: Colors.white,
                                fontSize: 15,
                                decoration: TextDecoration.lineThrough
                              )
                            ),
                            SizedBox(width: 10,),
                            Text
                            (
                              ( double.parse(_tempProduct[i].price) - double.parse(_tempProduct[i].price) * (10/100) ).toString(),
                              style: TextStyle
                              (
                                color: Colors.white,
                                fontSize: 20,
                              )
                            )
                          ]
                        )
                        // child: Text
                        // (
                        //   ( double.parse( templist[i].price ) *getItemInCart(int.parse(templist[i].id)) ).toString(),
                        //   style: TextStyle
                        //   (
                        //     color: Colors.white
                        //   ),
                        // ),
                      ),
                    ],
                  ),
                ),
                Spacer(),

                //right conner
                Container
                (
                  child: Column
                  (
                    children: <Widget>
                    [
                      // edit number
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
                              //plus
                              SizedBox
                              (
                                width: this.widget.size.width *0.1,
                                child: RaisedButton
                                (
                                  color: kButtonColor,
                                  shape: RoundedRectangleBorder
                                  (
                                    borderRadius: BorderRadius.circular(100)
                                  ),
                                  onPressed: () 
                                  {
                                    setState(() =>
                                    {
                                      addtoCart(_tempProduct[i]),
                                      this.widget.presstoload()
                                    });
                                  },
                                  child: Text
                                  (
                                    "+",
                                    style: TextStyle
                                    (
                                      color: Colors.white,
                                      fontSize: 25
                                    ),
                                  ),
                                ),
                              ),
                              // total price product in cart
                              Container
                              (
                                padding: EdgeInsets.only
                                (
                                  left: 10,
                                  right: 10
                                ),
                                child: Text
                                (
                                  getItemInCart(int.parse(_tempProduct[i].id)).toString(),
                                  maxLines: 2,
                                  style: TextStyle
                                  (
                                    color: Colors.white,
                                    fontSize: 15
                                  ),
                                ),
                              ),
                              //remove
                              SizedBox
                              (
                                width: this.widget.size.width *0.1,
                                child: RaisedButton
                                (
                                  color: kButtonColor,
                                  shape: RoundedRectangleBorder
                                  (
                                    borderRadius: BorderRadius.circular(100)
                                  ),
                                  onPressed: () 
                                  { 
                                    setState(() =>
                                    {
                                      removefromcart(int.parse(_tempProduct[i].id)),
                                      this.widget.presstoload()
                                    });
                                  },
                                  child: Text
                                  (
                                    "-",
                                    style: TextStyle
                                    (
                                      color: Colors.white,
                                      fontSize: 25
                                    ),
                                  ),
                                ),
                              ),
                            ]
                          ),
                        )
                      ),
                      Align
                      (
                        alignment: Alignment.center,
                        child: (!_tempProduct[i].discount)
                        ? Text
                        (
                          _tempProduct[i].price,
                          style: TextStyle
                          (
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        )
                        : Column
                        (
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>
                          [
                            Text
                            (
                              ( double.parse( _tempProduct[i].price ) *getItemInCart(int.parse(_tempProduct[i].id)) ).toString(),
                              style: TextStyle
                              (
                                color: Colors.white,
                                fontSize: 15,
                                decoration: TextDecoration.lineThrough
                              )
                            ),
                            SizedBox(width: 10,),
                            Text
                            (
                              ( (double.parse(_tempProduct[i].price) - double.parse(_tempProduct[i].price) * (10/100)) * getItemInCart(int.parse(_tempProduct[i].id)) ).toStringAsFixed(2),
                              maxLines: 2,
                              overflow: TextOverflow.visible,
                              style: TextStyle
                              (
                                color: Colors.white,
                                fontSize: 20,
                              )
                            )
                          ]
                        )
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      )
    );
  }
}