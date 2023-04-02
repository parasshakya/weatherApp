import 'package:geolocator/geolocator.dart';

class LocationService{

static Future<Position> getCurrentPosition() async{

  LocationPermission permission = await Geolocator.checkPermission();
  if(permission == LocationPermission.denied || permission == LocationPermission.deniedForever){
      await Geolocator.requestPermission();
  }
    Position currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );
  return currentPosition;
}



}