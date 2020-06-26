import 'package:location/location.dart';

abstract class LocationObserver {
  void onLocationChanged(final LocationData locationData);
}
