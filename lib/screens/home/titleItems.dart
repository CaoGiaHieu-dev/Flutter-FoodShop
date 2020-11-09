import 'package:foodshop/models/category.dart';
import 'package:foodshop/screens/detail/detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TitleItems extends StatefulWidget
{
  final Future<List<Category>> category;

  TitleItems
  (
    {
      Key key,
      @required this.category
    }
  ) : super (key : key);
  @override
  _TittleItems createState() => _TittleItems(this.category);
}
class _TittleItems extends State<TitleItems>
{
  Future<List<Category>> category;
  _TittleItems(this.category);

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
          future: category,
          initialData: [],
          builder: (context, snapshot)
          {
            if(snapshot.hasData || snapshot.connectionState == ConnectionState.done)
            {
              if(snapshot.data.length > 6)
              {
                return GestureDetector
                (
                  onTap: () => 
                  {
                    Navigator.push
                    (
                      context, 
                      MaterialPageRoute
                      (
                        builder: (context) => MainDetail(),
                      )
                    )
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

