import 'package:flutter/material.dart';
import 'package:fluttermask/repository/store_repository.dart';
import 'package:fluttermask/ui/widget/remain_stat_list_tile.dart';
import 'package:fluttermask/viewmodel/store_model.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  final storeRepository = StoreRepository();

  @override
  Widget build(BuildContext context) {
    final storeModel = Provider.of<StoreModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('마스크 제고 있는 곳 : ${storeModel.stores.length} 곳'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              storeModel.fetch();
              print("fefef2222ef");
            },
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      body: Center(
        child: storeModel.isLoading
            ? loadingWidget()
            : ListView(
                children: storeModel.stores.map((e) {
                  return RemainStatListTile(e);
                }).toList(),
              ),
      ),
    );
  }

  Widget loadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("정보를 가져오는중"),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
