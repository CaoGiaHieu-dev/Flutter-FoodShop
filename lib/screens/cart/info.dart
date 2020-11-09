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

  // #region State
  String _userId="";
  String _phoneNumber="";
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
            Navigator.pop(context);
          },
          child: Icon(Icons.close),
        )
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
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width -100,
              child: TextField
              (
                textAlign: TextAlign.center,
                decoration: InputDecoration
                (
                  hintText: "Input user id",
                  border: InputBorder.none 
                ),
              )
            ),
            Container
            (
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width -100,
              child: TextField
              (
                textAlign: TextAlign.center,
                decoration: InputDecoration
                (
                  hintText: "Input phone number",
                  border: InputBorder.none 
                ),
                onChanged: (text)
                {
                  _phoneNumber = text;
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
                initialCameraPosition: CameraPosition
                (
                  target: _center,
                  zoom: 11.0,
                ),
              ),
            )
        ]
    )
    ),
      // content:SingleChildScrollView
      // (
      //   child : Column
      //   (
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>
      //     [
      //       Container
      //       (
      //         decoration: BoxDecoration
      //         (
      //           color: kMainColor,
      //           borderRadius: BorderRadius.circular(36)
      //         ),
      //         child: Align
      //         (
      //           alignment: Alignment.center,  
      //           child: Text
      //           (
      //             "Payment",
      //             style: TextStyle
      //             (
      //               color: HexColor("##F9DC5C"), 
      //               fontSize: 25,
      //             ),
      //           ),
      //         ),
      //       ),
      //       Spacer(),
      //       Container
      //       (
      //         alignment: Alignment.center,
      //         width: MediaQuery.of(context).size.width -100,
      //         child: TextField
      //         (
      //           textAlign: TextAlign.center,
      //           decoration: InputDecoration
      //           (
      //             hintText: "Input user id",
      //             border: InputBorder.none 
      //           ),
      //         )
      //       ),
      //       Container
      //       (
      //         alignment: Alignment.center,
      //         width: MediaQuery.of(context).size.width -100,
      //         child: TextField
      //         (
      //           textAlign: TextAlign.center,
      //           decoration: InputDecoration
      //           (
      //             hintText: "Input phone number",
      //             border: InputBorder.none 
      //           ),
      //           onChanged: (text)
      //           {
      //             _phoneNumber = text;
      //           },
      //         )
      //       ),
      //       Spacer(),
      //       // SizedBox
      //       // (
      //       //   height: MediaQuery.of(context).size.height *0.5 -30,
      //       //   width: MediaQuery.of(context).size.width -20,
      //       //   child: GoogleMap
      //       //   (
      //       //     onMapCreated: _onMapCreated,
      //       //     initialCameraPosition: CameraPosition
      //       //     (
      //       //       target: _center,
      //       //       zoom: 11.0,
      //       //     ),
      //       //   ),
      //       // )
      //     ],
      //   )
      // )
    ); 
  }
}