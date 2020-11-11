

import 'package:foodshop/components/cart.dart';
import 'package:foodshop/components/constants.dart';
import 'package:foodshop/screens/cart/components/getupdatelistCart.dart';
import 'package:foodshop/screens/cart/payment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../header.dart';
import 'listcart.dart';

class CartScreen extends StatefulWidget
{
  @override
  _CartScreen createState() => _CartScreen();
}

class _CartScreen extends State<CartScreen>
{
  
  @override
  Widget build(BuildContext context)
  {
    Size size = MediaQuery.of(context).size;
    return Scaffold
    (
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset :false,
      appBar: AppBar
      (
        backgroundColor: kMainColor,
        elevation: 0,
        centerTitle: true,
        title: new Text('Food Shop tutorial'),
        leading: IconButton
        (
          icon: Icon(Icons.arrow_back),
          onPressed: () 
          {
            setState(() =>
            {
              Navigator.pop(context)
            });
          },
        ),
      ),

      body: Container
      (
        child: Column
        (
          children: <Widget>
          [
            Header(size: size,),
            Column
            (
              children: <Widget>
              [
                Align
                (
                  alignment: Alignment.center,
                  child: Text
                  (
                    "List Cart",
                    style: TextStyle
                    (
                      fontSize: 36
                    ),
                  ),
                ),
                UpdateListCart
                (
                  listProducts: cartList, 
                  child: ListCart
                  (
                    updateTotalPrice: () =>
                    {
                      setState(() 
                      {
                        
                      })
                    },
                    size: size,
                  ),
                ),
                Payment
                (
                  size: size,
                )
              ],
            )
          ],
        ),
      )
    );
  }
}