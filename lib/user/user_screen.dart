import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodshop/components/constants.dart';
import 'package:foodshop/models/user.dart';
import 'package:foodshop/user/components/userpreferences.dart';
import 'package:foodshop/user/login.dart';
import 'package:foodshop/user/profile.dart';

class UserScreen extends StatefulWidget
{
  final bool isLogin;
  final bool isLoading;
  final List<User> listUser;
  final Function checkLogin;

  UserScreen
  (
    {
      Key key,
      @required this.isLogin,
      @required this.listUser,
      @required this.checkLogin,
      @required this.isLoading
    }
  ) : super ( key: key);

  @override
  _UserScreen createState() => _UserScreen(isLogin,listUser,checkLogin,isLoading);
}

class _UserScreen extends State<UserScreen>
{
  // #region property
  bool isLogin ;
  List<User> listUser;
  String _username;
  String _password;
  bool isLoading;
  Function checkLogin;
  // #endregion

  _UserScreen(this.isLogin,this.listUser,this.checkLogin,this.isLoading);
  // #region State
  @override
  void initState()
  {
    super.initState();
    
    // _isLoading = true;
    // _getStorage();
    // _checkLogin();
  }
  // #endregion
  
  // #region get Storage Data
//   _getStorage()
//   {
//     _username = UserPrefrences().getUserName; //get storage username
//     _password = UserPrefrences().getPassword; //get storage password
//   }
  // #endregion

  // #region Logout
  _logout() async
  {
    UserPrefrences().setUserName("");
    UserPrefrences().setPassword("");
    await checkLogin();
  }
  // #endregion

  // #region checkLogin
  // _checkLogin() async
  // {
  //   _getStorage();
  //   await getUser().then
  //   (
  //     (value) => listUser =
  //       value.where
  //       (
  //         (element) => element.username == _username && element.password == _password //get all list and then check account to login
  //       ).toList()
  //   ).whenComplete(()  
  //   {
  //     if( listUser != null && listUser.length !=0)
  //     {
  //       setState(() 
  //       {
  //         isLogin = true;
  //       });
  //     }
  //     else
  //     {
  //       setState(() 
  //       {
  //         isLogin = false;  
  //       });
  //     }
  //     _isLoading = false;
  //   });
  //   
  // }
  // #endregion

  @override
  Widget build(BuildContext context)
  {
    Size size = MediaQuery.of(context).size;
    return Scaffold
    (
      appBar: AppBar
      (
        //Style
        backgroundColor: kMainColor,
        elevation: 0,
        
        //tittle
        centerTitle: true,
        title: new Text('Food Shop tutorial'),
      ),

      body: isLoading == true
      ? Center(child: CircularProgressIndicator(),)
      : Material
      (
        child:this.widget.isLogin ==true 

        ? Profile
        (
          listUser : this.widget.listUser,
          logout : () async
          {
            await _logout().whenComplete(() async
            {
              setState(() =>
              {
                isLogin = this.widget.isLogin
              });
            }) ;
          },
          size: size,
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
                      return Login
                      (
                        isLogin: isLogin,
                        checkLogin : () async
                        {
                          await this.widget.checkLogin();
                          setState(() =>
                          {
                            isLogin = this.widget.isLogin
                          });
                          
                        } 
                      );
                    }
                  ).whenComplete(() async
                  {
                    await this.widget.checkLogin();
                    setState(() 
                    {
                      isLogin = this.widget.isLogin;
                    });
                  });
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