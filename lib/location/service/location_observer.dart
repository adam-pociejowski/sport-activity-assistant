import '../model/location_point.dart';

abstract class LocationObserver {
  void onLocationChanged(final LocationPoint locationPoint);
}
