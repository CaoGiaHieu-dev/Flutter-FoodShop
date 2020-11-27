
import 'package:cached_network_image/cached_network_image.dart';
import 'package:foodshop/components/cart.dart';
import 'package:foodshop/components/constants.dart';
import 'package:foodshop/models/products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodshop/models/user.dart';
import 'package:foodshop/screens/home/carditem.dart';

class ListDetailProduct extends StatefulWidget
{
  final Size size;
  final Future<List<Products>> listProduct;
  final Function presstoload;
  final String searchText;
  final String value;
  final bool isLogin;
  final List<User> listUser;
  ListDetailProduct
  (
    {
      Key key,
      this.size,
      this.listProduct,
      this.presstoload,
      this.searchText,
      this.value,
      @required this.isLogin,
      @required this.listUser,
    }
  ) : super (key : key );
  @override
  _ListDetailProduct createState() => _ListDetailProduct(size,listProduct,presstoload);
}

class _ListDetailProduct extends State<ListDetailProduct>
{
  Size size;
  Future<List<Products>> listProduct;
  Function presstoload;
  _ListDetailProduct(this.size,this.listProduct,this.presstoload);
  
  List<Products> temp = cartList;

  // #region sort list
  _sortList(List<dynamic> _list)
  {
    if(this.widget.value =="0")
    {
      _list.sort((a,b) => double.parse(a.price).compareTo(double.parse(b.price)));
    }
    else
    {
      _list.sort((a,b) => double.parse(b.price).compareTo(double.parse(a.price)));
    }
  }
  // #endregion

  @override
  Widget build(BuildContext context)
  {
    return SingleChildScrollView
    (
      child: FutureBuilder
      (
        initialData: [],
        future: this.widget.listProduct,
        builder: (context, AsyncSnapshot snapshot) 
        {
          if(snapshot.hasData && snapshot.connectionState == ConnectionState.done)
          {
            List<Products> templist =[];
            if(this.widget.searchText !=  "")
            {
              snapshot.data.forEach
              (
                (values)
                {
                  if( values.name.contains(this.widget.searchText) == true )
                  {
                    templist.add(values);
                  }
                }
              );
            }
            else
            {
              templist = snapshot.data;
            }
            _sortList(templist);
            return ListView
            (
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>
              [
                for( int i =0 ; i < templist.length  ; i ++)
                  GestureDetector
                  (
                    onTap: () => 
                    {
                      showDialog
                      (
                        context: context,
                        builder: (BuildContext context)
                        {
                          return AlertDialog
                          (
                            content: Container
                            (
                              height: size.height *0.5,
                              child: CardItems
                              (
                                userId : this.widget.listUser.first.id,
                                isLogin: this.widget.isLogin,
                                key: UniqueKey(),
                                product: templist[i],
                                press: () =>
                                {
                                  presstoload()
                                } 
                              ),
                            ),
                          );
                        }
                      ).then((value)  
                      {
                        setState(() 
                        {
                          
                        });
                      })
                    },
                    child: Card
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
                            imageUrl: templist[i].image,
                            height: 120,
                            width: 100,
                          ),
                          Spacer(),

                          // middle conner
                          Container
                          (
                            width: size.width *0.375,

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
                                    templist[i].name,
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
                                  child: (!templist[i].discount)
                                  ? Text
                                  (
                                    templist[i].price,
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
                                        templist[i].price,
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
                                        ( double.parse(templist[i].price) - double.parse(templist[i].price) * (10/100) ).toString(),
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
                                          width: size.width *0.1,
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
                                                addtoCart(templist[i]),
                                                presstoload()
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
                                            getItemInCart(int.parse(templist[i].id)).toString(),
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
                                          width: size.width *0.1,
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
                                                removefromcart(int.parse(templist[i].id)),
                                                presstoload()
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
                                  child: (!templist[i].discount)
                                  ? Text
                                  (
                                    templist[i].price,
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
                                        ( double.parse( templist[i].price ) *getItemInCart(int.parse(templist[i].id)) ).toString(),
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
                                        ( (double.parse(templist[i].price) - double.parse(templist[i].price) * (10/100)) * getItemInCart(int.parse(templist[i].id)) ).toStringAsFixed(2),
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
                    )
                  )
                  
              ]
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}