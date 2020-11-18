import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodshop/components/user.dart';
import 'package:foodshop/models/user.dart';
import 'package:foodshop/user/components/userpreferences.dart';
import 'package:foodshop/user/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserScreen extends StatefulWidget
{

  @override
  _UserScreen createState() => _UserScreen();
}

class _UserScreen extends State<UserScreen>
{
  // #region property
  bool isLogin ;
  List<User> listUser;
  String _username;
  String _password;
  bool _isLoading;
  // #endregion

  // #region State
  @override
  void initState()
  {
    super.initState();
    _username = UserPrefrences().getUserName; //get storage username
    _password = UserPrefrences().getPassword; //get storage password
    _isLoading = true;

    
    _checkLogin();
    
    
  }
  // #endregion
  
  // #region checkLogin
  _checkLogin() async
  {
    await getUser().then
    (
      (value) => listUser =
        value.where
        (
          (element) => element.username == _username && element.password == _password //get all list and then check account to login
        ).toList()
    ).whenComplete(()  
    {
      if( listUser != null && listUser.length !=0)
      {
        setState(() 
        {
          isLogin = true;
        });
      }
      else
      {
        setState(() 
        {
          isLogin = false;  
        });
      }
      _isLoading = false;
    });
    
  }
  // #endregion

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      body: _isLoading == true
      ? Center(child: CircularProgressIndicator(),)
      : Center
      (
        child:isLogin ==true 
        ? 
        (
          SingleChildScrollView
          (
            padding: EdgeInsets.all(20),
            child: Container
            (
              decoration: BoxDecoration
              (
                
              ),
              child: Image
              (
                image: NetworkImage
                (
                  listUser.first.avatar
                ),
              )
            ),
          )
        )
        : Center
        (
          child: Column
          (
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>
            [
              Text
              (
                "not login"
              ),
              RaisedButton
              (
                onPressed: () 
                {
                  showDialog
                  (
                    context: context,
                    builder: (BuildContext context)
                    {
                      return Login(isLogin: isLogin,);
                    }
                  ).then
                  (
                    (value) 
                    {
                      setState(() =>
                      {
                      });
                    }
                  );
                },
                child: Text("login"),
              )
            ],
          ),
        )
      ),
    );
  }
}