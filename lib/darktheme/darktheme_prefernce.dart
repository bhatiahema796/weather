  import 'package:shared_preferences/shared_preferences.dart';

  class Themeprefernce{
     // ignore: constant_identifier_names
    // we are creating the key for the shared_prefernces
     static const  Themestatus='themestatus';
     // this method is used to set the value of the theme in the shared preferences
   settheme( bool value ) async{
     // . It has a method, getInstance, which is used to create an instance of a SharedPreferences.
     //The getInstance creates and returns a SharedPreferences instance.

     SharedPreferences pref = await  SharedPreferences.getInstance();
     pref.setBool(Themestatus, value);
   }
   // this is used to get the value from the shared_preferences if the value is not in the shared_prefence then it will return the null

     Future<bool> gettheme()async{
      SharedPreferences prefernces = await  SharedPreferences.getInstance();
      // get the value form the shareprefernces. and if the value of the key is not present in the sharedprefernce then return the false
       return prefernces.getBool(Themestatus) ?? false;



    }


  }