
import 'package:foodshop/components/constants.dart';
import 'package:foodshop/models/category.dart';
import 'package:foodshop/models/products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SwipeList extends StatefulWidget
{
  final Size size;
  final Future<List<Category>> category;
  final Future<List<Products>> product ;
  final Function(String ) presstoLoad;
  SwipeList
  (
    {

      Key key,
      @required this.size , 
      this.category,
      this.product,
      this.presstoLoad
    }
  );

  _SwipeList createState() => _SwipeList(size , category , product ,presstoLoad ) ;
}


class _SwipeList extends State<SwipeList>
{
  Size size;
  Future<List<Category>> category ;
  Future<List<Products>> product ;
  Function(String ) presstoLoad;
  
  _SwipeList(this.size,this.category,this.product,this.presstoLoad);

  @override
  Widget build(BuildContext context )  
  {
    // #region List Swipe 
    return Container
    (
      height: size.height * 0.25,
      child: Stack
      (
        children: <Widget>
        [
          FutureBuilder 
          (
            future: category,
            initialData: [],
            builder: (context , foodSnap)
            {
              if(foodSnap.connectionState == ConnectionState.done && foodSnap.hasData)
              {
                return ListView
                (
                  padding: EdgeInsets.only
                  (
                    left: 10,
                    right: 10,
                  ),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: <Widget>
                  [
                    for(int i =0 ; i < foodSnap.data.length ; i++)
                      new GestureDetector
                      ( 
                        onTap: () 
                        {
                          setState(()
                          {
                            this.widget.presstoLoad(foodSnap.data[i].id);
                            //  product = getProducts(foodSnap.data[i].id, "");
                            // Navigator.pushReplacement(context, MaterialPageRoute
                            // (
                            //   builder: (context) =>
                            //   HomeScreen
                            //   ( 
                            //     categoryId: foodSnap.data[i].id,
                            //   )
                            // ));
                            // Route route = MaterialPageRoute(builder: (context) => ListItems(products: product,size: size,));
                            // Navigator.pushReplacement(context, route);
                          });
                        },
                        child : Card
                        (
                          shape: BeveledRectangleBorder
                          (
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: kMainColor,
                          child: Container
                          (
                            width: MediaQuery.of(context).size.width - 50,
                            decoration: BoxDecoration
                            (
                              image: DecorationImage
                              (
                                image: NetworkImage(foodSnap.data[i].image.toString() ,scale: 1.0),onError: (exception, stackTrace) 
                                {
                                  return Center(child:  CircularProgressIndicator(),);  
                                },
                                fit: BoxFit.fill
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(36))
                            ),
                          ),
                        )
                      )
                  ],
                );
              }
              return Center
              (
                child :  CircularProgressIndicator() 
              );
            },
          )
        ],
      )
    );
    // #endregion
  }
}

                  