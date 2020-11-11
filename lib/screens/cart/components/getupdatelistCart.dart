import 'package:foodshop/models/products.dart';
import 'package:flutter/cupertino.dart';

class UpdateListCart extends InheritedWidget
{
  final List<Products> listProducts ;
  
  UpdateListCart
  (
    {
      Key key,
      @required this.listProducts,
      @required Widget child
    }
  ) : assert(child !=null),
      assert(listProducts!=null),
      super(key : key , child : child);

  static UpdateListCart of(BuildContext context)
  {
    return context.dependOnInheritedWidgetOfExactType<UpdateListCart>();
  }

  @override
  bool updateShouldNotify(UpdateListCart oldWidget)
  {
    return listProducts != oldWidget.listProducts ;
    //return true;
  }

}