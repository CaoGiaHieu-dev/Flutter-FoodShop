
import 'package:cached_network_image/cached_network_image.dart';
import 'package:foodshop/components/cart.dart';
import 'package:foodshop/components/constants.dart';
import 'package:foodshop/models/products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodshop/screens/home/carditem.dart';

class ListDetailProduct extends StatefulWidget
{
  final Size size;
  final Future<List<Products>> listProduct;
  final Function presstoload;
  final String searchText;
  ListDetailProduct
  (
    {
      Key key,
      this.size,
      this.listProduct,
      this.presstoload,
      this.searchText
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

                          //total price
                          Align
                          (
                            alignment: Alignment.center,
                            child: Text
                            (
                              ( double.parse( templist[i].price ) *getItemInCart(int.parse(templist[i].id)) ).toString(),
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
                                      getItemInCart(int.parse(templist[i].id)).toString(),
                                      style: TextStyle
                                      (
                                        color: Colors.white,
                                        fontSize: 25
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