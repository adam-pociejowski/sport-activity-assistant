import 'dart:math' as math;
import '../model/location/location_point.dart';

class LocationUtils {

  static double getDistanceBetweenLocationsInMeters(LocationPoint firstPoint, LocationPoint secondPoint) {
    final double earthRadius = 6367.0;
    final double lat1 = firstPoint.latitude;
    final double lng1 = firstPoint.longitude;
    final double lat2 = secondPoint.latitude;
    final double lng2 = secondPoint.longitude;
    final double factor = math.pi / 180.0;
    final double dlng = (lng2 - lng1) * factor;
    final double dlat = (lat2 - lat1) * factor;
    final double a = math.pow(math.sin(dlat / 2.0), 2.0) + math.cos(lat1 * factor) * math.cos(lat2 * factor) * math.pow(math.sin(dlng / 2.0), 2.0);
    final double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1.0 - a));
    return earthRadius * c * 1000.0;
  }
}