import 'package:foodshop/components/constants.dart';
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

  // #region Google
  // ignore: unused_field
  GoogleMapController _controller ;

  void _onMapCreated(GoogleMapController controller) 
  {
    _controller = controller;
  }
  // #endregion

  // #region State
  String address="";
  String phoneNumber="";

  @override
  void initState()
  {
    super.initState();
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
                  text: ""
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
            SizedBox
            (
              height: MediaQuery.of(context).size.height *0.5 -30,
              width: MediaQuery.of(context).size.width -20,
              child: GoogleMap 
              (
                onMapCreated: _onMapCreated,
                
              ),
            )
          ]
        )
      ),
    ); 
  }
}