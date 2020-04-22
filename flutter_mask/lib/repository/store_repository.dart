import 'dart:convert';

import 'package:fluttermask/model/store.dart';
import 'package:http/http.dart' as http;

class StoreRepository {
//
  var isLoading = true;

  Future<List<Store>> fetch(double lat, double lng) async {
    final _stores = List<Store>();

    var url =
        'https://8oi9s0nnth.apigw.ntruss.com/corona19-masks/v1/storesByGeo/json?lat=$lat&lng=$lng&m=5000';

    var response = await http.get(url);
    final jsonResult = jsonDecode(utf8.decode(response.bodyBytes));

    final jsonStores = jsonResult['stores'];

    jsonStores.forEach((json) {
      _stores.add(Store.fromJson(json));
    });

    print("fesfesf");
    return _stores.where((element) {
      return element.remainStat == 'plenty' ||
          element.remainStat == 'some' ||
          element.remainStat == 'few';
    }).toList();
  }
}
