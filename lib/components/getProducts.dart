import 'dart:convert';
import 'package:FoodShopApp/models/products.dart';
import 'package:http/http.dart' as http;

String getProductApi( String categoryId , String productId)
{
  return "https://5f96864411ab98001603ac4b.mockapi.io/Categories/$categoryId/Products/$productId";
}


Future<List<Products>> getProducts(String categoryId , String productId) async 
{
  final response = await http.get(getProductApi(categoryId,productId));
  if (response.statusCode == 200) 
  {
    var parsedProducts = json.decode(response.body);
    //fetch api to model
    List<Products> _products = List<Products>();
    parsedProducts.forEach
    (
      (values) 
      {
        _products.add(Products.fromJson(values));
      }
    );
    
    return _products;
  } 
  else 
  {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load ');
  }
  // var result = await http.get(apiUrl);
  // return json.decode(result.body);
}

