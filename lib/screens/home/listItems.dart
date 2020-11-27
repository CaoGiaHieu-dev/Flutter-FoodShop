
import 'package:foodshop/models/products.dart';
import 'package:foodshop/models/user.dart';
import 'package:foodshop/screens/home/carditem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ListItems extends StatefulWidget 
{
  final Size size;
  final Function press;
  final Future<List<Products>> products;
  final int number;
  final bool isLogin;
  final List<User> listUser;
  ListItems
  (
    {
      Key key,
      this.size,
      this.press,
      @required this.products,
      this.number,
      @required this.isLogin,
      @required this.listUser
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
    //var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 200) / 2;
    final double itemWidth = size.width / 2;
    return Container
    (
      height: size.height +50,  
      child:  FutureBuilder
      (
        future: this.widget.products,
        builder: (context , AsyncSnapshot<List<Products>> foodSnap)
        {
          if(foodSnap.hasData && foodSnap.connectionState == ConnectionState.done)
          {
            List<Products> _tempListProduct = foodSnap.data.where
            (
              (element) =>
              
                element.hot ==true
              
            ).toList();
            // if( foodSnap.data.length > 6)
            // {
            //   length = 6;
            // }
            // else
            // {
            //   length = foodSnap.data.length;
            // }
            if( _tempListProduct.length > 6)
            {
              length = 6;
            }
            else
            {
              length = _tempListProduct.length;
            }
            return GridView
            (

              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount
              (
                crossAxisCount: 2,
                childAspectRatio: (itemWidth / itemHeight),
              ) ,
              
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: false,
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
                                  userId: this.widget.listUser.isNotEmpty ? this.widget.listUser.first.id  : "",
                                  isLogin: this.widget.isLogin,
                                  key: UniqueKey(),
                                  product: _tempListProduct[i],
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
                        userId: this.widget.listUser.isNotEmpty ? this.widget.listUser.first.id :"",
                        isLogin: this.widget.isLogin,
                        key: UniqueKey(),
                        product: _tempListProduct[i],
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

