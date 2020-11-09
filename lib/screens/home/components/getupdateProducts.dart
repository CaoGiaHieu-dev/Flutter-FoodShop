import 'package:foodshop/models/products.dart';
import 'package:flutter/cupertino.dart';

class UpdateListItems extends InheritedWidget
{
  final List<Products> listProducts ;
  
  UpdateListItems
  (
    {
      Key key,
      @required this.listProducts,
      @required Widget child
    }
  ) : assert(child !=null),
      assert(listProducts!=null),
      super(key : key , child : child);

  static UpdateListItems of(BuildContext context)
  {
    return context.dependOnInheritedWidgetOfExactType<UpdateListItems>();
  }

  @override
  bool updateShouldNotify(UpdateListItems oldWidget)
  {
    return listProducts != oldWidget.listProducts ;
    //return true;
  }

}