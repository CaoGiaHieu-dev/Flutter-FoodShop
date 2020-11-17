import 'dart:convert';

import 'package:foodshop/models/user.dart';
import 'package:http/http.dart' as http;

// Future<User> postCart(String time ,int number ,double total ,String userId , String productId ,String phonenumber,String address) async
// {
//   final http.Response response = await http.post
//   (
//     'https://5f96864411ab98001603ac4b.mockapi.io/Cart',
//     headers: <String, String>
//     {
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode
//     (
//       <Object,Object>
//       {
//         'create_at' : time,
//         'number': number,
//         'total' : total,
//         'UserId' : userId,
//         'ProductId' :productId,
//         'phonenumber' : phonenumber,
//         'address' : address
//       }
//     )
//   );
// 
//   if (response.statusCode == 201) 
//   {
//     return Cart.fromJson(jsonDecode(response.body));
//   } 
//   else 
//   {
//     throw Exception('Failed to post cart.');
//   }
// }

Future<List<User>> getUser() async 
{
  final response = await http.get
  (
    "https://5f96864411ab98001603ac4b.mockapi.io/User",
    headers: 
    {
      'Content-Type': 'application/json'
    }
  );
  if (response.statusCode == 200) 
  {
    var parsedUser = json.decode(utf8.decode(response.bodyBytes));
    //fetch api to model
    List<User> _user = List<User>();
    parsedUser.forEach
    (
      (values) 
      {
        _user.add(User.fromJson(values));
      }
    );
    return _user;
  } 
  else 
  {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load ');
  }
  // var result = await http.get(apiUrl);
  // return json.decode(result.body);
}