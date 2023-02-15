import 'package:geolocator/geolocator.dart';

class Location {
   double? _latitiude;
   double? _longitude;

   Future<void> getcurrentlocation() async {
      Position position;
      LocationPermission permission;

      // this will help to cheq that do we have the permission to use the location or not.
      try {
         permission = await Geolocator.checkPermission();
         if (permission == LocationPermission.denied ||
             permission == LocationPermission.deniedForever) {
            print('Permissions are not given');

            //requestPermission help to get the request of permssion form the users.
            LocationPermission ask = await Geolocator.requestPermission();
         } else {
            position = await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.best);
            _latitiude = position.latitude;
            _longitude = position.longitude;
         }
      } catch (exception) {
         print(exception);
      }
   }
    double? getlatitude(){
      return _latitiude;
   }
    double? getlongitude(){
      return _longitude;
    }
}
