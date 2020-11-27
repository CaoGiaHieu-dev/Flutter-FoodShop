import 'package:cached_network_image/cached_network_image.dart';
import 'package:foodshop/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodshop/models/products.dart';
import 'package:foodshop/user/components/userpreferences.dart';

import '../../components/cart.dart';

class CardItems extends StatefulWidget
{
  final bool isLogin;
  final Function press;
  final Products product;
  final String userId;

  CardItems
  (
    {
      Key key,
      @required this.product,
      this.press,
      @required this.isLogin,
      @required this.userId ,
    }
  ) : super (key : key );

  @override
  _CardItems createState() => _CardItems(this.press  , this.product );
}

class _CardItems extends State<CardItems>
{
  Function press;
  Products product;
  _CardItems(this.press,this.product);

  List<String> _favoriteList;
  // #region State

  @override
  void initState()
  {
    super.initState();
    if(this.widget.isLogin)
    {
      _favoriteList = UserPrefrences().getListFavorite(this.widget.userId); 
    }
  }
  // #endregion

  // #region Favorite
  bool _checkFavoriteList(String productId)
  {
    bool _check = false;
    if(_favoriteList == null || _favoriteList.length ==0)
    {
      _check= false;
    }
    else
    {
      _favoriteList.forEach
      (
        (element) 
        { 
          if(element == productId)
          {
            _check = true;
            
          }
        }
      );
    }
    return _check;
  }
  // #endregion
  @override
  Widget build(BuildContext context )
  {
    return Card
    (
      semanticContainer: true,
      shape: BeveledRectangleBorder
      (

        borderRadius: BorderRadius.circular(15.0),
      ),
      color: kMainColor,
      child: Container
      (
        decoration: BoxDecoration
        (
          borderRadius: BorderRadius.all(Radius.circular(100))
        ),
        child: Column
        (
          children: <Widget>
          [
            CachedNetworkImage
            (
              imageUrl: product.image.toString(),
              width: MediaQuery.of(context).size.width -20,
              height: MediaQuery.of(context).size.height * 0.25 - 100,
              alignment: Alignment.center,
              placeholder: (context, url) => new CircularProgressIndicator(),
              errorWidget: (context, url, error) => new Icon(Icons.error),
            ),
            // Image.network
            // (
            //   foodSnap.data[index].image.toString() ,
            //   height: MediaQuery.of(context).size.height * 0.25 - 100,
            //   width: MediaQuery.of(context).size.width -20,
            // ),
            Spacer(),
            Align
            (
              alignment: Alignment.center,
              child :Text
              (
                product.name,
                style: TextStyle
                (
                  color: Colors.white,
                  fontSize: 15,
                ),
              )
            ),
            Spacer(),
            this.widget.isLogin
            ? Align
            (
              alignment: Alignment.center,
              child: GestureDetector
              (
                onTap: ()
                {
                  if(_favoriteList== null || _favoriteList.isEmpty)
                  {
                    _favoriteList =[];
                  }
                  setState(() 
                  {
                    if(_checkFavoriteList(product.id) == false)
                    {
                      _favoriteList.add(product.id);
                      UserPrefrences().setListFavorite(this.widget.userId, _favoriteList);
                    }
                    else
                    {
                      _favoriteList.remove(product.id);
                      UserPrefrences().setListFavorite(this.widget.userId, _favoriteList);
                    }
                  });
                },
                child: _checkFavoriteList(product.id) == true
                ? Icon
                (
                  Icons.favorite,
                  color: Colors.red
                )
                : Icon
                (
                  Icons.favorite,
                  color: Colors.black
                ) 
              ),
            )
            : SizedBox() ,
            Spacer(),
            Align
            (
              alignment: Alignment.center,
              child: (!product.discount)
              ? Text
              (
                product.price,
                style: TextStyle
                (
                  color: Colors.white,
                  fontSize: 20,
                ),
              )
              : Row
              (
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>
                [
                  Text
                  (
                    product.price,
                    style: TextStyle
                    (
                      color: Colors.white,
                      fontSize: 15,
                      decoration: TextDecoration.lineThrough
                    )
                  ),
                  SizedBox(width: 10,),
                  Text
                  (
                    ( double.parse(product.price) - double.parse(product.price) * (10/100) ).toString(),
                    style: TextStyle
                    (
                      color: Colors.white,
                      fontSize: 20,
                    )
                  )
                ]
              )
            ),
            Spacer(),
            Center
            (
              child : Row
              (
                children: <Widget>
                [
                  Spacer(),
                  SizedBox
                  (
                    width: MediaQuery.of(context).size.width * 0.175 -30,
                    child: RaisedButton
                    (
                      color: kButtonColor,
                      shape: RoundedRectangleBorder
                      (
                        borderRadius: BorderRadius.circular(100)
                      ),
                      child: Align
                      (
                        alignment: Alignment.center,
                        child: Text
                        (
                          "+",
                          style: TextStyle
                          (
                            fontSize: 16,
                          ),
                        ),
                      ),
                      onPressed: () 
                      {
                        setState(() =>
                        {
                          addtoCart(product),
                          press()
                        });
                      },
                    ),
                  ),
                  Spacer(),
                  Text
                  (
                    getItemInCart(int.parse(product.id)).toString(),
                    style: TextStyle
                    (
                      color: Colors.white,
                      fontSize: 15
                    ),
                  ),
                  Spacer(),
                  SizedBox
                  (
                    width: MediaQuery.of(context).size.width * 0.175 -30,
                    child: RaisedButton
                    (
                      color: kButtonColor,
                      shape: RoundedRectangleBorder
                      (
                        
                        borderRadius: BorderRadius.circular(36)
                      ),
                      child: Align
                      (
                        alignment: Alignment.center,
                        child: Text
                        (
                          "-",
                          style: TextStyle
                          (
                            fontSize: 16,
                          ),
                        ),
                      ),
                      onPressed: () 
                      {
                        setState(() =>
                        {
                          removefromcart(int.parse(product.id)),
                          press()
                        });
                      }
                    ),
                  ),
                  Spacer(),
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}


