import 'package:flutter/material.dart';

const kAlertBoxDecoration = BoxDecoration(color: Colors.blueAccent, boxShadow: [
  BoxShadow(
    color: Colors.blue,
    offset: Offset(2.0, 1.0),
  )
]);

const kAlertBoxTextStyle = TextStyle(color: Colors.white, fontSize: 17.0);
 const KinputAirtextstyle= InputDecoration(
   hintText: 'Search city name',
   contentPadding: EdgeInsets.all(10.0),
   hintStyle: TextStyle(
     color: Colors.grey,
   ),
   filled: true,
   fillColor: Colors.white,
   prefixIcon: Icon(
     Icons.search,
     color: Color(0xFFc41a43),
   ),
   enabledBorder: OutlineInputBorder(
     borderRadius: BorderRadius.all(
       Radius.circular(30.0),
     ),
     borderSide: BorderSide(
       color: Color(0xFFc41a43),
     ),
   ),
   focusedBorder: OutlineInputBorder(
     borderRadius: BorderRadius.all(
       Radius.circular(30.0),
     ),
     borderSide: BorderSide(
       color: Color(0xFFc41a43),
     ),
   ),
   border: OutlineInputBorder(
     borderSide: BorderSide(
       color: Color(0xFFc41a43),
     ),
     borderRadius: BorderRadius.all(
       Radius.circular(30.0),
     ),
   ),
 );
