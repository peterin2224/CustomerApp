
import 'package:geolocator/geolocator.dart';

//
// v2.0 - 29/09/2020
//

// class MyLocation {
//   Position _currentPosition;
//
//   Future<Position> getCurrent() async {
//     _currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation)
//         .timeout(Duration(seconds: 10), onTimeout: () async {
//           dprint("MyLocation::getLastKnownPosition");
//       return await Geolocator.getLastKnownPosition().timeout(Duration(seconds: 10));
//     });
//     dprint("MyLocation::_currentPosition $_currentPosition");
//     return _currentPosition;
//   }
//
//   distance(double lat, double lng) async {
//     //Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.location]);
//     var permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied)
//         return null;
//     }
//
//     var _distanceInMeters = -1.0;
//
//     //if (permissions[PermissionGroup.location] == PermissionStatus.granted) {
//       // if (_currentPosition == null)
//         await getCurrent();
//
//     dprint(_currentPosition.toString());
//     if (_currentPosition != null) {
//       _distanceInMeters = Geolocator.distanceBetween(
//           _currentPosition.latitude, _currentPosition.longitude,
//           lat, lng);
//     }
//     //}
//     return _distanceInMeters;
//   }
//
//   distanceBetween(double lat, double lng, double lat2, double lng2) async {
//     var _distanceInMeters = -1.0;
//     _distanceInMeters = Geolocator.distanceBetween(
//         lat2, lng2,
//         lat, lng);
//     return _distanceInMeters;
//   }
// }

class GeoLocation {

  Future<Position?> getCurrent() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied)
        return null;
    }
    var _currentPosition;
    try {
      _currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation)
          .timeout(Duration(seconds: 10));
    } catch (e) {
      print(e.toString());
      return null;
    }

    // print("MyLocation::_currentPosition $_currentPosition");
    // _latitude = _currentPosition.latitude;
    // _longitude = _currentPosition.longitude;
    // _distance = Geolocator.distanceBetween(52.522809963779856, 13.411659637385851, _latitude, _longitude); // berlin location
    // setState(() {});
    // return _currentPosition;
    return _currentPosition;
  }

  // Geolocator _geolocator = Geolocator();
  // Position _currentPosition = Position();
  // bool _init = false;

  // Future<Position> getCurrent() async {
  //   _currentPosition = await _geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.medium)
  //       .timeout(Duration(seconds: 10), onTimeout: () async {
  //     return await _geolocator.getLastKnownPosition().timeout(Duration(seconds: 10));
  //   });
  //   _init = true;
  //   return _currentPosition;
  // }

  distance(double lat, double lng) async {
    // Map<PermissionGroup, PermissionStatus> permissions =
    // await PermissionHandler().requestPermissions([PermissionGroup.location]);

    var _distanceInMeters = -1.0;

    // if (permissions[PermissionGroup.location] == PermissionStatus.granted) {
    //   if (!_init)
    Position? _currentPosition = await getCurrent();
    if (_currentPosition != null)
      _distanceInMeters = await distanceBetween(
          _currentPosition.latitude, _currentPosition.longitude,
          lat, lng);

    return _distanceInMeters;
  }

  distanceBetween(double lat, double lng, double lat2, double lng2) async {
    // var _currentPosition = await getCurrent();
    // if (_currentPosition == null)
    //   return 0;
    // var _latitude = ;
    // var _longitude = _currentPosition.longitude;
    return  Geolocator.distanceBetween(lat2, lng2,
        lat, lng);

    // var _distanceInMeters = -1.0;
    // _distanceInMeters = await _geolocator.distanceBetween(
    //     lat2, lng2,
    //     lat, lng);
    // return _distanceInMeters;
  }
}