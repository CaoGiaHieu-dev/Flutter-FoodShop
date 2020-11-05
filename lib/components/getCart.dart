import 'dart:core';


import 'package:FoodShopApp/models/products.dart';

List<Products> _cartList = List<Products>();
List<Products> cartList =List<Products>() ;

addtoCart(dynamic _tempList)
{
  _cartList.add(_tempList);
  
  if(cartList.where((element) => element.id == _tempList.id).length < 1)
  {
    cartList.add(_tempList);
  }
}
int countlistCart()
{
  return _cartList.length;
}



int getItemInCart(int id)
{
  int count =0 ;
  for ( int i =0 ; i < _cartList.length ; i++)
  {
    if( int.parse(_cartList[i].id) == id)
    {
      count ++;
    }
  }
  return count;
  //_cartList.length;
}


removefromcart( int id )
{
  final items = _cartList.asMap();  //map cart list
  for( int i =0 ;i < _cartList.length ; i++)
  {
    if(int.parse(_cartList[i].id) == id)
    {
      _cartList.remove(items[i]);
      // ignore: unrelated_type_equality_checks
      if(_cartList.where((element) => element.id == id ).length ==0)
      {
        // ignore: unrelated_type_equality_checks
        cartList.removeWhere((element) => element.id == id) ;
      }
      break;
    }
  }
}

double getTotalPrice()
{
  double total = 0;
  for(int i = 0 ; i< cartList.length ; i++)
  {
    total += double.parse( cartList[i].price ) *getItemInCart(int.parse(cartList[i].id));
  } 
  return total;
}