import 'package:foodshop/components/constants.dart';
import 'package:foodshop/components/cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:foodshop/models/products.dart';
import 'package:foodshop/models/user.dart';
import 'package:foodshop/screens/cart/cart_screen.dart';
import 'package:foodshop/screens/detail/listproduct.dart';

import '../appbar.dart';
import '../header.dart';

class MainDetail extends StatefulWidget
{
  final String banner;
  final Future<List<Products>> listProduct;
  final List<User> listUser;
  final bool isLogin;
  
  MainDetail
  (
    {
      Key key,
      @required this.isLogin,
      @required this.listUser,
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
  String dropdownValue = 'Sort by price';
  // #region State
  void initState()
  {
    super.initState();

    _searchText ="";
  }
  // #endregion

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
              builder: (context) => CartScreen
              (
                isLogin: this.widget.isLogin,
                listUser: this.widget.listUser,
              )
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

  // #region SeachBar
  String _searchText;
  _MainDetail(banner,listProduct)
  {
    searchBar = new SearchBar
    (
      inBar: false,
      setState: setState,
      onSubmitted: _getSeachtext,
      buildDefaultAppBar: appbar
    );
  }

  _getSeachtext(String value)
  {
    _searchText = value ;
  }

  // #endregion
  
  // #region DropDown button
  String _value;
  DropdownButton _itemDown() => DropdownButton<String>
  (
    items: 
    [
      DropdownMenuItem
      (
        value: "0",
        child: Text
        (
          "Low -> High",
          style: TextStyle
          (
            color: kButtonColor 
          ),
        ),
      ),
      DropdownMenuItem
      (
        value: "1",
        child: Text
        (
          "High -> Low",
          style: TextStyle
          (
            color: kButtonColor 
          ),
        ),
      ),
    ],
    onChanged: (value) 
    {
      setState(() 
      {
        _value = value;
      });
    },
    value: _value,
    isExpanded: true,
    hint: Text
    (
      "Sort by price",
      style: TextStyle
      (
        color: kButtonColor 
      ),
    ),
  );
  // #endregion
  
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
                      // child: Image.network
                      // (
                      //   this.widget.banner,
                      //   fit: BoxFit.fill  ,
                      // )

                      //drop down button
                      child: _itemDown()
                    ),
                  ),
                  ListDetailProduct
                  (
                    listUser: this.widget.listUser,
                    isLogin: this.widget.isLogin,
                    size: size,
                    value : _value,
                    listProduct: this.widget.listProduct,
                    searchText: _searchText,
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