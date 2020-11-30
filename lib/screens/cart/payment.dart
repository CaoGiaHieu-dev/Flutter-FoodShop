
import 'package:foodshop/components/constants.dart';
import 'package:foodshop/components/cart.dart';
import 'package:foodshop/models/user.dart';
import 'package:foodshop/screens/cart/info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Payment extends StatefulWidget
{
  final Size size ;
  final bool isLogin;
  final List<User> listUser;
  Payment
  (
    {
      Key key,
      this.size,
      @required this.isLogin,
      @required this.listUser
    }
  ) : super ( key : key);
  @override
  _Payment createState() => _Payment(size);
}

class _Payment extends State<Payment>
{
  Size size;
  _Payment(this.size);

  // #region getLocation
//   Position _currentPosition;
//   String _currentAddress;
//   final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
//   _getCurrentLocation() async
//   {
//     geolocator.getCurrentPosition
//     (
//       desiredAccuracy: LocationAccuracy.best
//     ).then
//     (
//       (Position position) 
//       {
//         _currentPosition = position;
//       }
//     ).catchError((e) 
//     {
//       print(_currentPosition.longitude  +  _currentPosition.latitude);
//     });
//   }
// 
//   _getAddressFromLatLng() async 
//   {
//     try 
//     {
//       List<Placemark> p = await geolocator.placemarkFromCoordinates(_currentPosition.latitude, _currentPosition.longitude);
// 
//       Placemark place = p[0];
// 
//       _currentAddress = "${place.subThoroughfare}, ${place.thoroughfare}, ${place.subAdministrativeArea} , ${place.administrativeArea}, ${place.country} ";
//     } 
//     catch (e) 
//     {
//       print(e);
//     }
//   }
  // #endregion

  // #region State

  @override
  void initState()
  {
    super.initState();
    // _getCurrentLocation();
    // _getAddressFromLatLng();
  }
  // #endregion
  @override
  Widget build(BuildContext context)
  {
    return GestureDetector
    (
      onTap: () 
      {
        showDialog
        (
          context: context,
          builder: (BuildContext context)
          {
            return Info
            (
              size: size,
              isLogin : this.widget.isLogin,
              listUser : this.widget.listUser
            );
          }
        ).then
        (
          (value) 
          {
            setState(() =>
            {
              
            });
          }
        ).whenComplete(() => 
        {
          showDialog
          (
            context: context,
            builder: (BuildContext context)
            {
              return AlertDialog
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
                content: Text
                (
                  "Payment Succecss"
                ),
              );
            }
          )
        });
      },
      child : Container
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
          child: Row
          (
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>
            [
              Icon
              (
                Icons.payment,
                color: HexColor("##F9DC5C"),
              ),
              Align
              (
                alignment: Alignment.center,
                child : Text
                (
                  "Total : " + getTotalPrice().toStringAsFixed(2),
                  maxLines: 2,
                  overflow: TextOverflow.visible,
                  style: TextStyle
                  (
                    color: HexColor("##F9DC5C"),
                    fontSize: 16,
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}