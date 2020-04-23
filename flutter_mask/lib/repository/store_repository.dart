import 'dart:convert';
import 'package:latlong/latlong.dart';
import 'package:fluttermask/model/store.dart';
import 'package:http/http.dart' as http;

class StoreRepository {
//
  var isLoading = true;
  final Distance _distance = new Distance();

  Future<List<Store>> fetch(double lat, double lng) async {
    final _stores = List<Store>();

    var url =
        'https://8oi9s0nnth.apigw.ntruss.com/corona19-masks/v1/storesByGeo/json?lat=$lat&lng=$lng&m=5000';
    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResult = jsonDecode(utf8.decode(response.bodyBytes));

        final jsonStores = jsonResult['stores'];

        jsonStores.forEach((json) {
          final store = Store.fromJson(json);
          final km =
          _distance(new LatLng(store.lat, store.lng), new LatLng(lat, lng));
          store.km = km;
          _stores.add(store);
        });

        print("fesfesf");
        return _stores.where((element) {
          return element.remainStat == 'plenty' ||
              element.remainStat == 'some' ||
              element.remainStat == 'few';
        }).toList()
          ..sort((a, b) => a.km.compareTo(b.km));
      } else {
        return [];
      }
    }catch (e) {
      return [];
    }
  }
}
