
import 'package:flutter/cupertino.dart';

class CheckLogin extends InheritedWidget
{
  final bool isLogin ;
  
  CheckLogin
  (
    {
      Key key,
      @required this.isLogin,
      @required Widget child
    }
  ) : assert(child !=null),
      assert(isLogin!=null),
      super(key : key , child : child);

  static CheckLogin of(BuildContext context)
  {
    return context.dependOnInheritedWidgetOfExactType<CheckLogin>();
  }

  @override
  bool updateShouldNotify(CheckLogin oldWidget)
  {
    return isLogin != oldWidget.isLogin ;
    //return true;
  }

}