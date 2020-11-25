import 'package:foodshop/components/constants.dart';
import 'package:foodshop/components/cart.dart';
import 'package:foodshop/models/products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListCart extends StatefulWidget
{
  final Size size;
  final Function updateTotalPrice;
  ListCart
  (
    {
      Key key,
      this.size,
      this.updateTotalPrice
    }
  ) : super (key : key );
  @override
  _ListCart createState() => _ListCart(size,updateTotalPrice);
}

class _ListCart extends State<ListCart>
{
  Size size;
  Function updateTotalPrice;
  _ListCart(this.size,this.updateTotalPrice);
  
  List<Products> temp = cartList;   

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
          for ( int i = 0 ; i < cartList.length ; i ++)
            if( getItemInCart(int.parse(cartList[i].id)) >0  )  
              Card
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
                      cartList[i].image,
                      height: 120 ,
                      width: 100,
                    ),
                    Spacer(),

                    //total price
                    // Align
                    // (
                    //   alignment: Alignment.center,
                    //   child: Text
                    //   (
                    //     ( double.parse( cartList[i].price ) *getItemInCart(int.parse(cartList[i].id)) ).toString(),
                    //     style: TextStyle
                    //     (
                    //       color: Colors.white
                    //     ),
                    //   ),
                    // ),
                     Align
                    (
                      alignment: Alignment.center,
                      child: (!cartList[i].discount)
                      ? Text
                      (
                        cartList[i].price,
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
                            ( double.parse( cartList[i].price ) *getItemInCart(int.parse(cartList[i].id)) ).toString(),
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
                            ( (double.parse(cartList[i].price) - double.parse(cartList[i].price) * (10/100)) * getItemInCart(int.parse(cartList[i].id)) ).toStringAsFixed(2),
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
                                    addtoCart(cartList[i]),
                                    updateTotalPrice()
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
                                getItemInCart(int.parse(cartList[i].id)).toString(),
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
                                    removefromcart(int.parse(cartList[i].id)),
                                    updateTotalPrice()
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
              ),
        ],
      )
    );
  }
}