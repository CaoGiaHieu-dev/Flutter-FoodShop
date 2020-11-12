import 'package:foodshop/models/products.dart';
import 'package:foodshop/screens/detail/detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

// ignore: must_be_immutable
class TitleItems extends StatefulWidget
{
  final Future<List<Products>> listProduct;
  final String banner;
  Function callbackreload;
  TitleItems
  (
    {
      Key key,
      @required this.listProduct,
      @required this.banner,
      this.callbackreload
    }
  ) : super (key : key);
  @override
  _TittleItems createState() => _TittleItems(this.listProduct ,this.banner,this.callbackreload);
}
class _TittleItems extends State<TitleItems>
{
  Future<List<Products>> listProduct;
  String banner;
  Function callbackreload;
  _TittleItems(this.listProduct , this.banner ,this.callbackreload);

  @override
  Widget build(BuildContext context)
  {
    return Stack
    (
      children : <Widget>
      [
        Align
        (
          alignment: Alignment.centerLeft, 
          child: Text
          (
            "Hot Items",
            style: TextStyle
            (
              color: HexColor("#032535"),
              fontSize: 25,
              decoration: TextDecoration.underline
            ),
          ),
        ),
        FutureBuilder
        (
          future: listProduct,
          initialData: [],
          builder: (context, snapshot)
          {
            if(snapshot.hasData || snapshot.connectionState == ConnectionState.done)
            {
              if(snapshot.data.length > 6)
              {
                return GestureDetector
                (
                  onTap: ()
                  {
                    setState(() =>
                    {
                      Navigator.push
                      (
                        context, 
                        MaterialPageRoute
                        (
                          builder: (context) => MainDetail
                          (
                            banner : this.widget.banner,
                            listProduct :this.widget.listProduct,
                            key: UniqueKey(),
                          ),
                        )
                      ).then((value) 
                      {
                        setState(() 
                        {
                          this.widget.callbackreload();
                        });
                      })
                    });
                  },
                  child: Align
                  (
                    alignment: Alignment.centerRight, 
                    child: Text
                    (
                      "See more ...",
                      style: TextStyle
                      (
                        color: HexColor("#032535"),
                        fontSize: 25,
                        decoration: TextDecoration.underline
                      ),
                    ),
                  )
                );
              }
            }
            return Align
              (
                alignment: Alignment.centerRight, 
                child: Text
                (
                  "",
                  style: TextStyle
                  (
                    color: HexColor("#032535"),
                    fontSize: 25,
                    decoration: TextDecoration.underline
                  ),
                )
              );
          } ,
        )
     
      ]
      
    );
  }
}

