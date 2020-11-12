
import 'package:foodshop/components/cart.dart';
import 'package:foodshop/components/constants.dart';
import 'package:foodshop/models/products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListDetailProduct extends StatefulWidget
{
  final Size size;
  final Future<List<Products>> listProduct;
  final Function presstoload;
  ListDetailProduct
  (
    {
      Key key,
      this.size,
      this.listProduct,
      this.presstoload
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
        builder: (context, snapshot) 
        {
          if(snapshot.hasData && snapshot.connectionState == ConnectionState.done)
          {
            return ListView
            (
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>
              [
                for( int i =0 ; i < snapshot.data.length ; i ++)
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
                          snapshot.data[i].image,
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
                            ( double.parse( snapshot.data[i].price ) *getItemInCart(int.parse(snapshot.data[i].id)) ).toString(),
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
                                        addtoCart(snapshot.data[i]),
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
                                    getItemInCart(int.parse(snapshot.data[i].id)).toString(),
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
                                        removefromcart(int.parse(snapshot.data[i].id)),
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
              ]
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}