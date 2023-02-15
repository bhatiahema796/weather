// // this  file give us the or help us to find the preediction of the cities in the searchbar
//  import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:http/http.dart';
// import 'package:clemency/utilites/api.dart';
//
// class Suggestion{
//   Suggestion(this.placeid, this.description);
//   // the placeid and the description is the required element of the autocomplete features
//    final String placeid;
//    final  String description;//Contains the human-readable name for the returned result.
//    // string representation of the prediction.
// @override
//   String toString()=> 'Suggestion(place_id$placeid ,description:$description)';
//
//
// }
//  class placeprovider {
//    final client = Client(); // this is the use to help to get the request  and search on the http server...which is the constructor
//    placeprovider(this.sessiontoken);
//    final sessiontoken;
//
//
//
//    Future<List<Suggestion>> fetchsuggestion(String input, String language) async {
//      if (input.length > 2) {
//        final request = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&type=(cities)&language=$language&key=$andoriodapikey&sessiontoken=$sessiontoken';
//        final response = await client.get(Uri.parse(request));
//        if (response.statusCode == 200) // http response
//            {
//          final result = json.decode(response.body);
//          // for this see the documentation given in the link above i request variable.
//
//          if (result['status'] == 'OK') // automatically response
//              {
//            result['predictions'] // predictioin is the set of array of the predicted elements.
//                .map<Suggestion>((pre) => Suggestion(pre['place_id'], pre['description']))
//                .toList();
//          }
//          if (result['status'] == 'ZERO_RESULTS') {
//            return [];
//          }
//          throw Exception(result['error massage']);
//        }
//      }
//      throw Exception('Failed to fetch suggestion');
//    }
//  }
//
