import 'package:shared_preferences/shared_preferences.dart';

//String listKey = "favoriteList";

// void storeFavoriteList(String userId,List<String> list) async
// {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.setStringList(userId, list);
// }
// 
// Future<List<String>> getFavoriteList(String userId) async
// {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   return prefs.getStringList(userId);
// }
// 
// void removeFavoriteList(String userId) async
// {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.remove(userId);
// }

class FavoritePrefrences 
{
  static final FavoritePrefrences _instance = FavoritePrefrences._ctor();

  factory  FavoritePrefrences()
  {
    return _instance;
  }

  FavoritePrefrences._ctor() ;

  SharedPreferences _preferences;

  init() async
  {
    _preferences = await SharedPreferences.getInstance();
  }
  
  // #region Get Data
  getFavoriteList(String userId) async
  {
    return _preferences.getStringList(userId);
  }

  get getPassword
  {
    return _preferences.getString("password") ?? "";
  }
  // #endregion

  //#region Set Data
  Future setUserName (String username) async
  {
    await _preferences.setString("username", username);
  }

  Future setPassword (String password) async
  {
     await _preferences.setString('password',password) ;
  }
  //#endregion
}

