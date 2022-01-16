import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/page/search_page.dart';
import 'package:restaurant_app/provider/list_provider.dart';
import 'package:restaurant_app/service/api_service.dart';

import 'package:restaurant_app/widget/restaurant_list.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Restaurant App',
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.routeName);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ChangeNotifierProvider(
            create: (_) =>
                GetRestaurantProvider(getApiService: ApiService()),
            child: const RestaurantList(),
          ),
        ),
      ),
    );
  }
}