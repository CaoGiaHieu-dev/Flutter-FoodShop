import 'package:FoodShopApp/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

class Info extends StatefulWidget
{
  final Size size;
  Info
  (
    {
      Key key,
      this.size
    }
  ) : super ( key: key);

  @override 
  _Info createState() => _Info(size);
}

class _Info extends State<Info>
{
  Size size ;
  _Info(this.size);

  // #region Google
  // ignore: unused_field
  GoogleMapController _controller ;

  final LatLng _center = const LatLng(10.762622, 106.660172);

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }
  // #endregion

  @override
  Widget build(BuildContext context)
  {
    return AlertDialog
    (
      actions: <Widget>
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
        width: size.width -10,
        child : Column
        (
          children: <Widget>
          [
            Container
            (
              decoration: BoxDecoration
              (
                color: kMainColor,
                borderRadius: BorderRadius.circular(36)
              ),
              child: Align
              (
                alignment: Alignment.center,  
                child: Text
                (
                  "Payment",
                  style: TextStyle
                  (
                    color: HexColor("##F9DC5C"), 
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            
            SizedBox
            (
              height: MediaQuery.of(context).size.height *0.5 -30,
              width: MediaQuery.of(context).size.width -20,
              child: GoogleMap
              (
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition
                (
                  target: _center,
                  zoom: 11.0,
                ),
              ),
            )
          ],
        )
      ),
    ); 
  }
}