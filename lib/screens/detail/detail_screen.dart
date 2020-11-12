import 'package:foodshop/components/constants.dart';
import 'package:foodshop/components/cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:foodshop/models/products.dart';
import 'package:foodshop/screens/cart/cart_screen.dart';
import 'package:foodshop/screens/detail/listproduct.dart';

import '../appbar.dart';
import '../header.dart';

class MainDetail extends StatefulWidget
{
  final String banner;
  final Future<List<Products>> listProduct;

  MainDetail
  (
    {
      Key key,
      @required this.banner,
      @required this.listProduct
    }
  ) : super (key: key);
  @override
  _MainDetail createState() => _MainDetail(this.banner,this.listProduct);
}

class _MainDetail extends State<MainDetail>
{

  GlobalKey<ScaffoldState> _scaffold = GlobalKey();

  // #region StateFAB
  Widget fab = FloatingActionButton.extended
  (
    backgroundColor: kMainColor,
    onPressed: () => 
    {

    },
    label: Align
    (
      alignment: Alignment.centerLeft,
      child: Text
      (
        countlistCart().toString()
      ),
    ),
    icon : Icon
    (
      Icons.add_shopping_cart ,
      size: 30,
    ),
  ); 
  _fabChange() async
  {
    setState(() =>
    {
      fab = FloatingActionButton.extended
      (
        backgroundColor: kMainColor,
        //key: UniqueKey(),
        onPressed: () => 
        {
          Navigator.push
          ( 
            context, MaterialPageRoute
            ( 
              builder: (context) => CartScreen()
            ), 
          ).then
          (
            (value) => setState
            ( () =>
              {
                _fabChange()
              }
            )
          )
        },
        label: Align
        (
          alignment: Alignment.centerLeft,
          child: Text
          (
            countlistCart().toString()
          ),
        ),
        icon : Icon
        (
          Icons.add_shopping_cart ,
          size: 30,
        ),
      )
    });
  }
  
  // #endregion
  _MainDetail(banner,listProduct)
  {
    searchBar = new SearchBar
    (
      inBar: false,
      setState: setState,
      onSubmitted: print,
      buildDefaultAppBar: appbar
    );
  }
  @override
  Widget build(BuildContext context)
  {
    Size size = MediaQuery.of(context).size;
    return Scaffold
    (
      appBar:searchBar.build(context),

      floatingActionButton: fab,

      key: _scaffold,
      
      body: SingleChildScrollView
      (
        child: Column
        (
          children: <Widget>
          [
            Header(size: size,),
            Container
            (
              child: Column
              (
                children: <Widget>
                [
                  Container
                  (
                    width: MediaQuery.of(context).size.width - 50,
                    child: Card
                    (
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 5,
                      margin: EdgeInsets.all(10),
                      shape: BeveledRectangleBorder
                      (
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: kMainColor,
                      child: Image.network
                      (
                        this.widget.banner,
                        fit: BoxFit.fill  ,
                      )
                    ),
                  ),
                  ListDetailProduct
                  (
                    size: size,
                    listProduct: this.widget.listProduct,
                    presstoload : () =>
                    {
                      _fabChange()
                    }
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}