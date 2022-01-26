import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:restaurant_app/page/favorit_page.dart';
import 'package:restaurant_app/page/search_page.dart';
import 'package:restaurant_app/page/setting_page.dart';

import 'package:restaurant_app/widget/restaurant_list.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: (){
              Navigator.pushNamed(context, FavoritPage.routeName);
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, SettingPage.routeName);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: OfflineBuilder(
          connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
          ) {
            final bool connected = connectivity != ConnectivityResult.none;
            return Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  height: 28.0,
                  left: 0.0,
                  right: 0.0,
                  child: connected
                      ? Visibility(
                          visible: true,
                          child: Container(),
                        )
                      : Container(
                          color: Colors.red,
                          child: const Center(
                            child: Text(
                              "Loss Connection",
                            ),
                          ),
                        ),
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: RestaurantList(),
                  ),
                ),
              ],
            );
          },
          child: Container(),
        ),
      ),
    );
  }

}
