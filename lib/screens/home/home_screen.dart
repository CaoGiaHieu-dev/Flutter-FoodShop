
import 'package:foodshop/components/constants.dart';
import 'package:foodshop/components/categories.dart';
import 'package:foodshop/components/Products.dart';
import 'package:foodshop/components/cart.dart';
import 'package:foodshop/models/category.dart';
import 'package:foodshop/models/products.dart';
import 'package:foodshop/screens/cart/cart_screen.dart';
import 'package:foodshop/screens/home/components/getupdateProducts.dart';
import 'package:foodshop/screens/home/components/getupdateTitleItems.dart';
import 'package:foodshop/screens/home/listItems.dart';
import 'package:foodshop/screens/home/swipeList.dart';
import 'package:foodshop/screens/home/titleItems.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import '../appbar.dart';
import '../header.dart';


class HomeScreen extends StatefulWidget
{
  @override
  _HomeSceen createState() => _HomeSceen();
}

class _HomeSceen extends State<HomeScreen>
{
  
  // #region property
  String categoryId;
  Future<List<Category>> listcategories ;
  Future<List<Products>> listproducts ;
  int number ;
  String detailbaner="";
  GlobalKey<ScaffoldState> _scaffold = GlobalKey();
  
  // #endregion
  // #region Appbar custom
  _HomeSceen() 
  {
    searchBar = new SearchBar
    (
      inBar: false,
      setState: setState,
      onSubmitted: print,
      buildDefaultAppBar: appbar
    );
  }
  // #endregion
  // #region StateFAB
  // #region getBaner
  String _detailbaner()
  {
    if ( detailbaner == "")
    {
      listcategories.then((value) => detailbaner = value.where((element) => element.id == "1").first.image);
    }
    return detailbaner;
  }
  // #endregion
  Widget fab = FloatingActionButton.extended
  (
    //key: UniqueKey(),
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
  // #region State
  @override
  void initState()
  {
    listcategories = getCategories();

    if(categoryId == null || categoryId =="" )
    {
      listproducts =  getProducts("1","");
    }
    else
    {
      listproducts = getProducts(categoryId, "");
    }
    
    super.initState();
  }
  // #endregion
  
  @override
  Widget build (BuildContext context) 
  {
    Size size = MediaQuery.of(context).size;
    //Start coding ...
    return new Scaffold
    (
      appBar:searchBar.build(context),

      key: _scaffold,
      floatingActionButton: fab,

      body:  SingleChildScrollView
      (
        child : Column
        (
          children : <Widget>
          [
            Header(size: size),
            Container
            (
              child: Column
              (
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>
                [
                  SwipeList
                  (
                    size: size , 
                    category: listcategories,
                    detailbaner : detailbaner,
                    presstoLoad: (item)
                    {
                      setState(() 
                      {
                        listproducts = getProducts(item,"");
                        listcategories.then((value) => detailbaner = value.where((element) => element.id == item).first.image);
                      });
                    },
                  ),
                  UpdateTitleItems
                  (
                    banner: detailbaner , 
                    child: TitleItems
                    (
                      listProduct: listproducts,
                      banner : _detailbaner(),
                      callbackreload: ()  =>
                      {
                        _fabChange(),
                      } 
                    ),
                  ),
                  FutureBuilder
                  (
                    //key: UniqueKey(),
                    initialData: [],
                    future: listproducts,
                    builder: (context, snapshot)
                    {
                      if(snapshot.hasData && snapshot.connectionState == ConnectionState.done)
                      {
                        return UpdateListItems 
                        (
                          listProducts: snapshot.data,
                          child: ListItems
                          (
                            products: listproducts,
                            number: number,
                            press: () =>
                            {
                              _fabChange()
                            },
                            size: size,
                          ),
                        );
                      }
                      return Center
                      (
                        child : CircularProgressIndicator()
                      );
                    },
                  )
                ],
              ),
            )
          ]
        ),
      )
    );
  }
}