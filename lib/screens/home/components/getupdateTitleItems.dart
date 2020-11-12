
import 'package:flutter/cupertino.dart';

class UpdateTitleItems extends InheritedWidget
{
  final String banner ;
  
  UpdateTitleItems
  (
    {
      Key key,
      @required this.banner,
      @required Widget child
    }
  ) : assert(child !=null),
      assert(banner!=null),
      super(key : key , child : child);

  static UpdateTitleItems of(BuildContext context)
  {
    return context.dependOnInheritedWidgetOfExactType<UpdateTitleItems>();
  }

  @override
  bool updateShouldNotify(UpdateTitleItems oldWidget)
  {
    return banner != oldWidget.banner ;
    //return true;
  }

}