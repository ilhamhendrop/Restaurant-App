
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/page/home_page.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/service/api_service.dart';
import 'package:restaurant_app/widget/restaurant_search.dart';
import 'package:restaurant_app/widget/search_widget.dart';


class SearchPage extends StatefulWidget {
  static const routeName = '/search';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                            (route) => false);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
              ],
            ),
            const SizedBox(height: 8,),
            ChangeNotifierProvider(
              create: (_) =>
                  SearchRestaurantProvider(
                      searchApiService: SearchApiService()),
              child: SearchWidget(),
            ),
            const SizedBox(height: 30,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: ChangeNotifierProvider<SearchRestaurantProvider>(
                  create: (_) => SearchRestaurantProvider(searchApiService: SearchApiService()),
                  child: RestaurantSearch(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}