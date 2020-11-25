
import 'package:foodshop/components/cart.dart';
import 'package:foodshop/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodshop/models/user.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:hexcolor/hexcolor.dart';

class Info extends StatefulWidget
{
  final Size size;
  final List<User> listUser;
  final bool isLogin;
  Info
  (
    {
      Key key,
      this.size,
      @required this.isLogin,
      @required this.listUser,
    }
  ) : super ( key: key);

  @override 
  _Info createState() => _Info(size);
}

class _Info extends State<Info>
{
  Size size ;
  _Info(this.size);

  // #region property
  int _dateTime = DateTime.now().millisecondsSinceEpoch;
  bool _validatePhoneNumber = false;
  bool _validateAddress = false;
  String address="";
  String phoneNumber="";
  bool _isLoading ;
  // #endregion

  // #region State
  
  @override
  void initState()
  {
    super.initState();
    _getCurrentLocation();
    _isLoading = true;
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
          _currentPosition = position,
          _isLoading = false
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
      return this.widget.isLogin== false
      ? AlertDialog (content: Text("you wasn't Login"),) 
      : AlertDialog
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
                    _dateTime.toString(), //get time payment
                    getItemInCart(int.parse(cartList[i].id)), //count number of product in Cart 
                    !cartList[i].discount //check discount 
                    ?  ( double.parse( cartList[i].price ) *getItemInCart(int.parse(cartList[i].id)) ) //get total price when discount of product 
                    : (double.parse(cartList[i].price) - double.parse(cartList[i].price) * (10/100)) * getItemInCart(int.parse(cartList[i].id)) , //get total price when discount of product 
                    this.widget.listUser.first.id,  //get User id
                    cartList[i].id.toString(),  //get Product id
                    phoneNumber,  //get PhoneNumber on input
                    address //get Address on input
                  );
                }
                // SnackBar
                // (
                //   content: Text
                //   (
                //     "Success",
                //   ),
                // );
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
                  controller: TextEditingController
                  (
                    text: phoneNumber
                  ),
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
                      phoneNumber.isEmpty;
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
              //GetGoogleMap
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
                      phoneNumber = phoneNumber;
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