import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodshop/models/user.dart';

class Profile extends StatefulWidget
{
  final List<User> listUser ;
  final Function logout;
  final Size size;
  Profile
  (
    {
      Key key , 
      this.listUser,
      this.logout,
      this.size
    }
  ) : super(key: key);
  @override
  _Profile createState() => _Profile(listUser,size,logout);
}

class _Profile extends State<Profile>
{
  List<User> listUser ;
  Size size;
  Function logout;
  _Profile(this.listUser,this.size,this.logout);

  @override
  void initState()
  {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context)
  {
    return SingleChildScrollView
    (
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only
      (
        top: 15,
        left: 10,
        right: 10
      ),
      child: Column
      (
        children: <Widget>
        [
          //image
          Center
          (
            child: ClipRRect
            (
              borderRadius: BorderRadius.circular(30.0),
              child: CachedNetworkImage
              (
                imageUrl: listUser.first.avatar,
                width: size.width -50,
                alignment: Alignment.center,
                placeholder: (context, url) => new CircularProgressIndicator(),
                errorWidget: (context, url, error) => new Icon(Icons.error),
              ),
              // child: Image.network
              // (
              //   CachedNetworkImage,
              //   width: size.width -50,
              //   alignment: Alignment.center,
              // ),
            ),
          ),

          //user name
          Container
          (
            margin: EdgeInsets.only
            (
              top: 15
            ),
            padding: EdgeInsets.only
            (
              left: 10,
              right: 10
            ),
            height: size.height * 0.2 - 100, 
            width:size.width -20,
            decoration: BoxDecoration
            (
              color: Colors.white,
              borderRadius: BorderRadius.all
              (
                Radius.circular(10)
              ),
              boxShadow: 
               [
                BoxShadow
                (
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ], 
            ),

            child: Row
            (
              children: <Widget>
              [
                Text
                (
                  "Email Address :",
                  style: TextStyle
                  (
                    fontSize: 15  ,
                  ),
                  textAlign: TextAlign.center
                ),
                Spacer(),
                Text
                (
                  listUser.first.username,
                  style: TextStyle
                  (
                    fontSize: 15  ,
                  ),
                  textAlign: TextAlign.center
                ),
              ],
            ),
          ),

          //address
          Container
          (
            margin: EdgeInsets.only
            (
              top: 15
            ),
            padding: EdgeInsets.only
            (
              left: 10,
              right: 10
            ),
            height: size.height * 0.2 - 100, 
            width:size.width -20,
            decoration: BoxDecoration
            (
              color: Colors.white,
              borderRadius: BorderRadius.all
              (
                Radius.circular(10)
              ),
              boxShadow: 
               [
                BoxShadow
                (
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ], 
            ),

            child: Row
            (
              children: <Widget>
              [
                Text
                (
                  "Address :",
                  style: TextStyle
                  (
                    fontSize: 15  ,
                  ),
                  textAlign: TextAlign.center
                ),
                Spacer(),
                Text
                (
                  listUser.first.address,
                  style: TextStyle
                  (
                    fontSize: 15  ,
                  ),
                  textAlign: TextAlign.center
                ),
              ],
            ),
          ),

          //phonenumber
          Container
          (
            margin: EdgeInsets.only
            (
              top: 15
            ),
            padding: EdgeInsets.only
            (
              left: 10,
              right: 10
            ),
            height: size.height * 0.2 - 100, 
            width:size.width -20,
            decoration: BoxDecoration
            (
              color: Colors.white,
              borderRadius: BorderRadius.all
              (
                Radius.circular(10)
              ),
              boxShadow: 
               [
                BoxShadow
                (
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ], 
            ),

            child: Row
            (
              children: <Widget>
              [
                Text
                (
                  "Phone number :",
                  style: TextStyle
                  (
                    fontSize: 15  ,
                  ),
                  textAlign: TextAlign.center
                ),
                Spacer(),
                Text
                (
                  listUser.first.phonenumber,
                  style: TextStyle
                  (
                    fontSize: 15  ,
                  ),
                  textAlign: TextAlign.center
                ),
              ],
            ),
          ),
          SizedBox
          (
            height: 20,
          ),
          Align
          (
            alignment: Alignment.bottomCenter,
            child: RaisedButton
            (
              onPressed: ()
              {
                setState(() =>
                {
                  logout(),
                });
              },
              child: Text
              (
                "Logout"
              ),
            ),
          )
        ]
      ),
    );
  }
}