import 'package:foodshop/models/products.dart';
import 'package:flutter/cupertino.dart';

class UpdateHistory extends InheritedWidget
{
  final List<Products> listProducts ;
  
  UpdateHistory
  (
    {
      Key key,
      @required this.listProducts,
      @required Widget child
    }
  ) : assert(child !=null),
      assert(listProducts!=null),
      super(key : key , child : child);

  static UpdateHistory of(BuildContext context)
  {
    return context.dependOnInheritedWidgetOfExactType<UpdateHistory>();
  }

  @override
  bool updateShouldNotify(UpdateHistory oldWidget)
  {
    return listProducts != oldWidget.listProducts ;
    //return true;
  }

}