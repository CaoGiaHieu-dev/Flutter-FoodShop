
import 'package:foodshop/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:hexcolor/hexcolor.dart';

import 'map.dart';

class Info extends StatefulWidget
{
  final Size size;
  Info
  (
    {
      Key key,
      this.size,
    }
  ) : super ( key: key);

  @override 
  _Info createState() => _Info(size);
}

class _Info extends State<Info>
{
  Size size ;
  _Info(this.size);

  // #region State
  String address="";
  String phoneNumber="";

  @override
  void initState()
  {
    super.initState();
    _getCurrentLocation();
  }
  // #endregion

  // #region Google Map
  PickResult selectedPlace;
  Geolocator geolocator ;
  Position _currentPosition;
  _getCurrentLocation() async
  {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best).then
    (
      (Position position) 
      {
        setState(() =>
        {
          _currentPosition = position
        });
      }
    ).catchError((e) 
    {
      print(e);
    });
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

          },
          child: Icon(Icons.payments),
        ),
        RaisedButton
        (
          onPressed: () 
          {
            Navigator.pop(context);
          },
          child: Icon(Icons.close),
        ),
        
      ],
      content: SingleChildScrollView
      (
        scrollDirection: Axis.vertical,
        child: Column
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
                keyboardType: TextInputType.number ,
                textAlign: TextAlign.center,
                decoration: InputDecoration
                (
                  icon: Icon
                  (
                    Icons.phone_callback,
                    color: kButtonColor,
                  ),
                  hintText: "Input phone number",
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
                  phoneNumber = text;
                },
              )
            ),
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
                controller: TextEditingController
                (
                  text: address
                ),
                keyboardType: TextInputType.streetAddress ,
                textAlign: TextAlign.center,
                decoration: InputDecoration
                (
                  icon: Icon
                  (
                    Icons.home,
                    color: kButtonColor,
                  ),
                  hintText: "Input address",
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
                  address = text;
                },
              )
            ),
            //GetGoogleMap()
            SizedBox
            (
              height: MediaQuery.of(context).size.height *0.5 -30,
              width: MediaQuery.of(context).size.width -20,
              child: PlacePicker
              (
                apiKey: apiKey,
                initialPosition: LatLng(_currentPosition.latitude,_currentPosition.longitude),
                useCurrentLocation: true,
                selectInitialPosition: true,
                automaticallyImplyAppBarLeading:false,
                onPlacePicked: (result) 
                {
                  selectedPlace = result;
                  setState(() 
                  {
                    address = selectedPlace.formattedAddress;
                  });
                  
                  // setState
                  // ( () => 
                  //   {
                  //     address = selectedPlace.formattedAddress
                  //   }
                  // );
                },
              )
            )
          ]
        )
      ),
    ); 
  }
}