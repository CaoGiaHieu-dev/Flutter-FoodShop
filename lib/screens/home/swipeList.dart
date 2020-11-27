
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
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
  final String detailbaner;
  SwipeList
  (
    {

      Key key,
      @required this.size , 
      this.category,
      this.product,
      this.presstoLoad,
      this.detailbaner
    }
  );

  _SwipeList createState() => _SwipeList(size , category , product ,presstoLoad ,detailbaner ) ;
}


class _SwipeList extends State<SwipeList>
{
  Size size;
  Future<List<Category>> category ;
  Future<List<Products>> product ;
  Function(String ) presstoLoad;
  String detailbaner;
  
  _SwipeList(this.size,this.category,this.product,this.presstoLoad,this.detailbaner);

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
                return Swiper
                (

                  pagination: new SwiperPagination(),
                  //control: new SwiperControl(),
                  itemCount: foodSnap.data.length,
                  itemBuilder: (context, i) 
                  {
                    return GestureDetector
                    (
                      onTap: () 
                      {
                        setState(()
                        {
                          this.widget.presstoLoad(foodSnap.data[i].id);
                        });
                      },
                      child: CachedNetworkImage
                      (
                        // /fit: BoxFit.fill,
                        imageUrl: foodSnap.data[i].image,
                        alignment: Alignment.center,
                        placeholder: (context, url) => new CircularProgressIndicator(),
                        errorWidget: (context, url, error) => new Icon(Icons.error),
                        imageBuilder: (context, imageProvider) 
                        {
                          return Container
                          (
                            margin: EdgeInsets.only
                            (
                              left : 10,
                              right: 10,
                              top: 10
                            ),
                            decoration: BoxDecoration
                            (
                              borderRadius: BorderRadius.circular(15),
                              //shape: BoxShape.circle,
                              image: DecorationImage
                              (
                                image: imageProvider,
                                fit: BoxFit.cover
                              )
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              //   return ListView
              //   (
              //     padding: EdgeInsets.only
              //     (
              //       left: 10,
              //       right: 10,
              //     ),
              //     shrinkWrap: true,
              //     scrollDirection: Axis.horizontal,
              //     children: <Widget>
              //     [
              //       for(int i =0 ; i < foodSnap.data.length ; i++)
              //         new GestureDetector
              //         ( 
              //           onTap: () 
              //           {
              //             setState(()
              //             {
              //               this.widget.presstoLoad(foodSnap.data[i].id);
              //             });
              //           },
              //           child : Card
              //           (
              //             shape: BeveledRectangleBorder
              //             (
              //               borderRadius: BorderRadius.circular(15.0),
              //             ),
              //             color: kMainColor,
              //             child: Container
              //             (
              //               width: MediaQuery.of(context).size.width - 50,
              //               decoration: BoxDecoration
              //               (
              //                 borderRadius: BorderRadius.all(Radius.circular(36))
              //               ),
              //               child: CachedNetworkImage
              //               (
              //                 imageUrl: foodSnap.data[i].image,
              //                 width: size.width -50,
              //                 alignment: Alignment.center,
              //                 placeholder: (context, url) => new CircularProgressIndicator(),
              //                 errorWidget: (context, url, error) => new Icon(Icons.error),
              //               ),
              //             ),
              //           )
              //         )
              //     ],
              //   );
              // 
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

                  