import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodshop/user/login.dart';

class UserScreen extends StatefulWidget
{

  @override
  _UserScreen createState() => _UserScreen();
}

class _UserScreen extends State<UserScreen>
{
  // #region property
  bool isLogin ;

  // #endregion

  @override
  void initState()
  {
    super.initState();
    isLogin = false;
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      body: Center
      (
        child:isLogin ==true 
        ? Text
        (
          "Hall"
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
                      return Login();
                    }
                  ).then
                  (
                    (value) 
                    {
                      setState(() =>
                      {
                        isLogin = true
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