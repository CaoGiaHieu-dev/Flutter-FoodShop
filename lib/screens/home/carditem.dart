import 'package:foodshop/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/Cart.dart';

class CardItems extends StatefulWidget
{
  final Function press;
  final AsyncSnapshot<dynamic> foodSnap;
  final int index;

  CardItems
  (
    {
      Key key,
      @required this.foodSnap,
      @required this.index,
      this.press,
    }
  ) : super (key : key );

  @override
  _CardItems createState() => _CardItems(this.press  , this.foodSnap , this.index);
}

class _CardItems extends State<CardItems>
{
  Function press;
  AsyncSnapshot<dynamic> foodSnap;
  int index;
  _CardItems(this.press,this.foodSnap,this.index);

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
            Image.network
            (
              foodSnap.data[index].image.toString() ,
              height: MediaQuery.of(context).size.height * 0.25 - 100,
              width: MediaQuery.of(context).size.width -20,
            ),
            Spacer(),
            Align
            (
              alignment: Alignment.center,
              child: Text
              (
                foodSnap.data[index].price,
                style: TextStyle
                (
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
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
                          addtoCart(foodSnap.data[index]),
                          press()
                        });
                      },
                    ),
                  ),
                  Spacer(),
                  Text
                  (
                    getItemInCart(int.parse(foodSnap.data[index].id)).toString(),
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
                          removefromcart(int.parse(foodSnap.data[index].id)),
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


