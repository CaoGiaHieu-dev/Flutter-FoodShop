
import 'package:foodshop/models/products.dart';
import 'package:foodshop/screens/home/carditem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ListItems extends StatefulWidget 
{
  final Size size;
  final Function press;
  final Future<List<Products>> products;
  final int number;
  ListItems
  (
    {
      Key key,
      this.size,
      this.press,
      @required this.products,
      this.number,
    }
  ) : super ( key : key );
  
  // This widget is the root of your application.
  @override
  _ListItems createState() => _ListItems(size,press,products,number);
  // #endregion 
}


class _ListItems extends State<ListItems>
{
  int length; 
  int number;
  Size size;  
  Function press;
  Future<List<Products>> products;

  _ListItems(this.size,this.press,this.products,this.number);

  @override
  Widget build(BuildContext context)
  {
    return Container
    (
      height: size.height * 0.8,  
      child:  FutureBuilder
      (
        initialData: [],
        future: products,
        builder: (context , foodSnap)
        {
          if(foodSnap.hasData && foodSnap.connectionState == ConnectionState.done)
          {
            if( foodSnap.data.length > 6)
            {
              length = 6;
            }
            else
            {
              length = foodSnap.data.length;
            }
            return GridView
            (
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount
              (
                crossAxisCount: 2,
              ) ,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: <Widget>
              [
                for( int i =0 ; i < length ; i ++)
                  if(foodSnap.hasData && foodSnap.connectionState == ConnectionState.done)
                    GestureDetector
                    (
                      onTap: () => 
                      {
                        showDialog
                        (
                          context: context,
                          builder: (BuildContext context)
                          {
                            return AlertDialog
                            (
                              content: Container
                              (
                                height: size.height *0.5,
                                child: CardItems
                                (
                                  key: UniqueKey(),
                                  foodSnap: foodSnap,
                                  index: i,
                                  press: press,
                                ),
                              ),
                            );
                          }
                        ).then((value)  
                        {
                          setState(() 
                          {
                            
                          });
                        })
                      },
                      child: CardItems
                      (
                        key: UniqueKey(),
                        foodSnap: foodSnap,
                        index: i,
                        press: press,
                      ),
                    )
                  else
                    Center
                    (
                      child: CircularProgressIndicator(),
                    )
              ],
            );
          }
          return Center
          (
            child: CircularProgressIndicator(),
          );
        },
      )
    );
  }
}

