import 'dart:convert';
import 'dart:core';


import 'package:FoodShopApp/models/cart.dart';
import 'package:FoodShopApp/models/products.dart';
import 'package:http/http.dart' as http;

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
Future<Cart> postCart(int number ,String total ,String userId , String productId) async
{
  // ignore: non_constant_identifier_names
  var json_body = 
  {
    'number ': number,
    'total' : total,
    'UserId' : userId,
    'ProductId' :productId,
  };
  final http.Response response = await http.post
  (
    'https://5f96864411ab98001603ac4b.mockapi.io/Cart',body: json_body
  );

  if (response.statusCode == 201) {
    return Cart.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to post cart.');
  }
}