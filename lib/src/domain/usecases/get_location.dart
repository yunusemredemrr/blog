import 'package:geolocator/geolocator.dart';

class GetLocation {
  static final GetLocation instance = GetLocation._init();
  GetLocation._init();

  Future<Position> getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      return position;
    } catch (e) {
      rethrow;
    }
  }
}
