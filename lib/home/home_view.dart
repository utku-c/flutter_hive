// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:basit_veri_saklama/home/home_view_service.dart';
import 'package:basit_veri_saklama/home/model/user_model.dart';
import 'package:basit_veri_saklama/manager/user_cache_manager.dart';
import 'package:basit_veri_saklama/search_view/search_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kartal/kartal.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final IHomeService _homeService;
  final String _baseUrl = "https://jsonplaceholder.typicode.com";
  final String imageurl =
      "https://imgs.search.brave.com/k2WwilOQ1Lzv5lFn5N-jkTYxML_TSH-6sD-9TI9MgoA/rs:fit:1200:1080:1/g:ce/aHR0cHM6Ly9pbWcu/Zm90b2NvbW11bml0/eS5jb20vc3Vucmlz/ZS1iN2Y3ZGFhMC0y/MzFlLTQ0ODctYjU4/NS1hMDZhZTJhNzVm/ZDEuanBnP2hlaWdo/dD0xMDgw";
  List<UserModel>? _items;
  late final ICacheManager<UserModel> cacheManager;
  @override
  void initState() {
    super.initState();

    _homeService = HomeService(
      Dio(BaseOptions(baseUrl: _baseUrl)),
    );
    cacheManager = UserCacheManager("userCacheNew2");
    fetchDatas();
  }

  Future<void> fetchDatas() async {
    await cacheManager.init();
    // await cacheManager.clearAll();
    if (cacheManager.getValues()?.isNotEmpty ?? false) {
      _items = cacheManager.getValues();
    } else {
      _items = await _homeService.fetchUsers();
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                context.navigateToPage(SearchView(
                  model: cacheManager,
                ));
              },
              icon: Icon(Icons.search))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_items?.isNotEmpty ?? false) {
            await cacheManager.addItems(_items!);

            final _cacheItems = cacheManager.getValues();
            print(_cacheItems);
          }
        },
      ),
      body: (_items?.isNotEmpty ?? false)
          ? ListView.builder(
              itemCount: _items?.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(imageurl),
                    ),
                    title: Text("${_items?[index].name}"),
                  ),
                );
              },
            )
          : CircularProgressIndicator(),
    );
  }
}
