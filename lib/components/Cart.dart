import 'dart:convert';
import 'dart:core';


import 'package:foodshop/models/cart.dart';
import 'package:foodshop/models/products.dart';
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

cleanCart()
{
  _cartList.clear();
}

getListCart()
{
  return _cartList;
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
    double totalPrice = 0;
    cartList[i].discount ? totalPrice = double.parse(cartList[i].price) - double.parse(cartList[i].price) *(10/100) : totalPrice = double.parse(cartList[i].price) ;
    total += totalPrice *getItemInCart(int.parse(cartList[i].id));
  } 
  return total;
}
Future<Cart> postCart(String time ,int number ,double total ,String userId , String productId ,String phonenumber,String address) async
{
  final http.Response response = await http.post
  (
    'https://5f96864411ab98001603ac4b.mockapi.io/Cart',
    headers: <String, String>
    {
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode
    (
      <dynamic,dynamic>
      {
        'create_at' : time,
        'number': number,
        'total' : int.parse(total.toStringAsFixed(0)),
        'UserId' : userId,
        'ProductId' :productId,
        'phonenumber' : phonenumber,
        'address' : address
      }
    )
  );

  if (response.statusCode == 201) 
  {
    return Cart.fromJson(jsonDecode(response.body));
  } 
  else 
  {
    throw Exception('Failed to post cart.');
  }
}

Future<List<Cart>> getCart() async 
{
  final response = await http.get("https://5f96864411ab98001603ac4b.mockapi.io/Cart",headers: {'Content-Type': 'application/json'});
  if (response.statusCode == 200) 
  {
    var parsedCart = json.decode(utf8.decode(response.bodyBytes));
    //fetch api to model
    List<Cart> _cart = List<Cart>();
    parsedCart.forEach
    (
      (values) 
      {
        _cart.add(Cart.fromJson(values));
      }
    );
    return _cart;
  } 
  else 
  {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load ');
  }
  // var result = await http.get(apiUrl);
  // return json.decode(result.body);
}