import 'dart:convert';

import 'package:FoodShopApp/models/category.dart';
import 'package:http/http.dart' as http;

final String apiUrl ="https://5f96864411ab98001603ac4b.mockapi.io/Categories";

Future<List<Category>> getCategories() async 
{
  final response = await http.get(apiUrl);
  if (response.statusCode == 200) 
  {
    var parsedCategory = json.decode(response.body);
    //fetch api to model
    List<Category> _category = List<Category>();
    parsedCategory.forEach
    (
      (values) 
      {
        _category.add(Category.fromJSON(values));
      }
    );
    return _category;
  } 
  else 
  {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load ');
  }
  // var result = await http.get(apiUrl);
  // return json.decode(result.body);
}

