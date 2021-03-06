import 'package:flutterapp/service/location/location_observer.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:location/location.dart';
import '../../model/location/location_point.dart';

class LocationService {
  var location = Location();
  var observers = new List<LocationObserver>() ;
  // ignore: non_constant_identifier_names
  static final LocationService INSTANCE = new LocationService._();
  var minLocationAccuracyRequired = GlobalConfiguration().getDouble("min_location_accuracy_required");

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
      if (locationData.accuracy <= minLocationAccuracyRequired) {
        var locationPoint = new LocationPoint(
            time: DateTime.now(),
            latitude: locationData.latitude,
            longitude: locationData.longitude,
            altitude: locationData.altitude,
            accuracy: locationData.accuracy
        );
        observers.forEach((observer) {
          observer.onLocationChanged(locationPoint);
        });
      } else {
        print('Location changed rejected, accuracy worse than min accuracy required. '
            'Actual: ${locationData.accuracy}, min required: $minLocationAccuracyRequired');
      }
    });
  }

  void registerObserver(final LocationObserver locationObserver) {
    observers.add(locationObserver);
  }

  void unRegisterObserver(final LocationObserver locationObserver) {
    observers.remove(locationObserver);
  }
}
