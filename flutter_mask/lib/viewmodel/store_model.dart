import 'package:flutter/foundation.dart';
import 'package:fluttermask/model/store.dart';
import 'package:fluttermask/repository/location_repository.dart';
import 'package:fluttermask/repository/store_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class StoreModel with ChangeNotifier {
  final _storeRepository = StoreRepository();
  final _locationRepository = LocationRepository();

  var isLoading = false;
  List<Store> stores = [];

  StoreModel() {
    fetch();
  }

  Future fetch() async {
    isLoading = true;
    notifyListeners();
    Position position = await _locationRepository.getCurrentLocation();
    stores =
        await _storeRepository.fetch(position.latitude, position.longitude);

    isLoading = false;
    notifyListeners();
  }
}
