import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodshop/components/constants.dart';
import 'package:foodshop/components/user.dart';
import 'package:foodshop/models/user.dart';
import 'package:foodshop/user/components/userpreferences.dart';

class Login extends StatefulWidget
{
  final bool isLogin ;
  Login
  (
    {
      Key key ,
      this.isLogin
    }
  ) : super (key: key);
  @override
  _Login createState() => _Login(isLogin);
}

class _Login extends State<Login>
{
  // #region property
  bool _validateUserName = false;
  bool _validatePassword = false;
  String _username ;
  String _password ;
  Future<List<User>> listUser;

  
  bool isLogin ;
  _Login(isLogin);
  // #endregion

  // #region State
  @override
  void initState()
  {
    super.initState();
    listUser = getUser();
    _username="";
    _password="";
  }
  // #endregion

  // #region Check Login
  List<User> _tempList =[];
  _checkUser() async
  {
    await listUser.then
    (
      (value) 
      {
        _tempList = value.where((element) => element.username == _username && element.password == _password).toList();
        if(_tempList.isNotEmpty)
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
      } 
    );
  }
  // #endregion

  @override
  Widget build(BuildContext context)
  {
    Size size = MediaQuery.of(context).size;
    return AlertDialog
    (
      content : SingleChildScrollView
      (
        child: Center
        (
          child: Column
          (
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>
            [
              //image
              Container
              (
                height: size.height *0.25 -25,
                width:  size.width *0.5,
                decoration: BoxDecoration
                (
                  color: kMainColor,
                  borderRadius: BorderRadius.all
                  (
                    Radius.circular(15)
                  ),
                ),
                child: SvgPicture.asset
                (
                  ("assets/images/logo-full.svg"),
                  height: 50,
                ),
              ),
              // input username
              Container
              (
                padding: EdgeInsets.only
                (
                  top: 10,
                  bottom: 10
                ),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width -100,
                child: TextField
                (
                  keyboardType: TextInputType.emailAddress ,
                  textAlign: TextAlign.center,
                  controller: TextEditingController
                  (
                    text: _username
                  ),
                  decoration: InputDecoration
                  (
                    errorText: _validateUserName ? "User name can't be empty" : null,
                    hintText: "Username",
                    border: OutlineInputBorder
                    (
                      borderSide: BorderSide
                      (
                        color: kMainColor,
                      )
                    )
                  ),
                  onChanged: (text)
                  {
                    if(text.isEmpty)
                    {
                      _validateUserName = true;
                      _username = "";
                    }
                    else
                    {
                      _username = text;
                    }
                  },
                )
              ),

              //input address
              Container
              (
                padding: EdgeInsets.only
                (
                  top: 10,
                  bottom: 10
                ),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width -100,
                child: TextField
                (
                  enableSuggestions: false,
                  autocorrect: false,
                  obscureText : true,
                  controller: TextEditingController
                  (
                    text : _password
                  ),
                  keyboardType: TextInputType.visiblePassword ,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration
                  (
                    errorText: _validatePassword ? "Password can't not empty" : null,
                    
                    hintText: "Password",
                    border: OutlineInputBorder
                    (
                      borderSide: BorderSide
                      (
                        color: kMainColor,
                      )
                    )
                  ),
                  onChanged: (text)
                  {
                    if(text.isEmpty)
                    {
                      _validatePassword= true;
                      _password ="";
                    }
                    else
                    {
                      _password = text;
                    }
                  },
                )
              ),

              //button
              GestureDetector
              (
                onTap: () async 
                {
                  await  _checkUser();
                  setState(() =>
                  {
                    if(isLogin==true)
                    {
                      UserPrefrences().setUserName(_username),
                      UserPrefrences().setPassword(_password),
                      Navigator.pop(context)
                    }
                    else
                    {
                      _username.isEmpty ? _validateUserName = true : _validateUserName = false,
                      _password.isEmpty ? _validatePassword = true : _validatePassword = false,
                      if(_username.isNotEmpty && _password.isNotEmpty)
                      {
                        showDialog
                        (
                          context: context,
                          child: AlertDialog
                          (
                            actions: 
                            [
                              RaisedButton
                              (
                                onPressed: ()
                                {
                                  Navigator.pop(context);
                                },
                                child: Icon(Icons.close),
                              )
                            ],
                            content: Container
                            (
                              height: 100,
                              width: 100,
                              child: Text("error"),
                            ),
                          )
                        )
                      }
                    }
                  });
                },
                child: Container
                (
                  padding: EdgeInsets.only
                  (
                    left: 10,
                    right: 10
                  ),
                  height: size.height *0.05 + 20,
                  width: size.width *0.6 - 50,
                  decoration: BoxDecoration
                  (
                    borderRadius: BorderRadius.circular(36),
                    color: kMainColor,
                  ),
                  child: Align
                  (
                    alignment: Alignment.center,
                    child: Text
                    (
                      "Login",
                      style: TextStyle
                      (
                        fontSize:  15,
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}