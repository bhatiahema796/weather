import 'dart:convert';
import 'package:http/http.dart ' as http;
 class Networkhelp
 {
   Networkhelp(this.url);
   String url;

   Future getdata() async{
     http.Response response=  await http.get(Uri.parse(url));
     // we are checcking the responnse status of the url
    if (response.statusCode==200)
    {
         String data= response.body;
         var decodedata=jsonDecode(data);
         return decodedata;
    }
    else{
      print(response.statusCode);
    }

   }
   
 }