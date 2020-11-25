import 'package:cached_network_image/cached_network_image.dart';
import 'package:foodshop/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodshop/models/products.dart';

import '../../components/cart.dart';

class CardItems extends StatefulWidget
{
  final Function press;
  final Products product;

  CardItems
  (
    {
      Key key,
      @required this.product,
      this.press,
    }
  ) : super (key : key );

  @override
  _CardItems createState() => _CardItems(this.press  , this.product );
}

class _CardItems extends State<CardItems>
{
  Function press;
  Products product;
  _CardItems(this.press,this.product);

  @override
  Widget build(BuildContext context )
  {
    return Card
    (
      shape: BeveledRectangleBorder
      (
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: kMainColor,
      child: Container
      (
        width: 150,
        decoration: BoxDecoration
        (
          borderRadius: BorderRadius.all(Radius.circular(100))
        ),
        child: Column
        (
          children: <Widget>
          [
            CachedNetworkImage
            (
              imageUrl: product.image.toString(),
              width: MediaQuery.of(context).size.width -20,
              height: MediaQuery.of(context).size.height * 0.25 - 100,
              alignment: Alignment.center,
              placeholder: (context, url) => new CircularProgressIndicator(),
              errorWidget: (context, url, error) => new Icon(Icons.error),
            ),
            // Image.network
            // (
            //   foodSnap.data[index].image.toString() ,
            //   height: MediaQuery.of(context).size.height * 0.25 - 100,
            //   width: MediaQuery.of(context).size.width -20,
            // ),
            Spacer(),
            Align
            (
              alignment: Alignment.center,
              child :Text
              (
                product.name,
                style: TextStyle
                (
                  color: Colors.white,
                  fontSize: 15,
                ),
              )
            ),
            Spacer(),
            Align
            (
              alignment: Alignment.center,
              child: (!product.discount)
              ? Text
              (
                product.price,
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
                    product.price,
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
                    ( double.parse(product.price) - double.parse(product.price) * (10/100) ).toString(),
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
            Center
            (
              child : Row
              (
                children: <Widget>
                [
                  Spacer(),
                  SizedBox
                  (
                    width: MediaQuery.of(context).size.width * 0.175 -30,
                    child: RaisedButton
                    (
                      color: kButtonColor,
                      shape: RoundedRectangleBorder
                      (
                        borderRadius: BorderRadius.circular(100)
                      ),
                      child: Align
                      (
                        alignment: Alignment.center,
                        child: Text
                        (
                          "+",
                          style: TextStyle
                          (
                            fontSize: 16,
                          ),
                        ),
                      ),
                      onPressed: () 
                      {
                        setState(() =>
                        {
                          addtoCart(product),
                          press()
                        });
                      },
                    ),
                  ),
                  Spacer(),
                  Text
                  (
                    getItemInCart(int.parse(product.id)).toString(),
                    style: TextStyle
                    (
                      color: Colors.white,
                      fontSize: 15
                    ),
                  ),
                  Spacer(),
                  SizedBox
                  (
                    width: MediaQuery.of(context).size.width * 0.175 -30,
                    child: RaisedButton
                    (
                      color: kButtonColor,
                      shape: RoundedRectangleBorder
                      (
                        
                        borderRadius: BorderRadius.circular(36)
                      ),
                      child: Align
                      (
                        alignment: Alignment.center,
                        child: Text
                        (
                          "-",
                          style: TextStyle
                          (
                            fontSize: 16,
                          ),
                        ),
                      ),
                      onPressed: () 
                      {
                        setState(() =>
                        {
                          removefromcart(int.parse(product.id)),
                          press()
                        });
                      }
                    ),
                  ),
                  Spacer(),
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}


