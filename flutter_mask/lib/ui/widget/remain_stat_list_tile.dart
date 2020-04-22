import 'package:flutter/material.dart';
import 'package:fluttermask/model/store.dart';
import 'package:url_launcher/url_launcher.dart';

class RemainStatListTile extends StatelessWidget {
  final Store store;

  RemainStatListTile(this.store);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(store.name),
      subtitle: Text(store.addr),
      trailing: _setSaleText(store),
      onTap: () {
        print('tap');
        _launchURL(store.lat, store.lng);

      },
    );
  }

  _launchURL(double lat, double lng) async {
    final url = 'https://google.com/maps/search/?api=1&query=$lat, $lng';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _setSaleText(Store stores) {
    var remainStat = '판매중지';
    var description = '';
    var color = Colors.black;

    if (stores.remainStat == 'plenty') {
      remainStat = '충분';
      description = '100개 이상';
      color = Colors.green;
    }

    switch (stores.remainStat) {
      case 'plenty':
        remainStat = '충분';
        description = '100개 이상';
        color = Colors.green;
        break;
      case 'some':
        remainStat = '보통';
        description = '30 ~ 100';
        color = Colors.yellow;
        break;
      case 'few':
        remainStat = '부족';
        description = '2 ~ 30 ';
        color = Colors.red;
        break;
      case 'empty':
        remainStat = '소진입';
        description = '1개 이하';
        color = Colors.grey;
        break;
      default:
    }
    return Column(
      children: <Widget>[
        Text(remainStat,
            style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        Text(description,
            style: TextStyle(color: color, fontWeight: FontWeight.bold))
      ],
    );
  }
}
