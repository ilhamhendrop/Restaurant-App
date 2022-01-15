import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/service/api_service.dart';
import 'package:restaurant_app/widget/restaurant_search.dart';
import 'package:restaurant_app/widget/search_widget.dart';

class SearchPage extends StatelessWidget {
  static const routeName = '/search';

  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: ChangeNotifierProvider(
                create: (_) => SearchRestaurantProvider(
                    searchApiService: SearchApiService()),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    SearchWidget(),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: RestaurantSearch(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

