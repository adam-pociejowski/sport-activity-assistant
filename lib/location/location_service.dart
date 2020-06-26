import 'package:flutterapp/location/location_observer.dart';
import 'package:location/location.dart';

class LocationService {
  var location = Location();
  var observers = new List<LocationObserver>() ;
  static final LocationService _instance = new LocationService._();

  LocationService._() {
    location
        .requestPermission()
        .then((granted) {
      if (granted == PermissionStatus.granted) {
        print('Location permission granted');
        listenLocationChanges();
      } else {
        print('Location permission not granted');
      }
    });
  }

  void listenLocationChanges() {
    location
        .onLocationChanged
        .listen((locationData) {
      if (locationData != null) {
        observers.forEach((observer) {
          observer.onLocationChanged(locationData);
        });
      }
    });
  }

  factory LocationService() {
    return _instance;
  }

  void registerObserver(final LocationObserver locationObserver) {
    observers.add(locationObserver);
  }

  void unRegisterObserver(final LocationObserver locationObserver) {
    observers.remove(locationObserver);
  }
}
