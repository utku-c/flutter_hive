import 'package:basit_veri_saklama/home/model/user_model.dart';
import 'package:basit_veri_saklama/manager/user_cache_manager.dart';
import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key, required this.model}) : super(key: key);

  final ICacheManager<UserModel> model;
  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<UserModel> _items = [];

  void findAndSet(String key) {
    _items = widget.model
            .getValues()
            ?.where((element) =>
                element.name?.toLowerCase().contains(key.toLowerCase()) ??
                false)
            .toList() ??
        [];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) {
            findAndSet(value);
          },
        ),
      ),
      body: Text(_items.map((e) => '${e.name} - ${e.company}').join(",")),
    );
  }
}
