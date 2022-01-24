import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/page/detail_page.dart';
import 'package:restaurant_app/page/favorit_page.dart';
import 'package:restaurant_app/page/search_page.dart';
import 'package:restaurant_app/page/setting_page.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/service/api_service.dart';
import 'package:restaurant_app/styles/styles.dart';
import 'package:restaurant_app/page/home_page.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/db/database_helper.dart';
import 'package:restaurant_app/provider/list_provider.dart';
import 'package:restaurant_app/provider/search_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GetRestaurantProvider>(
          create: (_) => GetRestaurantProvider(getApiService: ApiService()),
        ),
        ChangeNotifierProvider<SearchRestaurantProvider>(
          create: (_) => SearchRestaurantProvider(searchApiService: ApiService()),
        ),
        ChangeNotifierProvider<DatabaseProvider>(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
      ],
      child: MaterialApp(
      title: 'Restaurant App',
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: primaryColor,
          onPrimary: Colors.blue,
          secondary: secondaryColor,
        ),
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        DetailPage.routeName: (context) => DetailPage(
          restaurant: ModalRoute.of(context)?.settings.arguments as Restaurant,
        ),
        SearchPage.routeName: (context) => const SearchPage(),
        FavoritPage.routeName : (context) => const FavoritPage(),
        SettingPage.routeName : (context) => SettingPage(),
      },
    ),
    );
  }
}

