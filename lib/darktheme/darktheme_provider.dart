import 'package:clemency/darktheme/darktheme_prefernce.dart';
import 'package:flutter/cupertino.dart';

 class darkthemeprovider with ChangeNotifier{
    Themeprefernce theme =Themeprefernce();

    bool _themevalue = false;
    // making our own setter and getter
    bool get darktheme=>_themevalue;
    set darktheme( bool value){
    _themevalue=value;
      theme.settheme(value);
      notifyListeners();

    }



 }



