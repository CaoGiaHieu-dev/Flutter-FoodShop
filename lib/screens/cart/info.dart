
import 'package:foodshop/components/cart.dart';
import 'package:foodshop/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:hexcolor/hexcolor.dart';

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

  int _dateTime = DateTime.now().millisecondsSinceEpoch;
  bool _validatePhoneNumber = false;
  bool _validateAddress = false;

  // #region State
  String address="";
  String phoneNumber="";
  bool _isLoading =true;
  @override
  void initState()
  {
    super.initState();
    _getCurrentLocation();
    _isLoading = false;
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
    if(_isLoading)
      return AlertDialog (content: CircularProgressIndicator(),);
    else
      return AlertDialog
      (
        actions: <Widget>
        [
          RaisedButton
          (
            color: kButtonColor,
            onPressed: ()
            {
              if( address.isNotEmpty && phoneNumber.isNotEmpty )
              {
                for(int i = 0 ; i<cartList.length ; i++)
                {
                  postCart
                  (
                    _dateTime.toString(),
                    getItemInCart(int.parse(cartList[i].id)).toString(), 
                    ( double.parse( cartList[i].price ) *getItemInCart(int.parse(cartList[i].id)) ).toString(), 
                    "1", 
                    cartList[i].id.toString(),
                    phoneNumber,
                    address
                  );
                }
                SnackBar
                (
                  content: Text
                  (
                    "Success",
                  ),
                );
                setState(() =>
                {
                  cartList.clear(),
                  cleanCart(),    
                });
                Navigator.pop(context);
              }
              else
              {
                setState(() =>
                {
                  phoneNumber.isEmpty ? _validatePhoneNumber = true : _validatePhoneNumber = false,
                  address.isEmpty ? _validateAddress = true : _validateAddress=false
                });
              }
              
              
            },
            child: Row
            (
              children: <Widget>
              [
                Icon(Icons.payments),
                Text
                (
                  getTotalPrice().toString(),
                  style: TextStyle
                  (
                    fontSize: 16,
                  ),
                ),
              ],
            )
          ),
          RaisedButton
          (
            color: kButtonColor,
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

              // input phone number
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
                    errorText: _validatePhoneNumber ? "phone number can't be empty" : null,
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
                    if(text.isEmpty)
                    {
                      _validatePhoneNumber= true;
                      phoneNumber = "";
                    }
                    else
                    {
                      phoneNumber = text;
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
                  controller: TextEditingController
                  (
                    text: address
                  ),
                  keyboardType: TextInputType.streetAddress ,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration
                  (
                    errorText: _validateAddress ? "Address can't not empty" : null,
                    icon: Icon
                    (
                      Icons.location_on,
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
                    if(text.isEmpty)
                    {
                      _validateAddress= true;
                      address.isEmpty;
                    }
                    else
                    {
                      address = text;
                    }
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